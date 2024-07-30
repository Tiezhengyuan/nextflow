#!/usr/local/bin nextflow

indexDir = file(params.indexDir)
overWrite = params.overWrite
references = params.references.split(',') as List

if (! indexDir.isDirectory()) {
    indexDir.mkdirs()
}

workflow {
    Channel
        .fromList(references)
        .set { ch_ref }

    // build index
    build(ch_ref, indexDir, overWrite)
        .view {
            println "FASTA Reference is ${it[0]}."
            println "Index of Bowtie2 is ${it[1]}"
        }
}

process build {
    debug true
    
    input:
    path ref
    path indexDir
    val overWrite

    output:
    tuple val(ref), val(indexBase)
    
    script:
    baseName = ref.name.take(ref.name.lastIndexOf('.'))
    indexBase = "${indexDir.target}/${baseName}"
    indexFile = file(indexBase + ".1.bt2")
    if ( overWrite == "false" && indexFile.exists() ) {
        """
        echo "skip build index of ${indexBase}"
        """
    } else {
        """
        echo "The command: bowtie2-build -q $ref $indexBase"
        bowtie2-build -q $ref $indexBase
        """
    }
}