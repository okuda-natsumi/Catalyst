package Catal::Model::DateTimeAdaptor;
use strict;
use warnings;
use base 'Catalyst::Model::Factory::PerRequest';
# use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Catal::Api::DateTime',
    constructor => 'now',
  args => {
    time_zone => 'local',
    pattern => '%H時%M分%S秒'
  }
);

1;
