package Catal::Controller::Filter;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Filter - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Filter in Filter.');
}

sub format :Local { }

sub uc_lc :Local { }

sub trim :Local { }

sub html :Local { }

sub uri :Local { }

sub break :Local { }

sub break2 :Local { }

sub indent :Local { }

sub truncate :Local { }

sub repeat :Local { }

sub repeat2 :Local { }

sub remove :Local { }

sub replace :Local { }

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
