#!/usr/bin/env nextflow
echo true

params.pair1 = "../test_data/*R1*.fq"
params.pair2 = "../test_data/*R2*.fq"

reads1 = Channel
    .fromPath( params.pair1 )
    .map { path -> [ path.toString().replace("_R1", "_RX"), path ] }
reads2 = Channel
    .fromPath( params.pair2 )
    .map { path -> [ path.toString().replace("_R2", "_RX"), path ] }

// Join pairs on their key.
read_pairs = reads1
        .phase(reads2)
        .map { pair1, pair2 -> [ pair1[1].baseName.tokenize('_').get(0), pair1[1], pair2[1] ] }

process test{
    input:
    set sampleId, file(R1), file(R2) from read_pairs

    """
    echo $sampleId
    echo $R1, $R2
    """
}



