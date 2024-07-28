#!/usr/local/bin nextflow

// input is paired-end fastq file


// get parameters
index = params.index
query = params.query
sampleName = params.sampleName
outDir = file(params.outDir)
chunkSize = params.chunkSize
options = params.options

// create direcotry if not exists
if (!outDir.exists()) {
    outDir.mkdirs()
}

workflow {
    Channel
        .fromFilePairs(query, flat: true)
        .splitFastq(by: chunkSize, pe:true, file: true)
        .set {ch_fastq}

    // sequence alignment
    ch_aln = align(ch_fastq, index, options)
    ch_sam = ch_aln.collectFile(name: "${outDir}/${sampleName}.sam")
    ch_sam.view {
        println "Output of alignments: ${it}"
        println "Output size: ${(it.size()/(1024**2)).round()} KB"
    }
}

process align {
    debug true

    input:
    tuple val(name), file(f1), file(f2)
    val index
    val options

    output:
    path name

    script:
    """
    bowtie2 $options -x $index -1 $f1 -2 $f2 -S $name
    """
}