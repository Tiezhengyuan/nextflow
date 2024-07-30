#!/usr/bin/env nextflow

workflow {
    Channel
        .fromPath('data/sequences.fa')
        .splitFasta(record: [id: true, seqString: true])
        .filter { rec -> rec.id =~/^12/}
        .view {rec -> rec.id}
}