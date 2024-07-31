#!/usr/local/bin nextflow


workflow {
   ch_pair = channel.fromPath('data/reads_R{1,2}.fq')
   A(ch_pair).view()
}

process A {
    debug true

    input:
        path reads

    output:
        path reads
        
    script:
        """
        echo $reads
        """
}