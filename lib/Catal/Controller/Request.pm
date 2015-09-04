package Catal::Controller::Request;
use Moose;
use namespace::autoclean;
use Encode;
use utf8;
use Carp::Reply qw(repl);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catal::Controller::Request - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    Carp::Reply::repl();  
    $c->response->body('Matched Catal::Controller::Request in Request.');
}

sub form :Local { }

sub process :Local {
  my ( $self, $c ) = @_;
  $c->stash->{nam} = $c->req->body_params->{'nam'};
}

sub multiForm :Local { }

sub multiProcess :Local {
  my ( $self, $c ) = @_;
  my $fw = $c->req->body_params->{'fw'};
  $c->stash->{fw} = $fw;
}

sub upload :Local { }

sub uploadProcess :Local {
  my ( $self, $c ) = @_;
  my $_msg;

  my $upload  = $c->req->upload('upfile');
  my $file    = $upload->filename;
  my $base    = substr $file, (rindex $file, '\\') + 1;
  my $ext     = lc substr $base, (rindex $base, '.') + 1;
  my @perm    = ('jpg', 'jpeg', 'gif', 'png');
  if (grep $_ eq $ext, @perm != 1) {
    $_msg = "画像ファイルのみです";
  } elsif ($upload->size > 1000000) {
    $_msg = "ファイルサイズは1MBまでです";
  } else {
    Encode::from_to($base, 'utf8', 'shiftjis');
    if ($upload->copy_to('./doc/' . $base)) {
      $_msg = $file . 'upload完了'
    } else {
      $_msg = '処理中にエラーが起こりました';
    }
  }
  $c->response->body($_msg);
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
