#!perl

use Devel::FindRef;

my $track_me = "TestContent";

my %deep_hash = (
	very => {
		deep => {
			path => \$track_me
		}
	}
);

my $sub = sub {
	$track_me;
};


print Devel::FindRef::track \$track_me;


