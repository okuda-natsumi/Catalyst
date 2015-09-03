use strict;
use warnings;
use Test::More;
use Test::Exception;

BEGIN { use_ok('MyApp::MyModule') }


dies_ok { triangle(-10, 5) } 'dies_ok test';
throws_ok { triangle(-10, 5) } qr/be positive/ ,'throws_ok test';

# lives_ok { triangle(-10, 5) } 'lives_ok test';

done_testing;