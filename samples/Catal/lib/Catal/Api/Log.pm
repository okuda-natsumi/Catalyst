package Catal::Api::Log;

use Moose::Role;

before execute => sub {
  my ($self, $controller, $c) = @_;
  $c->log->debug('Action Start2!');
};

after execute => sub {
  my ($self, $controller, $c) = @_;
  $c->log->debug('Action Finish2!');
};


#around execute => sub {
#  my ($code, $self, $controller, $c) = @_;
#  $c->log->debug('Action Start2!');
#  $code->($self, $controller, $c);
#  $c->log->debug('Action Finish2!');
#};

1;