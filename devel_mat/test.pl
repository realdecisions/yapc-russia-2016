#!perl

use strict;
use warnings;
use Devel::MAT::Dumper;

my $a = { big_scalar => '', };

vec( $a->{big_scalar}, 8e+8, 8 ) = 0;

Devel::MAT::Dumper::dump('./test.pl.pmat');

__DATA__
pmat-explore-gtk test.pl.pmat
pmat-sizes test.pl.pmat
pmat-largest-svs test.pl.pmat
pmat-find-pv test.pl.pmat addr
etc...
