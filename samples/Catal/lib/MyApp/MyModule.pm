use strict;
use warnings;

sub add {
  my ($x, $y) = @_;
  return $x + $y;
}

sub triangle  {
  my ($base, $height) = @_;
  if ($base <=0 || $height <= 0) { die 'arguments must be positive.'; }
  return $base * $height / 2;
}

1;