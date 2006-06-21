#!perl
use strict;
use warnings;

# Jump through some hoops to use ourselves to install
use File::Spec::Functions;
use FindBin;
use lib catdir($FindBin::Bin, 'lib');
use Module::Build::Kwalitee;

my $build = Module::Build::Kwalitee->new(
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
  recursive_test_files => 1,
  create_readme => 1,
  create_makefile_pl => 'traditional',
);
$build->add_build_element('t');
$build->create_build_script;

