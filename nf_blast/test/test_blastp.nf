#!/usr/bin/env nextflow
echo true

params.query = './raw_data/protein_query.fa'
params.db = './reference/protein_reference'
params.out = './result/blastp.out'

//query channel
Channel
    .fromPath("$params.query")
    .splitFasta(by:params.chunkSize, file:true)
    .set {query_ch}

//get db
db = file(params.db)

process alignment{
    input:
    file 'query_file' from query_ch

    output:
    file 'blast_hits' into hit_ch

    """
    blastp -db $db -outfmt $params.outfmt -query query_file -out blast_hits
    """
}

//export
hit_ch
    .collectFile(name: "$params.out", newLine:true)
    .subscribe { println "$it"}