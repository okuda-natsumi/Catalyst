package Catal::View::TT;

use strict;
use warnings;
use Encode;
use base 'Catalyst::View::TT';

__PACKAGE__->config(
  TEMPLATE_EXTENSION => '.tt',
  # WRAPPER => 'master.tt',
  # COMPILE_DIR => './tmp',
  # COMPILE_EXT => '.ttc',
   FILTERS => {
     'mailto' => [ \&mailto_filter, 0 ],
     'default' => [ \&default_filter_factory, 1 ],
     'utf8' => [ \&utf8_filter, 0 ],
   },
  
  # FILTERS => {
    # 'mailto' => sub  {
      # my $text = shift;
      # return sprintf('<a href="mailto:%s">%s</a>', $text, $text);
    # }
  # },
  
);

sub mailto_filter {
  my $text = shift;
  return sprintf('<a href="mailto:%s">%s</a>', $text, $text);
}

sub default_filter_factory {
  my ($context, $def) = @_;
  $def = '' unless defined $def;
  return sub {
    my $text = shift;
    $text = '' unless defined $text;
    return $def unless $text;
  }
}

sub utf8_filter {
  my $text = shift;
  return encode('utf8', $text);
}

=head1 NAME

Catal::View::TT - TT View for Catal

=head1 DESCRIPTION

TT View for Catal.

=head1 SEE ALSO

L<Catal>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
