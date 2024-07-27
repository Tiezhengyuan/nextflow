#!/usr/local/bin nextflow

process A {
    debug true
    input:
        path "seq"
    script:
        """
        ls -als ${seq}
        """
}

workflow {
   def fa_files = channel.fromPath('../test_data/*.fq')
   A(fa_files)
}