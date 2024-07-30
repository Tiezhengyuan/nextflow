#!/usr/bin/env nextflow

workflow {
    Channel
        .fromPath('data/sequences.fa')
        .splitFasta( by: 10 )
        .view()   
}