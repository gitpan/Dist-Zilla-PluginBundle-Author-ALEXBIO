package Dist::Zilla::PluginBundle::Author::ALEXBIO;
BEGIN {
  $Dist::Zilla::PluginBundle::Author::ALEXBIO::VERSION = '0.02';
}

use Moose;

use Dist::Zilla;

use Dist::Zilla::Plugin::Git;
use Dist::Zilla::Plugin::GitHub;
use Dist::Zilla::Plugin::ChangelogFromGit;

use Dist::Zilla::Plugin::InstallRelease;

use warnings;
use strict;

with 'Dist::Zilla::Role::PluginBundle::Easy';

=head1 NAME

Dist::Zilla::PluginBundle::Author::ALEXBIO - ALEXBIO's default Dist::Zilla config

=head1 VERSION

version 0.02

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

    [PodVersion]
    [PkgVersion]

    [ChangelogFromGit]
    tag_regexp = ^v
    file_name   = Changes

    [Git::Tag]
    tag_message = %N %v

    [Git::Push]

    [InstallRelease]
    install_command = cpanm .

=cut

sub configure {
	my $self = shift;

	# basic bundle
	$self -> add_bundle(
		'Basic'
	);

	# github bundle
	$self -> add_bundle(
		'GitHub'
	);

	# core plugins
	$self -> add_plugins(
		'MetaConfig',
		'MetaJSON',
		'AutoPrereqs',
		'PodVersion',
		'PkgVersion'
	);

	# git plugins
	$self -> add_plugins(
		['ChangelogFromGit' => {
			tag_regexp => '^v',
			file_name  => 'Changes'
		}],

		['Git::Tag' => {
			tag_message => '%N %v'
		}],

		'Git::Push'
	);

	$self -> add_plugins(
		['InstallRelease' => {
			install_command => 'cpanm .'
		}]
	);
}

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Dist::Zilla::PluginBundle::Author::ALEXBIO