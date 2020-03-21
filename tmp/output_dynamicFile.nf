#!/usr/bin/env nextflow
echo true

fa_ch = Channel.fromPath('../test_data/*.fa')

process alignment{
    input:
    file fa_file from fa_ch

    output:
    file  "${fa_file.baseName}.aln" into hit_ch

    """
    echo sequence alignment > ${fa_file.baseName}.aln
    """
}

process filleroutHits{
    input:
    path aln_file from hit_ch

    output:
    file "$aln_file" into res_ch

    """
    echo "analyze hit $aln_file"
    """
}

//export content to target file
res_ch.collectFile(it -> "../test_data/${it.baseName}_hits.txt")
    
