#!/usr/bin/perl
#
# Make sure every module contains 'use strict'

use strict;
use warnings;
our @classes;

BEGIN {
  use File::Find::Rule;
  @classes = File::Find::Rule->file()->name('[A-Z]*.pm')->in('lib');
}

use Test::More tests => scalar @classes;

foreach my $class ( @classes ) {
  my $fh;
  local $/ = undef;
  open $fh, $class;
  my $file = <$fh>;
  ok($file =~ qr/use\s+strict/, $class);
}
