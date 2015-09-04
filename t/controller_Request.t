use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catal';
use Catal::Controller::Request;

ok( request('/request')->is_success, 'Request should succeed' );
done_testing();
