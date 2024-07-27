#!/usr/bin/env nextflow
echo true


//query channel
Channel
    .fromPath("$params.query")
    .splitFasta(by:params.chunkSize, file:true)
    .set {query_ch}

//get db
ref_fa = file(params.reference)
db = file("${ref_fa.parent}/${ref_fa.baseName}")

process blast{
    input:
    file 'query_file' from query_ch

    output:
    file 'blast_hits' into hit_ch

    script:
    if (params.dbtype == 'nucl'){
        """
        echo "This is nucleotide blast."
        blastn -db $db -outfmt $params.outfmt -query query_file -out blast_hits
        """
    }
    else if (params.dbtype == 'prot'){
        """
        echo "This is protein blast."
        blastp -db $db -outfmt $params.outfmt -query query_file -out blast_hits
        """
    }
    else{
        error "Error! Wrong blast dbtype: $params.dbtype "
    }
}

//export
hit_ch
    .collectFile(name: "$params.out", newLine:true)
    .subscribe { println "Export blast results to $it"}