#!/usr/bin/perl
#
# Make sure every module contains 'use strict' and 'use warnings'

use strict;
use warnings;

use Test::More;
use Module::Build::Kwalitee::Util;

my @classes = module_files();

plan tests => 2 * scalar @classes;

foreach my $class ( @classes ) {
  my $fh;
  local $/ = undef;
  open $fh, $class;
  my $file = <$fh>;
  ok($file =~ qr/use\s+strict\b/, "$class using strict");
  ok($file =~ qr/use\s+warnings\b/, "$class using warnings");
}
