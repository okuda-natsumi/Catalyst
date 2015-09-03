package Catal::Model::BookAdaptor;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Catal::Api::Book',
#    class       => 'Catal::Api::Test::Book',
    constructor => 'new',
);

1;
