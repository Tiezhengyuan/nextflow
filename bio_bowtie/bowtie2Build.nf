#!/usr/local/bin nextflow

ref = file(params.reference)
baseName = ref.name.take(ref.name.lastIndexOf('.'))
indexDir = file(params.indexDir)
indexBase = "${indexDir}/${baseName}"

workflow {
    build().view {
        println "Reference in FASTA is ${it[0]}."
        println "Index of Bowtie2 is ${it[1]}"
    }
}

process build {
    debug true

    output:
    tuple val(ref), val(indexBase)
    
    script:
    if (! indexDir.isDirectory()) {
        indexDir.mkdirs()
    }
    """
    bowtie2-build $ref $indexBase
    """
}