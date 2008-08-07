package App::ZofCMS;

use warnings;
use strict;

our $VERSION = '0.0104';


1;
__END__

=head1 NAME

App::ZofCMS - web framework and templating system for small-medium sites.

=head1 SYNOPSYS

This module is just the main documentation for ZofCMS framework. See
L<USING THE FRAMEWORK> section below for explanation of how to use this
framework.

=head1 DESCRIPTION

ZofCMS stands for "Zoffix's Content Management System", however I prefer
it to be just a name. It is a small web framework/templating system designed
to be easily installed and workable on limited severs, i.e. the ones that do
not allow you to install perl modules from CPAN, don't have ssh and
occasionally don't even offer any SQL databases. If you have more freedom
than that you may want to give L<Catalyst> a try which, my opinion, is
a great framework, not just for web, and it offers far more functionality
than ZofCMS ever will.

ZofCMS is plugin based. If you create your own plugins, please upload them
to L<App::ZofCMS::Plugin> namespace or email it to me (L<zoffix@cpan.org>)
and I will package it, upload it, and give you corresponding credits.

ZofCMS currently uses L<HTML::Template> as a module to interpret HTML
templates. And so far, I have no plans to change this to anything alike
L<Template::Toolkit>.

Despite the "core" of the framework along with all of its plugins being
on CPAN there is a helper script (C<zofcms_helper>) which can produce
a ready-for-upload set of files which you can simply upload to your server
without having to install anything from CPAN on the server itself. See
L<perldoc zofcms_helper>.

=head1 HYSTORY

This section does not say anything useful, you can skip it if you are
not interested in what made me create ZofCMS.

For about two-three years name "ZofCMS" lived more as a joke. A lot of
people in IRC channels such as C<#css> would ask me what web framework
I use (I didn't use any at the time) and I would gladly say "I use ZofCMS"
instead of the expected "Drupal" or "Wordpress".

After coding a templating system from scratch for
L<http://getflusmart.com/>, which runs on the server without any SQL, ssh
or ability to install any perl modules directly from CPAN, I already felt
that something needed to be done. The "perl hashref" templates which I used
to make all those products displayed with only one L<HTML::Template>
template proved to be flexible, extendable and maintainable and that's
exactly from where ZofCMS template format came.

The last site I coded before starting to implement ZofCMS was a private
web application which had a message board along with a few other features.
Mostly everything was coded from scratch once more... The final breaking
point when a few weeks later I was asked to add two sections for file
uploads to that site. No, it wasn't hard to add them, it's just that
I found myself adding a couple lines of code to the "core" modules that
called modules which provided new functionality and those modules were
loaded on any page of the site; even the ones that would never require
functionality from those modules. That's where the idea of plugins came
to life including the idea of "page templates" asking for plugins which
are needed only on that specific page.

After being told at work that I will be putting up about nine sites in
near future I started putting actual ZofCMS code "on paper". The first
"site" was a single page because the content for it was not yet ready, we
just needed "something" to be up. I've used the baby ZofCMS (yet without
any helper scripts) and was quite happy with the ease of installation.
Despite my framework driving just single page being an overkill I already
was prepared for anything which is to be thrown on that site and was
confident that I will no longer have to hack around existing Perl code
on the site.

"What about L<Catalyst>?", you may ask. Well, here is my answer.
L<Catalyst> is GREAT! I love it. It's magic. But even on
L<http://zoffix.com/>, which allows me to easily install modules directly
from CPAN AND gives me ssh access, I spent quite some time deploying
my Catalyst application. As I am not creating very large sites at work
(or at home for that matter) I feel that Catalyst is an overkill for what
I do. I definitely recommend Catalyst to everyone. We make our own choices
- I am happy with the ones I've made.

=head1 HOW DOES IT WORK

There is a single C<index.pl> script. The page to display is specified
via C<page> query parameter (it can come from either POST or GET requests).
There is also a C<dir> parameter, but it's use it optional. For example,
if you are to access C<index.pl?page=foo/bar/baz/page> framework will
convert the query into C<page=page&dir=foo/bar/baz/>.

The "config file" (see L<App::ZofCMS::Config>) is loaded and checked whether
or not the specified page is an "allowed page"; if it isn't, user will
be presented with a 404.

Later on, the "ZofCMS template" file is located and loaded. This template
is just a file with a Perl hashref in it. All keys have special meanings,
see L<App::ZofCMS::Template> for details. Some (or even all) of those keys
can be specified in the "config file" under several keys which provide
"defaults", see L<App::ZofCMS::Config> for details.

ZofCMS template will reference a "base" template (which is a
L<HTML::Template> template) as well as several other L<HTML::Template>
files. The framework then will run any plugins, fill out all the values
in the templates and display the page to the user.

=head1 USING THE FRAMEWORK

=head2 FIRST TIME USE

Ok, if you are reading this I can assume you want to give ZofCMS a whirl.
This documentation describes how to install/use it from CPAN. I am also
planing to put up a ZofCMS tarball on L<http://web-tools.cc/tools/ZofCMS/>
from which you can get started without touching CPAN (for the most part).
At the time of this writing that webpage is not yet up.

First of all, install C<App::ZofCMS> "module" via your cpan script. If you
don't know how to do that, read
L<http://sial.org/howto/perl/life-with-cpan/>. This will install ZofCMS
"core" along with with helper script. Detailed description of helper
script can be found by running C<perldoc zofcms_helper>.

=head2 INITIAL SETUP

Pick a directory in which you want to create ZofCMS "base" from which
you would start working on your site. This documentation assumes that you
are doing all this on a local, fully functional box.

ZofCMS directory/file setup is arranged to have one directory web
accessible; that one will contain C<index.pl> along with any CSS/JS files
or images that will be on your website. Another directory will not be
web accessible; here you will keep your ZofCMS templates along with page
templates (i.e. L<HTML::Templates>, or "data") and the config file.

As example we will want our site to be in C</var/www/testsite/> directory,
thus we go (assuming we are on the system which has C<mkdir> and C<cd>):

    mkdir /var/www/testsite;
    cd /var/www/testsite/;
    zofcms_helper --site web;

Details about C<zofcms_helper> script can be found in
C<perldoc zofcms_helper>. In this example, the helper script created two
directories C</var/www/testsite/web/> and C</var/www/testsite/web_site/>.
The C<web> directory is what we would have as web accessible (containing
C<index.pl>) and C<web_site> is what would contain ZofCMS "core".

The helper script stuffed a single file, C<index.pl> into
C</var/www/testsite/web/> directory and that's the only thing that ZofCMS
cares about from that directory. B<Note:> make sure to remove the line
C<use CGI::Carp qw/fatalsToBrowser/;> from C<index.pl> before deploying
your finished site live. See C<CGI::Carp> for more information.

The C</var/www/testsite/web_site/> has more goodies in it. Here is what we
have in here:

    data        - here you would put your HTML::Template templates which
                  can be references from ZofCMS templates.

    templates   - here is where you would put your ZofCMS templates.

    ZofCMS      - this is where ZofCMS "core", its plugins and
                  any "template exec modules" (more on that later)
                  will live.

In the C<data> directory you will notice a file called C<base.tmpl> this
is the "base" L<HTML::Template> file, it will be filled with virtually
all the keys from ZofCMS template. In the C<templates> directory you will
find C<index.tmpl> and C<404.tmpl>

B<Before we proceed any further> I advise you to read documentation
for L<App::ZofCMS::Config> and L<App::ZofCMS::Template> as I am not going
to explain what each key means; it is explained in aforementioned
documentation in detail.

=head2 FIRST PAGE

Now, let's create our first page. Let it be named something original,
like "foo" :)

Open up your config file and under valid pages add '/foo'. Considering
you *did* read documentation for L<App::ZofCMS::Config> you'll know exactly
what to do at this point.

now go to your "core dir" (which will be /var/www/templates/web_site/
if you followed (and able to execute) the helper script example from
INITIAL SETUP section above. Go to to directory "templates" and create
a file named C<foo.tmpl>, in that file enter the following:

    {
        title       => 'Hello World',
        body        => \'foo.tmpl',
        t           => {
            cur_time => scalar(localtime),
        }
    }

Now go to "data directory" and create a new file named C<foo.tmpl> and
enter the following into it:

    <p>Current time is: <tmpl_var name="cur_time">

Providing you did not edit anything else in your config file and did not
touch C<base.tmpl> file in your "data directory" you can now access
your web application and see a page which will display current time.
How wonderful \o/


=head2 MORE INFORMATION

If you are still stuggling and don't know what to do after reading all
the documentation from start to end. E-mail the me and I will include
more examples and explanations for ZofCMS. When I will have enough time
I will also put up a little FAQ on L<http://web-tools.cc/tools/ZofCMS/>,
which at the time of this writing is nothing but an idea.

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>
(L<http://zoffix.com>, L<http://haslayout.net>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Zoffix Znet, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

