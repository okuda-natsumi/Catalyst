use strict;
use warnings;
use Test::More;

my $hoge = 10;
ok(defined($hoge), 'ok test');

isnt('apple', 'apples', 'isnt test');

like('421-0002', qr/^[0-9]{3}-[0-9]{4}$/, 'like test');

cmp_ok(5, '<', 10, 'comp_ok test');

is_deeply([1, 2, 3], [1, 2, 3], 'is_deeply test');

BEGIN { use_ok('Digest::MD5', qw(md5 md5_hex md5_base64)) }

BEGIN { use_ok('DateTime') }
my $dt = DateTime->now();
can_ok($dt, qw(set truncate));

isa_ok($dt, 'DateTime');

#isa_ok([1, 2, 3], 'HASH');

#fail('fail test');

subtest 'subtest test' => sub {
  plan(tests => 1);
  pass('subtest1');
  #fail('subtest2');
};
done_testing;