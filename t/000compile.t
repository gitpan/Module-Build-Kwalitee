#!/usr/bin/perl
#
# Make sure we can "use" every module

use strict;
use warnings;
use Test::More;
use File::Find::Rule;

eval q/use Test::Builder; 1;/
  or plan skip_all => 'Necessary modules not installed';
  
my @classes = 
  map  { path_to_pkg($_) }
  grep { !/00\d[a-z]+.pm/ }
  File::Find::Rule->file()->name('*.pm')->in('lib');

my @scripts;
eval q{
  use Module::Build;
  Module::Build->current->script_files;
  @scripts = keys %{ Module::Build->current->script_files };
};

push @scripts, grep { !/\.svn\b/ and !/~$/ } File::Find::Rule
    ->file()					# find all files
    ->in('bin') if -d 'bin';			# ... but only if there's a bin/ dir

@scripts = keys %{{ map { $_ => 1 } @scripts }};	# only check scripts once.

@scripts = grep { _perl_shebang($_) } @scripts;

sub _perl_shebang {
  my $file = shift;
  open FILE, $file or die "Can't read $file: $!";
  return <FILE> =~ /^#!.*\bperl/;
}

plan tests => scalar @classes + @scripts;

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

use Config;
foreach my $script (@scripts) {
  ok( ! system($Config{perlpath}, "-c", "-Mblib", $script), "$script" );
}

sub path_to_pkg ($) {
  for (shift) {
    s|.*lib/||;
    s|/|::|g;
    s|\.pm$||;
    return $_;
  }
}

