#!/usr/bin/env perl

#usage
#       -fa < fasta file with sequences, whose lengths are of interest. For example, hg19.fa or mm9.fa  

use English;
$WARNING = 1;
use strict;
use Getopt::Long;

###read file names from the command line
my $fasta_file = '';
GetOptions('fasta=s' => \$fasta_file
);

my $fasta = readfasta($fasta_file);

foreach my $seqID (keys %{$fasta}){
    my $length = length($fasta->{$seqID});
    $seqID =~ s/\s.*//;
    print $seqID, "\t";
    print $length, "\n";
}

sub readfasta {
    my $fastafile      = pop;
    my (%fasta, @line) = () x 2;
    my $id             = '';
    open (FASTA, "<$fastafile") || die "cannot open file with fasta sequences!!!\n";
    while(<FASTA>){
       chomp $_;
        if($_=~/^>/){
            # to peserve the whole id line 
            $id = $_;

            # # to leave only the first word in a tab separated id line
            # @line=split("\t", $_);
            # ## $id=lc($line[0]); ### all into lowercase
            # $id=$line[0];

            $id=~s/>//;
            print STDERR "duplicated id <$id>\n" if defined($fasta{$id});
            $fasta{$id}="";
        }else{
            my $tmp=$_;
            $tmp=~ s/U/T/g;
            $tmp=uc($tmp);  ### all into uppercase
            $fasta{$id} .= $tmp;
        }
    }
    close FASTA;
    return(\%fasta);
}
