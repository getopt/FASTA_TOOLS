#!/usr/bin/env perl

#usage
#       -mer <N>      specify length of desired oligomer
#       -for_loop     specify to use the for-loop method to print the oligomers
#       -recursion    speficy to use recursive subroutine to print the oligomers

use English;
$WARNING = 1;
use strict;
use Getopt::Long;
use Math::BaseArith;

my $for_loop  = 0;
my $recursion = 0;
my $mer       = 0;

my $alphabet  = "ATGC";
sub digits_to_nt{ my $trn = shift @_; $trn =~ tr/0123/ATGC/; return $trn }

GetOptions('mer=s'     => \$mer,
           'for_loop'  => \$for_loop,
           'recursion' => \$recursion);

die 'FATAL ERROR: please specify desired length of the oligomer: -mer <N>' unless $mer;


if($recursion){
    
    my @alphabet = split('',$alphabet); 

    sub recursion{
        
        my ($current) = @_;
    
        for (my $i = 0; $i < length($alphabet); ++$i) {
            my $growing = $current . $alphabet[$i];
            
            if (length($growing) < $mer) {
                recursion($growing);
            }

            print $growing, "\n" if length($growing) == $mer; 
        }
    }
    
    recursion('');

}elsif($for_loop){
    
    my @base_incription = (); 
    
    foreach my $i(1..$mer){
        push(@base_incription, length($alphabet));
    }
    
    my $total_words = length($alphabet) ** $mer;
    
    for(my $i = 0; $i < $total_words; $i++){
        my $digits  = join("", encode( $i, \@base_incription));
        my $letters = digits_to_nt($digits); 
        print $letters, "\n";
    }

}else{
    die "FATAL ERROR: please specify method: -for_loop or -recursion";
}
