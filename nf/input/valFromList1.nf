#!/usr/local/bin nextflow

names = channel.from("A", "B", "C")

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
    A(names)
}