use Module::Build::Kwalitee;
use Test::More tests => 9;

use File::Temp qw( tempdir );
use File::Find::Rule;
use File::Spec::Functions qw(catfile);

my $dir = tempdir( CLEANUP => 1 );

chdir $dir;

ok ! -d "t", 'no directory yet';

ok (my $build = Module::Build::Kwalitee->new(
  dist_name => 'Foo', 
  dist_version => '0.01',
  dist_author => 'Stig',
  dist_abstract => '',
), 'get a build object');

ok -d "t", "there's a test directory now";

my @files = File::Find::Rule->file()->name('00*.t')->in('t');
is scalar @files, 5, 'five test files present';

# check deps
my $deps = {
  'File::Find::Rule' => 0,
  'Test::More' => 0,
  'Test::Pod' => 0,
  'Pod::Coverage::CountParents' => 0,
};
is_deeply $build->build_requires, $deps, 'expected dependencies';


# now check distdir target
my $distdir = 'Foo-0.01';
is $build->dist_dir, $distdir, 'expected dist dir';

ok ! -d $distdir, 'distdir does not exist';
$build->ACTION_manifest;
$build->ACTION_distdir;
ok -d $distdir, 'distdir exists now';

ok -f catfile($distdir, qw(mbk Module Build Kwalitee.pm));

END {
  rmdir $distdir;
}
