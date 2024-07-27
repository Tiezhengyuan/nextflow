#!/usr/local/bin nextflow

process A {
    debug true
    input:
        path query_file
    script:
        """
        echo "${query_file}"
        """
}

workflow {
   def fa_files = channel.fromPath('../test_data/*.fa')
   A(fa_files)
}