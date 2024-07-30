#!/usr/bin/env nextflow

index = file(params.index)
options = params.options
query = params.query

workflow {
    main:
        ch_pair = Channel.fromFilePairs(query, checkIfExists:true)
        ch_aln = align(index, ch_pair, options)

    emit:
        ch_aln.view {
            println "output: ${it}"
        }
}

process align {
    debug true
    publishDir params.outDir, mode: 'copy', overWrite: true
    conda 'bioconda::salmon=1.10.2'
    
    input:
    path index
    tuple val(pair_id), path(reads)
    val options

    output:
    path pair_id

    script:
    """
    salmon quant $options -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}