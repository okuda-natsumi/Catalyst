package Catal::Controller::Plugin;

use strict;
use warnings;
use DateTime;
use Config::General;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Plugin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Plugin in Plugin.');
}

sub session :Local {
  my ($self, $c) = @_;
  my $cnt = $c->session->{cnt} || 1;
    $c->response->body("あなたは${cnt}回アクセスしました。");
    $c->session->{cnt} = ++$cnt;
    
    $c->session_expire_key( name => 60 );
    $c->session->{name} = '山田';
    $c->session->{name2} = '掛谷';

}

sub sess_delete :Local {
	my ($self, $c) = @_;
	$c->delete_session('logouted');
	$c->response->body($c->session_delete_reason);
}

sub expire :Local {
	my ($self, $c) = @_;
	$c->response->body($c->session->{name} . ':' . $c->session->{name2});
}

sub change_session :Local {
  my ($self, $c) = @_;
  $c->session->{name} = 'ニンザブロウ';
  my $msg = $c->sessionid . '：' . $c->session->{name} . '<br />';
  $c->change_session_id;
  $msg .= $c->sessionid . '：' . $c->session->{name};
  $c->response->body($msg);
}

sub temp : Local {
  my ( $self, $c ) = @_;
  $c->flash->{msg} = 'flashデータです。';
  $c->response->redirect( $c->uri_for("temp_after") );
}

sub temp_after : Local {
  my ( $self, $c ) = @_;
  if(exists $c->flash->{msg}) {
    $c->response->body($c->flash->{msg});
  } else {
    $c->response->body('データは存在しません。');
  }
}

sub role :Local {
  my ( $self, $c ) = @_;
  if ($c->check_any_user_role( qw/admin/ )) {
    $c->response->body('管理者向けのコンテンツです。');
  } else {
    $c->response->body('一般ユーザ向けのコンテンツです。');
  }
}

sub validate_basic :Local {
  my ( $self, $c ) = @_;
  if ( $c->request->method eq 'POST' ) {
    if ( $c->form->has_error ) {
      $c->stash->{error} = $c->form;
    } else { 
      $c->response->body('検証に成功しました！');
    }
  }
}

sub validate :Local {
  my ( $self, $c ) = @_;
  $c->form(
    { mails => [qw/mail mail_confirm/] } => 'DUPLICATION',
  );
  if ( $c->request->method eq 'POST' ) {
    if ( $c->form->has_error ) {
      $c->stash->{error} = $c->form;
    } else { 
      $c->response->body('検証処理に成功しました。');
    }
  }
}
sub cache :Local {
  my ( $self, $c, $id ) = @_;
  my $cache = $c->cache;
  my $data;
  if ( $data = $cache->get( $id ) ) {
    $c->response->body("現在時刻は${data}です［${id}］：キャッシュ");
  } else {
    my $data = DateTime->now(time_zone => 'local');
    $c->cache->set($id, $data);
    $c->response->body("現在時刻は${data}です［${id}］：処理結果");
  }
}

sub cache_remove :Local {
  my ( $self, $c, $id ) = @_;
  my $cache = $c->cache;
    $c->cache->remove($id);
    $c->response->body("キャッシュを削除しました。");
}

sub pcache :Local {
  my ( $self, $c, $id ) = @_;
  my $data = DateTime->now(time_zone => 'local');
  $c->response->body("現在時刻は${data}です［${id}］");
}

sub qcache :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')
    ->search({}, {cache_for => 300})];
  $c->stash->{template} = 'list.tt';
}

sub i18n :Local { }

sub transform :Local {
  my ( $self, $c) = @_;
  Config::General->new->save_file('app.conf', $c->config);
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
