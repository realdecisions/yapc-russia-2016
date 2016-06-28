#!perl

use strict;
use warnings;
use Scalar::Util qw/weaken/;
use Devel::Cycle -raw;

my $devel_cycle_test = {};

$devel_cycle_test->{hard_ref} = $devel_cycle_test;

$devel_cycle_test->{weak_ref} = $devel_cycle_test;
weaken( $devel_cycle_test->{weak_ref} );

$devel_cycle_test->{closure} = sub { #require PadWalker
    $devel_cycle_test;
};

print "\n\n\nfind_cycle:\n";
find_cycle($devel_cycle_test);
print "\n\n\nfind_weakened_cycle:\n";
find_weakened_cycle($devel_cycle_test);
