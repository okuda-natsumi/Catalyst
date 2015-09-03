package Catal::Controller::Ctrl::Attr;

use strict;
use warnings;
use parent 'Catalyst::Controller';

# __PACKAGE__->config->{namespace} = 'win/sample';

=head1 NAME

Catal::Controller::Ctrl::Attr - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Ctrl::Attr in Ctrl::Attr.');
}

sub intro :Local {
  my ( $self, $c ) = @_;
  $c->response->body('こんにちは、世界！');
}

sub intro2 :Global {
  my ( $self, $c ) = @_;
  $c->response->body('Global属性の例です！');
}

sub path_attr :Path('/hoge-foo') {
# sub path_attr :Path('hoge-foo') {
  my ( $self, $c ) = @_;
  $c->response->body('Path属性の例です！');
}

sub regex_attr :Regex('^article/(\d{4})\.html$') {
# sub regex_attr :LocalRegex('^article/(\d{4})\.html$') {
  my ( $self, $c ) = @_;
  my $num = $c->request->captures->[0];
  $c->response->body("記事番号：${num}");
  # $c->forward('Catal::Controller::Hello', 'intro');

}

sub regex_attr2 :Regex('article/(\d{4})\.html') {
  my ( $self, $c ) = @_;
  my $num = $c->request->captures->[0];
  $c->response->body("［regex_attr2］記事番号：${num}");
}

sub regex_attr3 :LocalRegex('(.*)/article/(\d{4})\.html$') {
  my ( $self, $c ) = @_;
  my $keywd = $c->request->captures->[0];
  my $num = $c->request->captures->[1];
  $c->response->body("キーワード：${keywd} <br />記事番号：${num}");
}

sub private_attr :Private {
  my ( $self, $c ) = @_;
  $c->response->body('Private属性の例です！');
}

sub args_attr :Path('/args') :Args(2) {
  my ( $self, $c ) = @_;
  my $args = $c->request->args;
  $c->response->body('パス情報：' . join(',', @$args));
}

sub chain_top :Chained('/') :PathPart('first') :CaptureArgs(0) {
# sub chain_top :Chained:PathPart('first') :CaptureArgs(0) {
  my ( $self, $c ) = @_;
  $c->stash->{body} = '<p>chain_topアクション</p>';
}

sub chain_second :Chained('chain_top') :PathPart('second') :CaptureArgs(1) {
  my ( $self, $c, $id ) = @_;
  $c->stash->{body} .= "<p>chain_secondアクション：${id} </p>";
#  my ( $self, $c) = @_;
#  my $id =$c->request->captures->[0];
#  $c->stash->{body} .= "<p>chain_secondアクション：${id} </p>";
}

sub chain_third :Chained('chain_second') :PathPart('third') {
  my ( $self, $c ) = @_;
  $c->stash->{body} .= '<p>chain_thirdアクション</p>';
  $c->response->body($c->stash->{body});
}

sub chain_path :Chained('chain_second') :PathPart {
  my ( $self, $c ) = @_;
  $c->stash->{body} .= '<p>chain_pathアクション</p>';
  $c->response->body($c->stash->{body});
}

sub chain_args :Chained('chain_second') :PathPart('args'):Args(2) {
  my ( $self, $c , $first, $second) = @_;
  $c->stash->{body} .= "<p>chain_argsアクション：${first}, ${second}</p>";
  $c->response->body($c->stash->{body});
}

sub chain_prefix :Chained('chain_second') :PathPrefix {
  my ( $self, $c ) = @_;
  $c->stash->{body} .= '<p>chain_prefixアクション</p>';
  $c->response->body($c->stash->{body});
}

sub chain_parent :ChainedParent :PathPart('child') {
  my ( $self, $c ) = @_;
  $c->stash->{body} .= '<p>chain_parentアクション［Ctrl/Attr］</p>';
  $c->response->body($c->stash->{body});
}

sub note_base : Chained('/') :PathPart('memo') CaptureArgs(0) {
  my ( $self, $c ) = @_;
  $c->stash->{memo} = $c->model('CatalDB::Memo');
}

sub note_all :  Chained('note_base') :PathPart('all') :Args(0) {
  my ( $self, $c ) = @_;
  $c->stash->{list} = [$c->stash->{memo}
    ->search({ }, { order_by => { -asc => 'updated' } })];
}

sub note_create : Chained('note_base') :PathPart('create') :Args(0) {
  my ( $self, $c ) = @_;
  if ($c->req->method eq 'POST') {
    $c->forward('note_validate');
    if ( scalar @{ $c->stash->{errors}} ) { $c->go('note_error'); }
    $c->stash->{memo}->create({
      title  => $c->request->body_params->{title},
      body   => $c->request->body_params->{body},
      updated=> \'NOW()'
    });
    $c->response->redirect($c->uri_for('/memo/all'), 303);
  }
}

sub note_details : Chained('note_base') :PathPart('') :CaptureArgs(1) {
  my ( $self, $c, $mid) = @_;
  $c->stash->{item} = $c->stash->{memo}->find($mid);
  if (!$c->stash->{item}) {
    $c->response->body("not found memo ${mid}.");
    $c->detach();
  }
}

sub note_show : Chained('note_details') :PathPart('') :Args(0) { }

sub note_edit   : Chained('note_details') :PathPart('edit') :Args(0) {
  my ( $self, $c ) = @_;
  if ($c->req->method eq 'POST') {
    $c->forward('note_validate');
    if ( scalar @{ $c->stash->{errors}} ) { $c->go('note_error'); }
    my $row = $c->stash->{item};
    $row->title($c->request->body_params->{title});
    $row->body($c->request->body_params->{body});
    $row->updated(\'NOW()');
    $row->update;
    $c->response->redirect($c->uri_for('/memo/all'), 303);
  }
}

sub note_delete : Chained('note_details') :PathPart('delete') :Args(0) {
  my ( $self, $c ) = @_;
  if ($c->req->method eq 'POST') {
    $c->stash->{item}->delete;
    $c->response->redirect($c->uri_for('/memo/all'), 303);
  }
  $c->response->body('アクセスが拒否されました。');
}

sub note_validate :Private {
  my ( $self, $c) = @_;
  my $p = $c->request->body_params;
  my @errs;
  push @errs, '件名が空です。' unless $p->{title};
  push @errs, '本文が空です。' unless $p->{body};
  $c->stash->{errors} = \@errs;
}

sub note_error :Private { }

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
