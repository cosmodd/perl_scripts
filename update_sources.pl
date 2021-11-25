#!/usr/bin/perl
use Cwd;
my $dir = getcwd;
if (not -f "$dir/Makefile") { die "There is no Makefile in this directory !\n"; }
if (not -d "$dir/srcs") { die "There is no srcs/ directory here !\n"; }
my $sources = `cd $dir | find srcs -type f`;
my @lines = split /\n/, $sources;
for $i (0..$#lines)
{
	@lines[$i] =~ s/$/ \\/;
	if ($i != 0) { @lines[$i] =~ s/^/\t\t/; }
}
$sources = join "\n", @lines;
my $makefile = `cat $dir/Makefile`;
$makefile =~ s/(?<=SRCS\t= )(.|\n)+?(?=\n\n)/$sources/s;
open OVERWRITE, ">Makefile";
print OVERWRITE $makefile;
close OVERWRITE;
