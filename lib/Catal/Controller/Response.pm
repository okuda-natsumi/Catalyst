package Catal::Controller::Response;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

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

    $c->response->body('test');
}

sub hoge :Local {
  my ( $self, $c ) = @_;
  $c->response->body('hogehoge');
}

sub auth :Local {
  my ( $self, $c ) = @_;
  my $auth = $c->req->header('Authorization');
  if ($auth eq '') {
    $c->response->status(401);
    $c->response->header('WWW-Authenticate' => 'Basic realm="catalyst"');
    $c->response->body('このページのアクセスには認証が必要です');
  } else {
    my @usr = split /:/, decode_base64(substr($auth, 6));
    if ($usr[0] ne 'admin_usr' || $usr[1] ne 'admin_pass') {
      $c->response->body('ユーザ名、パスワードが間違っています');
    }
  }
}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
