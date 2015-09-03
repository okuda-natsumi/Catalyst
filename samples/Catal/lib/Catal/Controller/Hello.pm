package Catal::Controller::Hello;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Hello - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Hello in Hello.');
}

sub intro :Local {
  my ( $self, $c ) = @_;
  $c->response->body('こんにちは、世界！');
}

sub introView :Local {
  my ( $self, $c ) = @_;
  $c->stash->{msg} = 'こんにちは、世界！';
}

sub list :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')->all];
  # $c->model('CatalDB')->storage->debug(1);
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
