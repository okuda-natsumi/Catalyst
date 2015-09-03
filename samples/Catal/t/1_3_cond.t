use strict;
use warnings;
use Test::More;

SKIP: {
	eval { require MyApp::Special };
	skip 'MyApp::Special not installed', 1 if $@;

	my $obj = new MyApp::Special();
	ok($obj->hoge(), 'hoge_test');
}

TODO: {
	local $TODO = 'Pending';
	my $x;
	is($x, 99, 'is_test');
}

TODO: {
	todo_skip('not_implemented', 1);
	# local $TODO = 'not_implemented';
	ok(hoge(99), 'ok_test');
}

# BAIL_OUT('Connection Error');

done_testing;
