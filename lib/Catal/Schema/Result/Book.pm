use utf8;
package Catal::Schema::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catal::Schema::Result::Book

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<book>

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 isbn

  data_type: 'varchar'
  is_nullable: 0
  size: 17

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 price

  data_type: 'integer'
  is_nullable: 0

=head2 publish

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 published

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "isbn",
  { data_type => "varchar", is_nullable => 0, size => 17 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "price",
  { data_type => "integer", is_nullable => 0 },
  "publish",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "published",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</isbn>

=back

=cut

__PACKAGE__->set_primary_key("isbn");

=head1 UNIQUE CONSTRAINTS

=head2 C<title_key>

=over 4

=item * L</title>

=back

=cut

__PACKAGE__->add_unique_constraint("title_key", ["title"]);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-03 15:34:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h4oNlBQkqeuXtq2wBGrXMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
