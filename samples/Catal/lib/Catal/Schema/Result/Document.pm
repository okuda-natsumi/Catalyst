package Catal::Schema::Result::Document;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("document");
__PACKAGE__->add_columns(
  "docid",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 5 },
  "doc",
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
__PACKAGE__->set_primary_key("docid");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-06 15:28:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aS8ft7/REdaq4dlAgzMc6Q


# You can replace this text with custom content, and it will be preserved on regeneration
use XML::Simple;
__PACKAGE__->inflate_column('doc', {
  inflate => sub { XMLin(shift) },
  deflate => sub { XMLout(shift,
    RootName => 'doc',
    NoAttr => 1); },
});

1;
