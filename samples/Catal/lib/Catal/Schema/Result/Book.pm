package Catal::Schema::Result::Book;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("book");
__PACKAGE__->add_columns(
  "isbn",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 17,
  },
  "title",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "price",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "publish",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "published",
  { data_type => "DATE", default_value => undef, is_nullable => 0, size => 10 },
);
__PACKAGE__->set_primary_key("isbn");
__PACKAGE__->add_unique_constraint("title_key", ["title"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mncjVuf2/eRrUb0OUvn+eg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->has_many(book_review => 'Catal::Schema::Result::Review', 'isbn');
__PACKAGE__->many_to_many(reviews => 'book_review', 'usr');

1;
