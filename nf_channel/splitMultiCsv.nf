#!/usr/bin/env nextflow

workflow {
    Channel
        .fromPath("data/*.csv")
        .splitCsv(header: true, sep: ',', by: 2)
        .view { row -> "${row.sampleId}, ${row.read1}, ${row.read2}" }
}