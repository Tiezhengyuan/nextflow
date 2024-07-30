#!/usr/bin/env nextflow
echo true


params.reference = './reference/NC_008253.fna'
ref_fa = file(params.reference)
index_path = file("${ref_fa.parent}/${ref_fa.baseName}")
index_file = file ("${ref_fa.parent}/${ref_fa.baseName}.1.bt2")

process test{

    """
    echo $ref_fa
    echo $ref_fa.baseName
    echo $ref_fa.parent
    echo $ref_fa.name
    echo $index_path
    echo $index_file
    """
}