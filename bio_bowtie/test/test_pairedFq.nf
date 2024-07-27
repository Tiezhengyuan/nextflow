#!/usr/bin/env nextflow
echo true

params.query = './raw_data/*_R{1,2}*.fq'

Channel
    .fromFilePairs(params.query)
    .set {fq_ch}

process test{
    input:
    set sampleID, pair from fq_ch
    """
    echo "-S ${sampleID}.sam -1 ${pair[0]} -2 ${pair[1]}"
    """
}
