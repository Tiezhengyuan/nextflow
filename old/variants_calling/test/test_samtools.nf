#!/usr/bin/env nextflow
echo true

params.reference = './reference/NC_008253.fna'
params.result = './result'
params.sam = './result/ecoli1000.sam'


//index file
ref_fa = file(params.reference)
//sam file
sam_file = file(params.sam)
//
result_prefix = file("${sam_file.parent}/${sam_file.baseName}")
println(result_prefix)


process samtools{
    input:
    val sam from sam_file
    val out from result_prefix

    output:
    val "${out}.bam" into bam_ch

    script:
    tmp = file("${out}.tmp")
    """
    echo "samtools sort -T ${tmp} -o ${out}.bam ${sam}"
    samtools sort -T ${tmp} -o ${out}.bam ${sam}
    """
}

process bcftools{
    input:
    val bam from bam_ch

    """
    echo $bam
    """

}
