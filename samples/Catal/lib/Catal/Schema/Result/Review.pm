package Catal::Schema::Result::Review;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("review");
__PACKAGE__->add_columns(
  "isbn",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 17,
  },
  "uid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 10,
  },
  "body",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 0,
    size => 65535,
  },
  "updated",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("isbn", "uid");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c+noeU+zQcVPm+O4vjER/A


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->belongs_to(book => 'Catal::Schema::Result::Book', 'isbn');
__PACKAGE__->belongs_to(usr  => 'Catal::Schema::Result::Usr',  'uid');

1;
