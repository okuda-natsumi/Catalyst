use strict;
use warnings;
use MyApp::MyModule;
use Test::Base;
plan tests => 1 * blocks;

filters {
  x        => [qw/chomp trim/],
  y        => [qw/chomp trim/],
  expected => [qw/chomp trim/],
};

run {
  my $d = shift;
  my $result = add($d->x, $d->y);
  is($result, $d->expected);
};

__END__

=== add test 1
--- x: 2
--- y: 3
--- expected: 5

=== add test 2
--- x: 10
--- y: -10
--- expected: 0

=== add test 3
--- x: 1.5
--- y: 2.3
--- expected: 3.8
