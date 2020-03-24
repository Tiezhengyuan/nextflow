#!/usr/bin/env nextflow
echo true

params.reference = './reference/NC_008253.fna'
params.result = './result'
params.sam = './result/ecoli1000.sam'


//index file
ref_fa = file(params.reference)
//sam file
sam_file = file(params.sam)
result_prefix = file("${sam_file.parent}/${sam_file.baseName}")
println(result_prefix)
bam_file = file("${sam_file.parent}/${sam_file.baseName}.bam")
bcf_file = file("${sam_file.parent}/${sam_file.baseName}.bcf")
process bcftools{
    input:
    file ref from ref_fa
    file bam from bam_file
    file bcf from bcf_file

    """
    echo "bcftools mpileup -f ${ref} ${bam} | bcftools call -mv -Ob -o ${bcf}"
    bcftools mpileup -f ${ref} ${bam} | bcftools call -mv -Ob -o ${bcf}
    """

}