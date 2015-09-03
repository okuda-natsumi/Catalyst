use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('MyApp::MyModule') }

my $x = 2;
my $y = 3;
my $expected = 5;
my $result = add($x, $y);
is ($result, $expected, 'Func add test');
