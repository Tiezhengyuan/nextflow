#!/usr/bin/env nextflow

/*
example nf:
    nextflow run bio/salmonBuild.nf -c bio/salmonBuild.config
example command:
    salmon index -p 2 \
        -t data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa \
        -i reference/salmon/ggal_1_48850000_49020000.Ggal71.500bpflank
*/

references = params.references.split(',') as List

workflow {
    main:
        Channel
            .fromList(references)
            .set { transcriptome }

        ch_build = build(transcriptome)

    emit:
        ch_build.view {
            println "Index path: ${it}"
        }
}

process build {
    debug true

    publishDir params.indexDir, mode: 'copy', overWrite: true
    tag "$transcriptome.simpleName"
    conda 'bioconda::salmon=1.10.2'
    
    input:
    path transcriptome

    output:
    path index_name

    script:
    index_name = transcriptome.name.take(transcriptome.name.lastIndexOf('.'))
    """
    salmon index -p $params.taskThreads -t $transcriptome -i $index_name
    """
}