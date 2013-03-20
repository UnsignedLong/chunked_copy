use strict;
use warnings;

use Time::HiRes qw(usleep nanosleep);
use Getopt::Std;

sub usage()
{
    print STDERR << "EOF";
-s : sleep between chunks in usecs (default 10000 = 10ms)
-c : chunk size (default 65536 = 64K)
-u : unlink (delete) source file
-v : verbose

Example: perl $0 -s 5000 -c 2048 source.file dest.file
EOF
      exit;
}

my %options=();
getopts("uvc:s:", \%options) or usage();

my $chunk = $options{c} || 65536; 
my $sleep = $options{s} || 10000;

my $infile = $ARGV[0] || usage();
my $outfile = $ARGV[1] || usage();

my $buffer = "";

open (INFILE, "<", $infile) or die "Not able to open the file. \n";
open (OUTFILE, ">", $outfile) or die "Not able to open the file for writing. \n";
binmode (INFILE);
binmode (OUTFILE);

print "$infile -> $outfile\n" if defined $options{v};

while ( (read (INFILE, $buffer, $chunk)) != 0 ) {
    print OUTFILE $buffer;
    usleep($sleep);
}  

close (INFILE) or die "Not able to close the file: $infile \n";
close (OUTFILE) or die "Not able to close the file: $outfile \n";

unlink($infile) if defined $options{u};

