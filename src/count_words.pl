#!/usr/bin/env perl 

# Usage:
#       -fasta  'path/to/fasta' : path to input FASTA file 
#       -seq    'word'          : what sequence to count, e.g. "A" or "CG", etc
#
# NOTE: search of -seq 'word' in FASTA is case-insensitive

use English;
$WARNING = 1;
use strict;
use Getopt::Long;

# pars arguments
my $fasta_file = '';
my $seq        = '';
GetOptions('fasta=s' => \$fasta_file,
           'seq=s'   => \$seq
);

die 'Missing required arguments:
-fasta  "path/to/fasta" : path to input FASTA file
-seq    "word"          : what sequence to count, e.g. "A" or "CG", etc
'
unless $fasta_file && $seq;

# read in fasta
my $fasta = readfasta($fasta_file);

# print header
print "ref_id\tref_length\tword\tcount\n";

# count words
foreach my $id (keys %{$fasta}){

    print STDERR "Working on <$id>\n";

    my $ref = $fasta->{$id};

    if(length($ref) < length($seq)){
        warn "Length of chromosome <$id> is less than the length 
              of -seq <$seq>!!!\nBailing out from <$id>.";
        next;
    }

    my $count = () = $ref =~ /$seq/gi; 
    
    # ## this works but is much slower than the above solution
    # my $count = 0;
    # while($ref =~ /$seq/gi){
    #     $count++;
    #     if( $count % 100000 == 0 ){
    #         print STDERR "...counted $count occurences of $seq\n";
    #     }
    # } 

    print $id,          "\t";
    print length($ref), "\t";
    print $seq,         "\t";
    print $count,       "\n";

}


sub readfasta {
    my $fastafile      = pop;
    my (%fasta, @line) = () x 2;
    my $id             = '';
    open (FASTA, "<$fastafile") || die "cannot open file with fasta sequences!!!\n";
    while(<FASTA>){
       chomp $_;
        if($_=~/^>/){
            # to preserve the whole id line 
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
            # $tmp=~ s/U/T/g;
            $tmp=uc($tmp);  ### all into uppercase
            $fasta{$id} .= $tmp;
        }
    }
    close FASTA;
    return(\%fasta);
}

print "Program finished successfully.\n";
