package Dist::Zilla::PluginBundle::Author::ALEXBIO;
{
  $Dist::Zilla::PluginBundle::Author::ALEXBIO::VERSION = '1.0';
}
{
  $Dist::Zilla::PluginBundle::Author::ALEXBIO::VERSION = '0.08';
}

use Moose;
use Dist::Zilla;

use warnings;
use strict;

with 'Dist::Zilla::Role::PluginBundle::Easy';

has 'makemaker' => (
	is      => 'ro',
	isa     => 'Bool',
	lazy    => 1,
	default => sub {
			defined $_[0] -> payload -> {makemaker} ?
				$_[0] -> payload -> {makemaker} : 1
		}
);

has 'fake_release' => (
	is      => 'ro',
	isa     => 'Bool',
	lazy    => 1,
	default => sub {
			defined $_[0] -> payload -> {fake_release} ?
				$_[0] -> payload -> {fake_release} : 0
		}
);

has 'pod_coverage' => (
	is      => 'ro',
	isa     => 'Bool',
	lazy    => 1,
	default => sub {
			defined $_[0] -> payload -> {pod_coverage} ?
				$_[0] -> payload -> {pod_coverage} : 1
		}
);

=head1 NAME

Dist::Zilla::PluginBundle::Author::ALEXBIO - ALEXBIO's default Dist::Zilla config

=head1 VERSION

version 0.08

=head1 SYNOPSIS

Synopsis section

    # in dist.ini
    [@Author::ALEXBIO]

=head1 DESCRIPTION

B<Dist::Zilla::PluginBundle::Author::ALEXBIO> is a L<Dist::Zilla> plugin bundle,
equivalent to the following:

    [@Basic]
    [@GitHub]

    [MetaConfig]
    [MetaJSON]

    [AutoPrereqs]

    [Git::NextVersion]

    [PodVersion]
    [PkgVersion]

    [Test::Compile]
    [Test::CheckManifest]
    [PodSyntaxTests]
    [PodCoverageTests]

    [ChangelogFromGit]
    file_name   = Changes

    [Git::Tag]
    tag_message = %N %v

    [Git::Push]

    [InstallRelease]
    install_command = cpanm .

    [Clean]

=cut

sub configure {
	my $self = shift;

	# @Basic plugins but MakeMaker and UploadToCPAN
	$self -> add_plugins(
		'GatherDir',
		'PruneCruft',
		'ManifestSkip',
		'MetaYAML',
		'License',
		'Readme',
		'ExtraTests',
		'ExecDir',
		'ShareDir',
		'Manifest',
		'TestRelease',
		'ConfirmRelease',
	);

	# use MakeMaker if requested
	if ($self -> makemaker) {
		$self -> add_plugins(
			'MakeMaker'
		);
	}

	# github bundle
	$self -> add_bundle(
		'GitHub' => { metacpan => 1 }
	);

	# bump version
	$self -> add_plugins(
		['Git::NextVersion' => { first_version => 0.01 }],
	);

	# core plugins
	$self -> add_plugins(
		'MetaConfig',
		'MetaJSON',
		'AutoPrereqs',
		'PodVersion',
		'PkgVersion'
	);

	$self -> add_plugins(
		['ChangelogFromGit' => { file_name  => 'Changes' }],
	);

	# test plugins
	$self -> add_plugins(
		'Test::Compile',
		'Test::CheckManifest',
		'PodSyntaxTests'
	);

	if ($self -> pod_coverage) {
		$self -> add_plugins(
			'PodCoverageTests'
		);
	}

	# release plugins
	if ($self -> fake_release) {
		$self -> add_plugins( 'FakeRelease' );
	} else {
		$self -> add_plugins(
			['Git::Tag' => { tag_message => '%N %v' }],
			'Git::Push',
			'UploadToCPAN'
		);
	}

	# after release
	$self -> add_plugins(
		['InstallRelease' => { install_command => 'cpanm .' }],
		'Clean'
	);
}

=head1 ATTRIBUTES

=over

=item C<makemaker>

If set to '1' (default), the C<MakeMaker> plugin is used.

=item C<fake_relase>

If set to '1', the release will be faked using the C<FakeRelease> plugin.

=back

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

no Moose;

__PACKAGE__ -> meta -> make_immutable;

1; # End of Dist::Zilla::PluginBundle::Author::ALEXBIO
