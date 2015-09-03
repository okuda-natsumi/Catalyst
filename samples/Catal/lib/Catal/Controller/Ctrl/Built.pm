package Catal::Controller::Ctrl::Built;

use strict;
use warnings;
use DateTime;
use DateTime::Format::Strptime;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Ctrl::Built - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub default :Path { }

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  $c->response->body('Builtコントローラのトップページです。');
}

#sub begin :Private {
#  my ( $self, $c ) = @_;
#  my $start = DateTime->new(time_zone => 'local',
#    year => 2009, month => 12, day => 1);
#  my $end = DateTime->new(time_zone => 'local',
#    year => 2009, month => 12, day => 31);
#  my $dt = DateTime->now(time_zone => 'local');
#  if (DateTime->compare($start, $dt) == 1 ||
#     DateTime->compare($dt, $end) == 1) {
#    my $fmt = DateTime::Format::Strptime->new(pattern => '%Y年%m月%d日');
#    $c->response->body(sprintf('このページは%s～%sの期間のみ有効です。',
#      $fmt->format_datetime($start), $fmt->format_datetime($end)));
#    $c->response->status(403);
#    $c->detach();
#  }
#}

sub limit :Local {
  my ( $self, $c ) = @_;
  $c->response->body('有効期間中です。');
}

sub except :Local {
  my ( $self, $c ) = @_;
  $c->error('exceptアクションで意図的なエラーを発生');
}

sub end :Private {
  my ( $self, $c ) = @_;
  #$c->response->body('Builtコントローラのendアクションです。');
  $c->forward('Catal::Controller::Root', 'end');
}

#sub auto :Private {
#  my ( $self, $c ) = @_;
#}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
