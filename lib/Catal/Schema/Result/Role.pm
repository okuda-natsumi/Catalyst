use utf8;
package Catal::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catal::Schema::Result::Role

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

=head1 TABLE: C<role>

=cut

__PACKAGE__->table("role");

=head1 ACCESSORS

=head2 rid

  data_type: 'integer'
  is_nullable: 0

=head2 role

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "rid",
  { data_type => "integer", is_nullable => 0 },
  "role",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</rid>

=back

=cut

__PACKAGE__->set_primary_key("rid");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-03 15:34:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bnxRz2NGY4xsM/HqpNNgsg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
