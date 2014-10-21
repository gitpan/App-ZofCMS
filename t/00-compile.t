use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.039

use Test::More  tests => 76 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'App/ZofCMS.pm',
    'App/ZofCMS/Config.pm',
    'App/ZofCMS/Output.pm',
    'App/ZofCMS/Plugin.pm',
    'App/ZofCMS/Plugin/AccessDenied.pm',
    'App/ZofCMS/Plugin/AntiSpamMailTo.pm',
    'App/ZofCMS/Plugin/AutoDump.pm',
    'App/ZofCMS/Plugin/AutoEmptyQueryDelete.pm',
    'App/ZofCMS/Plugin/AutoIMGSize.pm',
    'App/ZofCMS/Plugin/Barcode.pm',
    'App/ZofCMS/Plugin/Base.pm',
    'App/ZofCMS/Plugin/BasicLWP.pm',
    'App/ZofCMS/Plugin/BoolSettingsManager.pm',
    'App/ZofCMS/Plugin/BreadCrumbs.pm',
    'App/ZofCMS/Plugin/CRUD.pm',
    'App/ZofCMS/Plugin/CSSMinifier.pm',
    'App/ZofCMS/Plugin/Comments.pm',
    'App/ZofCMS/Plugin/ConditionalRedirect.pm',
    'App/ZofCMS/Plugin/ConfigToTemplate.pm',
    'App/ZofCMS/Plugin/Cookies.pm',
    'App/ZofCMS/Plugin/CurrentPageURI.pm',
    'App/ZofCMS/Plugin/DBI.pm',
    'App/ZofCMS/Plugin/DBIPPT.pm',
    'App/ZofCMS/Plugin/DataToExcel.pm',
    'App/ZofCMS/Plugin/DateSelector.pm',
    'App/ZofCMS/Plugin/Debug/Dumper.pm',
    'App/ZofCMS/Plugin/Debug/Validator/HTML.pm',
    'App/ZofCMS/Plugin/DirTreeBrowse.pm',
    'App/ZofCMS/Plugin/Doctypes.pm',
    'App/ZofCMS/Plugin/FeatureSuggestionBox.pm',
    'App/ZofCMS/Plugin/FileList.pm',
    'App/ZofCMS/Plugin/FileToTemplate.pm',
    'App/ZofCMS/Plugin/FileTypeIcon.pm',
    'App/ZofCMS/Plugin/FileUpload.pm',
    'App/ZofCMS/Plugin/FloodControl.pm',
    'App/ZofCMS/Plugin/FormChecker.pm',
    'App/ZofCMS/Plugin/FormFiller.pm',
    'App/ZofCMS/Plugin/FormMailer.pm',
    'App/ZofCMS/Plugin/FormToDatabase.pm',
    'App/ZofCMS/Plugin/GetRemotePageTitle.pm',
    'App/ZofCMS/Plugin/GoogleCalculator.pm',
    'App/ZofCMS/Plugin/GooglePageRank.pm',
    'App/ZofCMS/Plugin/GoogleTime.pm',
    'App/ZofCMS/Plugin/HTMLFactory/Entry.pm',
    'App/ZofCMS/Plugin/HTMLFactory/PageToBodyId.pm',
    'App/ZofCMS/Plugin/HTMLMailer.pm',
    'App/ZofCMS/Plugin/InstalledModuleChecker.pm',
    'App/ZofCMS/Plugin/JavaScriptMinifier.pm',
    'App/ZofCMS/Plugin/LinkifyText.pm',
    'App/ZofCMS/Plugin/LinksToSpecs/CSS.pm',
    'App/ZofCMS/Plugin/LinksToSpecs/HTML.pm',
    'App/ZofCMS/Plugin/NavMaker.pm',
    'App/ZofCMS/Plugin/PreferentialOrder.pm',
    'App/ZofCMS/Plugin/QueryToTemplate.pm',
    'App/ZofCMS/Plugin/QuickNote.pm',
    'App/ZofCMS/Plugin/RandomBashOrgQuote.pm',
    'App/ZofCMS/Plugin/RandomPasswordGeneratorPurePerl.pm',
    'App/ZofCMS/Plugin/SendFile.pm',
    'App/ZofCMS/Plugin/Session.pm',
    'App/ZofCMS/Plugin/SplitPriceSelect.pm',
    'App/ZofCMS/Plugin/StartPage.pm',
    'App/ZofCMS/Plugin/StyleSwitcher.pm',
    'App/ZofCMS/Plugin/Sub.pm',
    'App/ZofCMS/Plugin/Syntax/Highlight/CSS.pm',
    'App/ZofCMS/Plugin/Syntax/Highlight/HTML.pm',
    'App/ZofCMS/Plugin/TOC.pm',
    'App/ZofCMS/Plugin/TagCloud.pm',
    'App/ZofCMS/Plugin/Tagged.pm',
    'App/ZofCMS/Plugin/UserLogin.pm',
    'App/ZofCMS/Plugin/UserLogin/ChangePassword.pm',
    'App/ZofCMS/Plugin/UserLogin/ForgotPassword.pm',
    'App/ZofCMS/Plugin/ValidationLinks.pm',
    'App/ZofCMS/Plugin/YouTube.pm',
    'App/ZofCMS/Template.pm',
    'App/ZofCMS/Test/Plugin.pm'
);

my @scripts = (
    'bin/zofcms_helper'
);

# no fake home requested

my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}

foreach my $file (@scripts)
{ SKIP: {
    open my $fh, '<', $file or warn("Unable to open $file: $!"), next;
    my $line = <$fh>;
    close $fh and skip("$file isn't perl", 1) unless $line =~ /^#!.*?\bperl\b\s*(.*)$/;

    my @flags = $1 ? split(/\s+/, $1) : ();

    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, @flags, '-c', $file);
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$file compiled ok");

   # in older perls, -c output is simply the file portion of the path being tested
    if (@_warnings = grep { !/\bsyntax OK$/ }
        grep { chomp; $_ ne (File::Spec->splitpath($file))[2] } @_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
} }



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


