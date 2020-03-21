#!/usr/bin/env nextflow
echo true

//embed perl code
process runPrint {

    """
    #!/usr/bin/perl
    my \$count = 10;
    print 'Hi there! ' . \$count . ' of Perl code is executed\n';
    """

}


//
//embed perl script
process runPerl{
   
    script:
    """
    perl $PWD/../test_data/testPerl.pl
    """

}


