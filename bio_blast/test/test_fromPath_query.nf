#!/usr/bin/env nextflow
echo true

Channel
    .fromPath("$params.query")
    .splitFasta(by:params.chunkSize, file:true)
    .set {query_ch}

process test{
    input:
    file 'query_file' from query_ch

    """
    echo $query_file
    """
}