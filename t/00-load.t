#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dist::Zilla::PluginBundle::Author::ALEXBIO' ) || print "Bail out!
";
}

diag( "Testing Dist::Zilla::PluginBundle::Author::ALEXBIO $Dist::Zilla::PluginBundle::Author::ALEXBIO::VERSION, Perl $], $^X" );
