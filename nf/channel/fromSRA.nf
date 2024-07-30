#!/usr/bin/env nextflow
echo true

//get SRA files based on SRA accession number

ids = ['ERR908507', 'ERR908506', 'ERR908505']
sra = Channel.fromSRA(ids)

process getSRA{
    input:
    val sra

    output:
    val sra into receiver
    
    script:
    """
    echo $sra
    """
}

receiver.println {"$it"} 