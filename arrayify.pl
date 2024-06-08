#!/usr/bin/env perl
eval 'exec perl -wS $0 ${1+"$@"}'
    if 0;
use 5.008; # perl v5.8.0 was released on July 18, 2002
use strict;
use warnings FATAL => qw{uninitialized void inplace};
my $name = $ENV{NAME} ? $ENV{NAME} : 'unnamed';
print "const unsigned char ${name}[] = {";
my ($buf, $piece, $cnt) = ('', '', 0);
while (read(STDIN, $buf, 512)) {
    while ($buf) {
        $piece = substr($buf, 0, 16);
        $buf = substr($buf, 16);
        print ',' if $cnt;
        print("\n    0x", join(', 0x', unpack('(H2)*', $piece)));
        $cnt++;
    }
}
print "\n};\n";
