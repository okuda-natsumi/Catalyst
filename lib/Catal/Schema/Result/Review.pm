use utf8;
package Catal::Schema::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catal::Schema::Result::Review

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

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 isbn

  data_type: 'varchar'
  is_nullable: 0
  size: 17

=head2 uid

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 body

  data_type: 'text'
  is_nullable: 0

=head2 updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "isbn",
  { data_type => "varchar", is_nullable => 0, size => 17 },
  "uid",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "body",
  { data_type => "text", is_nullable => 0 },
  "updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</isbn>

=item * L</uid>

=back

=cut

__PACKAGE__->set_primary_key("isbn", "uid");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-03 15:34:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:n4d25ZLNaNDu2Ltq3fOcAg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
