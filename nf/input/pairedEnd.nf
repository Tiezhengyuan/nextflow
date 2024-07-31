#!/usr/local/bin nextflow


workflow {
   ch_pair = channel.fromFilePairs('data/reads_R{1,2}.fq')
   A(ch_pair).view()
}

process A {
    debug true

    input:
        tuple val(sample_id), path(reads)

    output:
        path reads
        
    script:
        """
        echo "sample:${sample_id}, reads:${reads}"
        """
}