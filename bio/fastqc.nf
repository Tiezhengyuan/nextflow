#!/usr/bin/env nextflow

/*
*
*
*/

params.outdir = "/home/yuan/bio/nextflow/results/ggal_gut"
params.fq = "/home/yuan/bio/nextflow/data/ggal/ggal_gut_*.fq"

qc_outdir = file("${params.outdir}/fastqc")
if ( ! qc_outdir.isDirectory() ) {
    qc_outdir.mkdirs()
}

workflow {
    main:
        ch_fq = Channel.fromPath(params.fq)
        ch_qc = fastQC(ch_fq, qc_outdir)

    emit:
        ch_qc.view {
            println "${it}"
        }
}



process fastQC {
    debug true
    conda 'bioconda::fastqc=0.12.1'

    input:
    path reads
    path 'out'

    output:
    path "${reads}"

    script:
    """
    fastqc -o out -f fastq -q ${reads}
    """
}

