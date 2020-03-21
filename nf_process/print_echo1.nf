#!/usr/bin/env nextflow
echo true

x = Channel.from('a', 'b', 'c')

process print2{
    input:
    val e from x

    script:
    """
    echo 'process $e'
    """

}


