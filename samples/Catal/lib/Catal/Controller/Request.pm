package Catal::Controller::Request;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Encode;

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

    $c->response->body('Matched Catal::Controller::Request in Request.');
}

sub form :Local { }

sub process :Local {
  my ( $self, $c ) = @_;
  $c->stash->{nam} = $c->request->body_params->{'nam'};
}

sub multiForm :Local {  }

sub multiProcess :Local {
  my ( $self, $c ) = @_;
  my $fw = $c->request->body_params->{'fw'};
  $c->stash->{fw} = join ',', @$fw;
#$c->stash->{fw} = $c->request->body_params->{'fw'};

}

sub upload :Local { }

sub uploadProcess :Local {
  my ( $self, $c ) = @_;
  my $_msg;
  my $upload = $c->req->upload('upfile');
	my $file = $upload->filename;
	my $base = substr $file, (rindex $file, '\\') + 1;
	my $ext = lc substr $base, (rindex $base, '.') + 1;
  my @perm = ('jpg', 'jpeg', 'gif', 'png');
  if(grep $_ eq $ext, @perm != 1) {
    $_msg = 'アップロードできるのは画像ファイルのみです。';
  } elsif ($upload->size > 1000000) {
    $_msg = 'ファイルサイズは1MBまでです。';
  } else {
     Encode::from_to($base, 'utf8', 'shiftjis');
    if ($upload->copy_to('./doc/' . $base)) {
      $_msg = $file . 'をアップロードしました。';
    } else {
      $_msg = '処理中にエラーが発生しました。';
    }
  }
  $c->response->body($_msg);
}

sub query :Local { }

sub queryProcess :Local {
  my ( $self, $c ) = @_;
  $c->stash->{nam} = $c->request->query_params->{'nam'};
}

sub list :Local {
  my ($self, $c) = @_;
  $c->stash->{list} = [$c->model('CatalDB::Book')->all];
}

sub detail :Local {
  my ($self, $c) = @_;
  $c->stash->{book} = $c->model('CatalDB::Book')
    ->find($c->request->query_params->{'isbn'});
    #->find($c->request->query_keywords);
    #->find($c->request->args->[0]);
}

#sub detail :Local {
#  my ($self, $c, $isbn) = @_;
#  $c->stash->{book} = $c->model('CatalDB::Book')->find($isbn);
#}

sub header :Local {
  my ( $self, $c ) = @_;
  my $req = $c->request;
  $c->response->body($req->header('User-Agent'));
  #$c->response->body($req->user_agent);
}

sub headers :Local {
  my ( $self, $c ) = @_;
  my $result;
  my $hs = $c->request->headers;
  foreach my $name ($hs->header_field_names) {
    $result .= $name . '：' . $hs->header($name).'<br />';
  }
  $c->response->body($result);
}

sub cookie :Local {
	my ( $self, $c ) = @_;
	my $email =  $c->request->cookie('email');
	$c->stash->{email} = $email ? $email->value : '';
}

sub cookieProcess :Local {
  my ( $self, $c ) = @_;
  $c->response->cookies->{email} = 
    {
      value => $c->request->body_params->{'email'},
      expires => '+3M',	
    };
  $c->response->body('クッキーを保存しました。');
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
