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

process paired{
    input:
    val fqType from fqType
    set sampleID, pair from paired_ch

    when:
    fqType == 'paired'
    
    """
    echo "paired-end alignment: $sampleID"
    """
}

process single{
    input:
    val fqType from fqType
    file fq from single_ch

    when:
    fqType == 'single'

    """
    echo "###single-end alignment: $fq"
    """
}