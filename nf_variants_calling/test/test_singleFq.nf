#!/usr/bin/env nextflow
echo true

params.query = './raw_data/*_R1.fq'

Channel
    .fromPath(file(params.query))
    .map {it -> [ it.baseName.tokenize('_').get(0), it ]}
    .set {fq_ch}

process test{
    input:
    set sampleID, file(R1) from fq_ch
    """
    echo "-S ${sampleID}.sam -q ${R1}"
    """
}
