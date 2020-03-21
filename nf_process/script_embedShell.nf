#!/usr/bin/env nextflow
echno true;

a = Channel.from(1,2,3)

//this process, input and script block are included
process test{
    input:
    val x from a

    """
    echo $x
    """
}