use strict;
use warnings;
use MyApp::MyModule;
use Test::More tests => 3;

is (add(2, 3), 5, 'Func add test 1');
is (add(10, -10), 0, 'Func add test 2');
is (add(1.5, 2.3), 3.8, 'Func add test 3');
