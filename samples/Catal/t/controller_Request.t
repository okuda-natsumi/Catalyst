use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Request' }

ok( request('/request')->is_success, 'Request should succeed' );

my $req = POST(
  '/request/process',
  'Content' => [
    nam => '山田',
  ]
);
my ($res, $c) = ctx_request($req);
is($c->stash->{nam}, '山田', 'Post data check.');
diag($req->as_string);


done_testing;
