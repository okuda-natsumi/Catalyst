package Catal::Schema::Result::Role;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("role");
__PACKAGE__->add_columns(
  "rid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "role",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
);
__PACKAGE__->set_primary_key("rid");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:66LFI1QuPNdUPRl2NRe7eg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->has_many(map_user_roles => 'Catal::Schema::Result::UsrRole', 'rid');

1;
