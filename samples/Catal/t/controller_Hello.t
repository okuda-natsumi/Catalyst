use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Catal' }
BEGIN { use_ok 'Catal::Controller::Hello' }

my $res = request('/hello/introView');
ok( $res->is_success, 'Request should succeed' );
like($res->content, qr/こんにちは、世界！/, 'Message Check.');

#action_ok('/hello/introView', 'Request should succeed');
#content_like('/hello/introView', qr/こんにちは、世界！/, 'Message Check.');

#my ($res, $c) = ctx_request('/hello/introView');
#is($c->stash->{msg}, 'こんにちは、世界！', 'Message Check.');

done_testing;

