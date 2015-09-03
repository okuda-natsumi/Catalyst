use strict;
use warnings;
use Encode;

BEGIN { unshift @INC, 'C:/data/Catal/lib'; }

use Catal::Api::Book;

my $bok = Catal::Api::Book->new();
my $result = $bok->getInfosByPublish('インプレス');

foreach my $item (@$result) {
  my $t = $item->title;
  Encode::from_to($t, 'utf8', 'shiftjis');
  my @line = ($item->isbn, $t, $item->price);
  print join(' | ', @line) . "\n";
}
