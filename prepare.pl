#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use Acme::Dump::And::Dumper;

my @files = glob '*.tar.gz';
s/\.tar\.gz$// for @files;

for ( @files ) {
    say "Doing $_";
    system "tar -xvvf $_.tar.gz";
    system "cp -R $_/examples/* examples/";
    system "cp -R $_/lib/* lib/";
    system "cp -R $_/t/* t/";
}