#!/usr/bin/perl
#
# Make sure we can "use" every module

use strict;
use warnings;

our @classes;

BEGIN {
  use File::Find::Rule;
  @classes = map { my $x = $_;
      $x =~ s|^lib/||;
      $x =~ s|/|::|g;
      $x =~ s|\.pm$||;
      $x;
    } File::Find::Rule->file()->name( '[A-Z]*.pm' )->in( 'lib' );
}

use Test::More tests => scalar @classes;
use Test::Builder;

# We need to tweak the numbers of the tests
my $test = Test::Builder->new;

foreach my $class ( @classes ) {
  unless (fork) {
    use_ok( $class );
    
    # Ok, now exit. Veeery important, unless we want to drive the load on the
    # machine to, say, 788.55. That would be bad.
    exit;
  }

  wait;
  warn "Child error: $?" if $?;

  $test->current_test( $test->current_test + 1 );
}
