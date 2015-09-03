use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Resultset' }

my ($res, $c) = ctx_request('/resultset/adaptor');
ok( $res->is_success, 'Request should succeed' );

my $result = $c->stash->{list};
is (@$result, 9, 'Record count test');
is ($result->[0]->publish, 'インプレス', 'Field value test');

done_testing;

