#!/usr/local/bin nextflow

process hello {
    debug true

    script:
    """
    echo "hello is printed."
    """
}

workflow {
  hello()
}