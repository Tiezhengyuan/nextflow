#!/usr/bin/env nextflow
echo true

Channel
    .fromFilePairs('../test_data/*{1,2}.fq')
    .set { samples_ch }
println samples_ch
process getPairs {
    input:
    set sampleId, file(reads) from samples_ch

    script:
    """
    echo $sampleId 
    echo $reads
    echo
    """
}
