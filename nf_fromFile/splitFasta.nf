#!/usr/bin/env nextflow
echo true

Channel
    .fromPath('../test_data/pa232.fa')
    .splitFasta(by:10000, file:true)
    .set {fa_ch}

process alignment{
    input:
    file 'query_file' from fa_ch

    output:
    file 'hit_file' into hit_ch

    """
    echo aligner --query query_file > hit_file
    """
}

//export
hit_ch
    .collectFile(name: "../test_data/alignment_hits.txt", newLine:true)
    .subscribe { println "$it"}

