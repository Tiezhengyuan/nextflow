#!/usr/bin/env nextflow
echo true

//pick up fastq files
rawData = file(params.rawData)
fqType = params.fqType
Channel
    .fromFilePairs("${rawData}/*R{1,2}*.fq")
    .set {paired_ch}
Channel
    .fromPath("${rawData}/*R1*.fq")
    .set {single_ch}

//reference
ref_fa = file(params.reference)
//result
result_path = file("${params.result}")

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

process bowtie2_paired{
    input:
    set sampleID, pair from paired_ch
    val index from index_ch
    val result from result_path

    when:
    fqType == 'paired'

    """
    echo "bowtie2 -x ${index} -S $result/${sampleID}.sam -1 ${pair[0]} -2 ${pair[1]}"
    bowtie2 -x ${index} -S $result/${sampleID}.sam -1 ${pair[0]} -2 ${pair[1]}
    """
}

process bowtie2_single{
    input:
    file R1 from single_ch
    val index from index_ch
    val result from result_path

    when:
    fqType == 'single'

    """
    echo "bowtie2 -x ${index} -S $result/${R1.baseName}.sam -q ${R1}"
    bowtie2 -x ${index} -S $result/${R1.baseName}.sam -q ${R1}
    """
}
