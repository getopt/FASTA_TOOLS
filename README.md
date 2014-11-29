FASTA_TOOLS
===========

< get_chr_lengths.pl > 


Description:
    
    Starting from a file in FASTA format, generate a tab-delimited output with
    two fields: first is sequence ID, second is the length of the corresponding
    sequence:
    
    chrU        10049037
    chrUextra   29004656
    chrM        19517


Usage:

    $ perl ./get_chr_lengths.pl -fa /path/to/input.fasta > output_table.chr_len.tab 
    
    Options and ouput:

    -fa   specify path to the input file in FASTA format.   

    The output is printed into stdout stream and so it can be redirected into a
    file on the command line.


Example:

    An example input file with chromosome sequences in FASTA format is in Data/
    in this FASTA_TOOLS repository. Assuming that FASA_TOOLS repository was
    cloned into home directory, an example usage can be:
    
    $ cd ~
    $ perl ~/FASTA_TOOLS/get_chr_lengths.pl -fa FASTA_TOOLS/Data/example_chromosomes.fa > example.tab
