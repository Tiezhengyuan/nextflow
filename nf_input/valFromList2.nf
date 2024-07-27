#!/usr/local/bin nextflow

process A {
    debug true
    input:
        val x
    script:
        """
        echo "${x}"
        """
}

workflow {
   channel.of("A", "B", "C") | A
}