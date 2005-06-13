#!/usr/bin/perl
#
# Make sure no tests contain 'use lib', which confuses Devel::Cover a lot.
# If you want "prove t/test.t" to just work, use "prove -l".

use strict;
use warnings;
our @test;

BEGIN {
  use File::Find::Rule;
  @test = File::Find::Rule->file()->name('*.t')->in('t');
}

use Test::More tests => scalar @test;

foreach my $test ( @test ) {
  my $fh;
  local $/ = undef;
  open $fh, $test;
  my $file = <$fh>;
  if ($file =~ m/\nuse\s+lib(.*?);/m) {
    my @list = grep {defined $_} eval $1;
    if (grep { !m/\bt\b/ } @list) {
      diag "found ".join(',',@list)." in $test";
      ok(0, $test);
      next;
    }
  }
  ok(1, $test);
}
