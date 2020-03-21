#!/usr/bin/perl

use warnings;
use strict;

#function: split
my $s='ab d ge h';
my @arr=split / /, $s;
print join("\t", @arr), "\n";

