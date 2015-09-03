package Catal::Controller::Hello;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

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
  $c->response->body('HELLO!hoge');
}

sub introView :Local {
  my ( $self, $c ) = @_;
  $c->stash->{msg} = 'あいうえお!';
  warn $c->stash->{msg};
}

sub list :Local {
  my ( $self, $c ) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')->all];
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
