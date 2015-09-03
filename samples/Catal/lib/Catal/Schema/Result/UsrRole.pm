package Catal::Schema::Result::UsrRole;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("usr_role");
__PACKAGE__->add_columns(
  "uid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 10,
  },
  "rid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("uid", "rid");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xlNFDsrvnpVgSNfvJZvSxA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->belongs_to(user => 'Catal::Schema::Result::Usr', 'uid');
__PACKAGE__->belongs_to(role => 'Catal::Schema::Result::Role', 'rid');

1;
