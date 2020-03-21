#!/usr/bin/env nextflow
echo true

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