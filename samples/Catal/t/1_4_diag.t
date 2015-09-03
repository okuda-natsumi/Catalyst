use strict;
use warnings;
use Test::More;

note('Test Start!');

my $zip = '421-00025';
like($zip, qr/^[0-9]{3}-[0-9]{4}$/, 'like test') or
	diag("Zip code ${zip} is invalid.");

my $member = [ 'Yamada', 'Hio', 'Kakeya' ];
diag(explain($member));

note('Test Finish!');

done_testing;
