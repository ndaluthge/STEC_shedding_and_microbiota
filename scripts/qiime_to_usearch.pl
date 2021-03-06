#!/usr/bin/perl -w


use strict;
use Getopt::Long;

#Command line parameters:
my $fasta = "";
my $prefix = "";


#Setup the command line options using Getopt:Long
my $commandline = GetOptions("fasta:s", \$fasta,
			"prefix:s", \$prefix);


if (!$commandline || $fasta eq "" || $prefix eq "" ) {
	print STDERR "Example: ./qiime_ \n";
	exit;
}

my $output = 0;
my @split_line;
my @split_number;
my @split_id;

open (my $FASTA_FILE, "$fasta") or die "Can’t open the input FASTA file"; 
open (my $FORMAT_FILE, ">format.fasta") or die "Can’t open the otuput FASTA file!"; 

while (my $line = readline($FASTA_FILE)) {
	chomp $line;
	my $check_line = substr ($line, 0, 1);
	if ($check_line eq ">") {
		@split_line = split /_/, $line;
		@split_number = split /\s/, $split_line[1];
		@split_id = split />/, $split_line[0];
		print $FORMAT_FILE ">$prefix$split_number[0];barcode=$split_id[1]\n";
	} else {
		print $FORMAT_FILE "$line\n";
		$output ++;
	}
}

print "Output Sequences: $output\n";

close ($FASTA_FILE) or die "Can't close input FASTA file! \n";
close ($FORMAT_FILE) or die "Can't close output FASTA file! \n";
