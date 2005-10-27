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
  },
  recommends => {
    'Pod::Coverage::CountParents' => 0,
  },
  create_makefile_pl => 'traditional',
  recursive_test_files => 1,
  create_readme => 1,
)->create_build_script;

