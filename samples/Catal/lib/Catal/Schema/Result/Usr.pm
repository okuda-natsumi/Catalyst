package Catal::Schema::Result::Usr;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("usr");
__PACKAGE__->add_columns(
  "uid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 10,
  },
  "passwd",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 32 },
  "unam",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "roles",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
);
__PACKAGE__->set_primary_key("uid");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ttUQBXswH3DXJdFGnA2oRA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->has_many(usr_review => 'Catal::Schema::Result::Review', 'uid');
__PACKAGE__->many_to_many(books => 'usr_review', 'book');
__PACKAGE__->has_many(map_user_roles => 'Catal::Schema::Result::UsrRole', 'uid');
__PACKAGE__->many_to_many(roles => 'map_user_roles', 'role');

1;