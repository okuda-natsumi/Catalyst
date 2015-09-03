use strict;
use warnings;

use Catal;

my $app = Catal->apply_default_middlewares(Catal->psgi_app);
$app;

