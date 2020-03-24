#!/usr/bin/env nextflow
echo true

//pick up fastq files
rawData = file(params.rawData)
fqType = params.fqType
if(fqType == 'paired'){
    Channel
        .fromFilePairs("${rawData}/*R{1,2}*.fq")
        .set {fq_ch}
}else{
    Channel
        .fromPath("${rawData}/*R1*.fq")
        .map {it -> [it.baseName, it]}
        .set {fq_ch}
}
//reference
ref_fa = file(params.reference)
//result
out = file("${params.result}")

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

process bowtie2{
    publishDir "${out}"
    
    input:
    set sampleID, fq from fq_ch
    val index from index_ch

    output:
    file "${sampleID}.sam" into sam_ch

    script:
    if(fqType == 'paired'){
        """
        echo "bowtie2 -x ${index} -S ${sampleID}.sam -1 ${fq[0]} -2 ${fq[1]}"
        bowtie2 -x ${index} -S ${sampleID}.sam -1 ${fq[0]} -2 ${fq[1]}
        """
    }else{
        """
        echo "bowtie2 -x ${index} -S ${sampleID}.sam -q ${fq}"
        bowtie2 -x ${index} -S ${sampleID}.sam -q ${fq}
        """
    }
}


process samtools{
    publishDir "${out}"

    input:
    file sam from sam_ch

    output:
    file "${sam.baseName}.bam" into bam_ch

    """
    echo "samtools sort -T ${sam.baseName}.tmp -o ${sam.baseName}.bam ${sam}"
    samtools sort -T ${sam.baseName}.tmp -o ${sam.baseName}.bam ${sam}
    """
}

process bcftools{
    publishDir "${out}"

    input:
    file ref from ref_fa
    file bam from bam_ch

    output:
    file "${bam.baseName}.bcf" into bcf_ch

    """
    echo "bcftools mpileup -f ${ref} ${bam} | bcftools call -mv -Ob -o ${bam.baseName}.bcf"
    bcftools mpileup -f ${ref} ${bam} | bcftools call -mv -Ob -o ${bam.baseName}.bcf
    """

}
    


