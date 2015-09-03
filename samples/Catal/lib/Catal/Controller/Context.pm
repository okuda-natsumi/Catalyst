package Catal::Controller::Context;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Catal::Controller::Context - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catal::Controller::Context in Context.');
}

sub log_basic :Local {
  my ( $self, $c ) = @_;
  my $l = $c->log();
  $l->fatal('Fatal Log');
  $l->error('Error Log');
  $l->warn('Warn Log');
  $l->info('Info Log');
  $l->debug('Debug Log');
  $c->response->body('ログはコンソールから確認してください。');
}

sub conf :Local {
  my ( $self, $c ) = @_;
  $c->response->body('アプリケーション名：' . $c->config->{name});
}

sub pathto :Local {
  my ( $self, $c ) = @_;
  $c->response->body($c->path_to('conf', 'my', 'dbic.ini'));
}

sub urifor :Local {
  my ( $self, $c ) = @_;
  my $msg;
  $msg  = $c->uri_for . '<br />';
  $msg .= $c->uri_for('/static/images/catalyst_logo.png') . '<br />';
  $msg .= $c->uri_for($c->action) . '<br />';
  $msg .= $c->uri_for($c->action, 
    @{ $c->req->args }, $c->req->query_params) . '<br />';
  $msg .= $c->uri_for('/book/details', 'mvc', '978-4-7980-2401-1',
    { charset => 'utf8' });
  $c->response->body($msg);
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
