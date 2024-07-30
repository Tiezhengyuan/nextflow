process multiQC {
    debug true
    conda 'bioconda::multiqc=1.23'
    publishDir "${params.outDir}/${alnDir}", mode:'copy', overWrite: true
    
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