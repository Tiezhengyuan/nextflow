#!/usr/bin/env nextflow

blast_db_dir = file(params.blast_db_dir)
ref = file(params.ref)
if (params.hasProperty('db_name')) {
    db_name = params.db_name
} else {
    db_name = ref.name.take(ref.name.lastIndexOf('.'))
}

workflow {
    makedb()
}

process makedb{
    debug true

    script:
    db_dir = file("${blast_db_dir}/${db_name}")
    db = file("${db_dir}/${db_name}")
    if ( db_dir.isDirectory() ){
        """
        echo "The database files of $db.* exist. skip makeblastdb"
        """
    } 
    else{
        """
        echo "Build blast dabase $db based on $ref."
        echo "makeblastdb -in $ref -dbtype nucl -out $db"
        makeblastdb -in $ref -dbtype nucl -out $db
        """
    }
}

