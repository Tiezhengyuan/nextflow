#!/usr/bin/env nextflow
/*
example command:

*/

alnDir = "/home/yuan/bio/nextflow/results/ggal_gut"
params.multiqc_config = '/home/yuan/bio/nextflow/bio/multiqc_config.yaml'

workflow {
    main:
        ch_qc = multiqc(alnDir, params.multiqc_config)
    emit:
        ch_qc.view {
            println "output: ${it}"
        }
}

process multiqc {
    debug true
    conda 'bioconda::multiqc=1.23'
    publishDir alnDir, mode:'copy', overWrite: true
    
    input:
    path alnDir
    path 'config'

    output:
    path 'multiqc_report.html', emit: report

    script:
    """
    multiqc -c config -o multiqc_report.html $alnDir
    """
}