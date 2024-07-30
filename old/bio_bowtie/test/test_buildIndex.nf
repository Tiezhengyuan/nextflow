#!/usr/bin/env nextflow
echo true


params.reference = './reference/NC_008253.fna'
ref_fa = file(params.reference)

//
process buildIndex{
    input:
    file ref from ref_fa

    output:
    val index into index_ch

    script:
    index = file("${ref_fa.parent}/${ref_fa.baseName}")
    index_file = file ("${ref_fa.parent}/${ref_fa.baseName}.1.bt2")
    if ( index_file.isFile() ){
        """
        echo "The index files of $ref exist. skip index building"
        """
    } 
    else{
        """
        echo "Build blast index file based on $ref."
        bowtie2-build ${ref} ${index}
        """
    }
}

process alignment{
    input:
    val index from index_ch
    """
    echo ${index}
    """
}