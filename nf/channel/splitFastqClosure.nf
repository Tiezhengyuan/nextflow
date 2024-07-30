#!/usr/bin/env nextflow

workflow {
    Channel
        .fromPath('data/reads_R1.fq')
        .splitFastq( by: 2, record: true)
        .view { rec -> rec.readString }
}