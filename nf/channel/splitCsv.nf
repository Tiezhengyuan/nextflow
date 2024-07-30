#!/usr/bin/env nextflow

workflow {
    Channel
        .fromPath("data/sample_info.csv")
        .splitCsv(header: true)
        .view { row -> "${row.sampleId}, ${row.read1}, ${row.read2}" }
}