#!/usr/local/bin nextflow

process A {
    debug true
    input:
        path query_file, name: 'query_fa'
    script:
        """
        echo query_fa
        """
}

workflow {
   def fa_files = channel.fromPath('../test_data/*.fa')
   A(fa_files)
}