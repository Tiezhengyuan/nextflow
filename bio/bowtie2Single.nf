#!/usr/local/bin nextflow

// input is one fastq file


// get parameters
index = params.index
query = file(params.query)
outDir = file(params.outDir)
chunkSize = params.chunkSize
options = params.options

// create direcotry if not exists
if (!outDir.exists()) {
    outDir.mkdirs()
}
// define sample name
if (params.sampleName) {
    sampleName = params.sampleName
} else {
    sampleName = query.name.take(query.name.lastIndexOf('.'))
}

workflow {
    Channel
        .from(query)
        .splitFastq(by: chunkSize, file: true)
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
    path 'query'
    val index
    val options

    output:
    path 'aln'

    script:
    """
    bowtie2 $options -x $index query -S aln 
    """
}