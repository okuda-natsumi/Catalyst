package Catal::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Catal::Controller::Root - Root Controller for Catal

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub login :Local {
  my ($self, $c) = @_;
  my $uid = $c->request->params->{uid};
  my $passwd = $c->request->params->{passwd};

  if (defined($uid) && defined($passwd)) {
    if ($c->authenticate({ uid => $uid, passwd => $passwd })) {
      $c->response->body('こんにちは、'. $c->user->get('unam') . 'さん！');
    } else {
      $c->stash->{error} = 'ユーザ名、またはパスワードが間違っています。';
    }
  }
}

sub logout :Local {
  my ( $self, $c ) = @_;
  $c->logout;
  $c->response->redirect($c->uri_for('/'));
}

#sub auto : Private {
#  my ($self, $c) = @_;
#  if ($c->action->reverse eq 'login') { return 1; }
#  if (!$c->user_exists) {
#      $c->response->redirect($c->uri_for('/login'));
#      return 0;
#  }
#  return 1;
#}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
#  my ( $self, $c ) = @_;
#  if ( scalar @{ $c->error } ) {
#    $c->stash->{errors}   = $c->error;
#    $c->stash->{template} = 'errors.tt';
#    $c->clear_errors();
#  }
}

#sub auto : Private {
#  my ($self, $c) = @_;
#  if ($c->action->reverse eq 'login') { return 1; }
#  if (!$c->user_exists) {
#      $c->response->redirect($c->uri_for('/login'));
#      return 0;
#  }
#  return 1;
#}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
