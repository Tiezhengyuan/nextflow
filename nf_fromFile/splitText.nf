#!/usr/bin/env nextflow
echo true

Channel
    .fromPath('../test_data/sample.txt')
    .splitText(by: 2)
    .set {text_chunk}

process split{
    input:
    file x from text_chunk

    script:
    """
    head $x
    echo '-'
    """

}
