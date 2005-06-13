#!perl
use strict;
use warnings;

use Module::Build;

Module::Build->new(
  license => 'perl',
  module_name => 'Module::Build::Kwalitee',
  requires => {
    'YAML' => 0,
    'Module::Build' => '0.26',
    'File::Find::Rule' => 0,
    'Test::More' => 0,
    'Test::Pod' => 0,
    'Pod::Coverage::CountParents' => 0,
  },
  create_makefile_pl => 'passthrough',
  recursive_test_files => 1,
  create_readme => 1,
  add_to_cleanup => [qw( 
    t/000compile.t 
    t/001strict.t 
    t/002warnings.t 
    t/003pod.t 
    t/004uselib.t 
  )],
)->create_build_script;

