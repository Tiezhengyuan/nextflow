
process fastQC {
    debug true
    conda 'bioconda::fastqc=0.12.1'

    input:
    path reads
    path 'out'

    output:
    path "${reads}"

    script:
    """
    fastqc -o out -f fastq -q ${reads}
    """
}