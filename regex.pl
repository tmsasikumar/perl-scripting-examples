#!/usr/bin/env perl
# try_m_2.pl
use strict;
use warnings;


while (<>) {   
    if (m/[0-9]+/) {
        print 'Accept substring: ' . substr($_, $-[0], $+[0] - $-[0]) . "\n";
    } else {
        print "Reject\n";
    }
}