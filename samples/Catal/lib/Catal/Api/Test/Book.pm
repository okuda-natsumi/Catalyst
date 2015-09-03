package Catal::Api::Test::Book;

use strict;
use warnings;
use DateTime;

sub new {
  my ($class, $isbn, $title, $price, $publish, $published) = @_;
  return bless {
    isbn => $isbn, title => $title, price => $price,
    publish => $publish, published => $published
  }, $class;
}

sub isbn      { shift->{isbn} }
sub title     { shift->{title} }
sub price     { shift->{price} }
sub publish   { shift->{publish} }
sub published { shift->{published} }

sub getInfosByPublish {
	my ($self, $publish) = @_;
	my @result = ();
	for(my $i = 1; $i < 10; $i++) {
		push @result,
			new Catal::Api::Test::Book(
				'978-4-0000-0000-' .$i,
				'書籍タイトル' . $i,
				2000 + $i,
				$publish,
				DateTime->new(time_zone => 'local', year => 2010,
					month => 10, day => $i),
			);
	}
	return \@result;
}

1;