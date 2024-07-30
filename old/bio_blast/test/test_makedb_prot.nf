#!/usr/bin/env nextflow
echo true


params.reference = './reference/protein_reference.fa'
params.dbtype = 'prot'
ref_fa = file(params.reference)
db = file("${ref_fa.parent}/${ref_fa.baseName}")
if (params.dbtype == 'nucl'){
    db_index = file("${ref_fa.parent}/${ref_fa.baseName}.nsq")
}else{
    db_index = file("${ref_fa.parent}/${ref_fa.baseName}.psq")
}
//
process makedb{
    script:
    if ( db_index.isFile() ){
        """
        echo "The index files of $ref_fa exist. skip makeblastdb"
        """
    } 
    else{
        """
        echo "Build blast index file based on $ref_fa."
        makeblastdb -in $ref_fa -dbtype $params.dbtype -out $db
        """
    }
}