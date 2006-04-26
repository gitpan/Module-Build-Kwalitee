#!perl
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  license => 'perl',
  module_name => 'Module::Build::Kwalitee',
  requires => {
    'YAML' => 0,
    'Module::Build' => '0.2609',
    'File::Find::Rule' => 0,
    'Test::More' => 0,
    'Test::Pod' => 0,
  },
  recommends => {
    'Pod::Coverage::CountParents' => 0,
    'IPC::Open3' => 0,
  },
  t_files => {
    't/000compile.t' => 'lib/Module/Build/Kwalitee/000compile.t',
    't/001pragmas.t' => 'lib/Module/Build/Kwalitee/001pragmas.t',
    't/003pod.t' => 'lib/Module/Build/Kwalitee/003pod.t',
    't/004uselib.t' => 'lib/Module/Build/Kwalitee/004uselib.t',
  },
  recursive_test_files => 1,
  create_readme => 1,
);
$build->add_build_element('t');
$build->create_build_script;

