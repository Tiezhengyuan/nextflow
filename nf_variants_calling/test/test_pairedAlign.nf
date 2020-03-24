#!/usr/bin/env nextflow
echo true
/*
*params.reference = './reference/NC_008253.fna'
*params.result = './result'
*params.rawData = './raw_data/'
*/

//index file
ref_fa = file(params.reference)
index_path = file("${ref_fa.parent}/${ref_fa.baseName}")
index_file = file ("${ref_fa.parent}/${ref_fa.baseName}.1.bt2")
//result
result_path = file("${params.result}")

//fq files
Channel
    .fromFilePairs("${params.rawData}/*_R{1,2}*.fq")
    .set {fq_ch}

process buildIndex{
    input:
    val index from index_path
    file ref from ref_fa

    output:
    val index into index_ch

    script:
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

process bowtie2{
    input:
    set sampleID, pair from fq_ch
    val index from index_path
    val result from result_path

    """
    echo "bowtie2 -x ${index} -S $result/${sampleID}.sam -1 ${pair[0]} -2 ${pair[1]}"
    bowtie2 -x ${index} -S $result/${sampleID}.sam -1 ${pair[0]} -2 ${pair[1]}
    """
}
