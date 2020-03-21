#!/usr/bin/env nextflow
echo true

//sample_info.csv store sample information: sample_name, R1
params.sample_info = 'test_data/sample_info.csv'

Channel
    .fromPath(params.sample_info)
    .splitCsv(header:true)
    .map{ row-> tuple(row.sampleId, file(row.read1), file(row.read2)) }
    .set { samples_ch }

process sample {
    input:
    set sampleId, file(R1), file(R2) from samples_ch

    script:
    """
    echo sample id: $sampleId
    echo R1 fq: $R1
    echo R2 fq: $R2
    """
}
