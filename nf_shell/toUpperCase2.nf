#!/usr/bin/env nextflow
println true;

Channel
    .fromPath('../test_data/sample.txt')
    .splitText(by:1)
    .set {text_ch}

process splitLetters {
    input:
    file f from text_ch

    output:
    file 'chunk_*' into letters

    """
    cat $f > chunk_
    """
}


process convertToUpper {
    input:
    file x from letters

    output:
    stdout result

    """
    println $x
    cat $x | tr '[a-z]' '[A-Z]'
    """
}

workflow {
    splitLetters | flatten | convertToUpper | view { it.trim() }
}
