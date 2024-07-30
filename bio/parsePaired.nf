#!/usr/bin/env nextflow

input = "data/demo_mrnaseq/197_L1_{R1,R2}.fq"
sampleName = ''
workflow {
    ch_pair = Channel.fromFilePairs(input, checkIfExists:true)
    ch_pair.view {
        println "sample name: ${it[0]}"
        println "R1: ${it[1][0]}"
        println "R2: ${it[1][1]}"
    }
}

