#!/usr/bin/env nextflow
echo true

process test{

    """
    echo $baseDir
    echo $params.outfmt
    echo $params.chunkSize
    """
}