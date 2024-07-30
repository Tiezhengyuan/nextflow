#!/usr/bin/env nextflow

/*
 * Defines the pipeline input parameters (with a default value for each one).
 * Each of the following parameters can be specified as command line options.
 */

db = file(params.reference)
query = file(params.query)
baseName = query.name.take(query.name.lastIndexOf('.'))
outDir = file(params.outDir)
chunkSize = params.chunkSize
outfmt = params.outfmt

workflow {
    Channel
        .fromPath(query)
        .splitFasta(by: chunkSize, file:true)
        .set { ch_fasta }

    // sequence alignment and filter
    ch_hits = blast(ch_fasta)
    ch_sequences = extract(ch_hits)
    ch_sequences
        .collectFile(name: "${outDir}/${baseName}.blastn.txt")
        .view { file -> "matching sequences:\n ${file}" }
}

process blast {
    debug true
    input:
    path 'query.fa'

    output:
    path 'top_hits'

    """
    blastn -db $db -query query.fa -outfmt $outfmt > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}


process extract {
    input:
    path 'top_hits'

    output:
    path 'sequences'

    """
    blastdbcmd -db $db -entry_batch top_hits | head -n 10 > sequences
    """
}