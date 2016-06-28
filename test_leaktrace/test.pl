#!perl

use strict;
use warnings;
use Test::LeakTrace;
use Scalar::Util;
use Devel::Cycle -raw;

{
    leaktrace {
        my $a = {};
        $a->{sub} = sub {
            $a;
        };
    }
    -lines;
}
