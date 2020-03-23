#!/usr/bin/env nextflow
echo true


params.reference = './reference/nucleotide_reference.fa'
ref_fa = file(params.reference)
db_psq = file("${ref_fa.parent}/${ref_fa.baseName}.psq")

process makedb{

    """
    echo $ref_fa
    echo $ref_fa.baseName
    echo $ref_fa.parent
    echo $ref_fa.name
    echo $db_psq
    """
}