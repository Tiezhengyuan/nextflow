#!/usr/bin/env nextflow
echo true

params.sam = './result/ecoli1000.sam'
sam_file = file(params.sam)
out = sam_file.parent
process s1{
    publishDir "${out}"
    input:
    file sam from sam_file

    output:
    file "${sam.baseName}.sam1" into sam1_ch

    """
    echo step 1: $sam > ${sam.baseName}.sam1
    """
}

process s2{
    publishDir "${out}"
    input:
    file sam1 from sam1_ch

    output:
    file "${sam1.baseName}.sam2" into sam2_ch

    """
    echo step 2: $sam1 > ${sam1.baseName}.sam2
    """
}
