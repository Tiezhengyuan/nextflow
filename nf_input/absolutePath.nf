#!/usr/local/bin nextflow

process A {
    debug true
    input:
        path infile
    script:
        """
        ls -als $infile
        """
}

// input path must be absolute path
workflow {
   A("/home/yuan/bio/nextflow/test_data/pa232.fa")
}