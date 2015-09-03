use strict;
use warnings;
use Test::More;

BEGIN { use_ok('Catal::Api::Book') }

my $bok = new Catal::Api::Book();
my $result = $bok->getInfosByPublish('インプレス');	

is (@$result, 3, 'Record count test');
is ($result->[0]->publish, 'インプレス', 'Field value test');

done_testing;