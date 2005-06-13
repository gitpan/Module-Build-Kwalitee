package Module::Build::Kwalitee;
use strict;
use warnings;

use base 'Module::Build';

=head1 NAME

Module::Build::Kwalitee

=head1 DESCRIPTION

This is not really Module::Build::Kwalitee; it is just a stub
shipped with distributions using Moudle::Build::Kwalitee to
provide boilerplate tests. This stub is here to get around the
bootstrapping problem associated with subclassing  Module::Build.
It simply adds the dependencies for Module::Build::Kwalitee's
tests.

=cut

# add extra build requirements
sub build_requires {
  my $self = shift;
  return {
    %{ $self->SUPER::build_requires },
    'File::Find::Rule' => 0,
    'Test::More' => 0,
    'Test::Pod' => 0,
    'Pod::Coverage::CountParents' => 0,
  };
}

1;
