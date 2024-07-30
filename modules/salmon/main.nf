
process alignPaired {
    debug true
    publishDir params.outDir, mode: 'copy', overWrite: true
    tag "$pair_id"
    conda 'bioconda::salmon=1.10.2'
    
    input:
    path index
    val options
    tuple val(pair_id), path(reads)

    output:
    path pair_id

    script:
    """
    salmon quant $options -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}