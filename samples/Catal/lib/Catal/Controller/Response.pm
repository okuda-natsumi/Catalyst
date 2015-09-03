package Catal::Controller::Response;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use DateTime;
use MIME::Base64;

=head1 NAME

Catal::Controller::Response - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Response in Response.');
}

sub forbidden :Local {
  my ( $self, $c ) = @_;
  $c->response->status(403);
  $c->response->body('このページへのアクセスは禁止されています。');
}

sub refresh :Local {
  my ( $self, $c ) = @_;
  $c->response->header('Refresh' => 5);
  my $dt = DateTime->now(time_zone => 'local');
  $c->stash->{now} = $dt->strftime('%Y年%m月%d日 %H時%M分%S秒')
}

sub auth :Local {
  my ( $self, $c ) = @_;
  my $auth = $c->request->header('Authorization');
  if ($auth eq '') {
    $c->response->status(401);
    $c->response->header('WWW-Authenticate' => 'Basic realm="catalyst"');
    $c->response->body('このページのアクセスには認証が必要です。');
  } else {
    my @usr = split /:/, decode_base64(substr($auth, 6));
    if ($usr[0] ne 'admin_usr' || $usr[1] ne 'admin_pass') {
      $c->response->body('ユーザ名／パスワードが間違っています。');
    }
  }
}

sub download :Local {
  my ($self, $c) = @_;
  $c->response->header(
    'Content-Type' => 'application/octet-stream',
    'Content-Disposition' => 'attachment; filename = "dl.csv"'
  );
  $c->stash->{list} = [$c->model('CatalDB::Book')->all];
}

sub cache :Local {
	my ($self, $c) = @_;
	my $dt = DateTime->now(time_zone => 'local');
	my $fmt = DateTime::Format::Strptime->new(
		pattern => '%a, %d %m %Y %H:%M:%S GMT');
	$c->response->header(
		'Expires' => 'Sun, 1 Jan 1970 00:00:00 GMT',
		'Last-Modified' => $fmt->format_datetime($dt),
		'Cache-Control' => 'no-store, no-cache, must-revalidate',
		'Cache-Control' => 'post-check=0, pre-check=0',
		'Pragma' => 'no-cache'
	);
	$c->response->body('.');
}

sub redirect :Local {
  my ($self, $c) = @_;
  $c->response->redirect('http://www.wings.msn.to/');
  #$c->response->redirect('http://www.wings.msn.to/', 301);

}

sub body :Local {
  my ($self, $c) = @_;
  $c->response->body('X');
  $c->response->body('Y');
}

sub write :Local {
  my ($self, $c) = @_;
  $c->response->write('X');
  $c->response->write('Y');
  $c->response->body('Z');
}
=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
