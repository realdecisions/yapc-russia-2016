#!perl
use strict;
use warnings;
use Devel::Size qw/size total_size/;

my $a = {
	big_scalar => ''
};
vec($a->{big_scalar}, 8e+8, 8) = 0;

print "Size:" . size($a) . "\n";
print "Total size:" . total_size($a) . "\n";