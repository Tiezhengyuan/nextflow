#!/usr/bin/env nextflow

'''
flat: true  to emit the file pairs as separate elements
in the produced tuples.
pe: true return paired records each chunk
'''
workflow {
    ch_fq = Channel
        .fromFilePairs('data/reads_{R1,R2}.fq', flat: true)
        .splitFastq( by: 1, pe:true, record: true)
        .view { "${it[1].readString} \t ${it[2].readString}"}

}