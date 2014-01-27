use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/App/ZofCMS.pm',
    'lib/App/ZofCMS/Config.pm',
    'lib/App/ZofCMS/Output.pm',
    'lib/App/ZofCMS/Plugin.pm',
    'lib/App/ZofCMS/Template.pm'
);

notabs_ok($_) foreach @files;
done_testing;
