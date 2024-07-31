
process alignPaired {
    debug true
    publishDir params.outDir, mode: 'copy', overWrite: true
    tag "$pair_id"
    conda 'bioconda::salmon=1.10.2'
    
    input:
    tuple val(pair_id), path(reads)

    output:
    path pair_id

    script:
    """
    salmon quant $params.options -i $params.index \
        -1 ${reads[0]} -2 ${reads[1]} -o $params.sampleName
    """
}

process alignSingle {
    debug true
    publishDir params.outDir, mode: 'copy', overWrite: true
    tag "${params.sampleName}"
    conda 'bioconda::salmon=1.10.2'
    
    input:
    path reads

    output:
    path params.sampleName

    script:
    """
    salmon quant $params.options -i $params.index -r ${reads} -o $params.sampleName
    """
}