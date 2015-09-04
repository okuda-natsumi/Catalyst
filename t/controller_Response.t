use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catal';
use Catal::Controller::Response;

ok( request('/response')->is_success, 'Request should succeed' );
done_testing();
