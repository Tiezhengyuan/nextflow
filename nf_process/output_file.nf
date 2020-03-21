#!/usr/bin/env nextflow
echo true

//
process step1{
    output:
    file  'test.txt' into text_ch

    """
    echo output file > test.txt
    """
}

//export content to target file
//current directory is that where *nf is executed
text_ch.collectFile(name: '../test_data/output_file.txt')
