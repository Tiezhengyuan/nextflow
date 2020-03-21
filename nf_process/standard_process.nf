#!/usr/bin/env nextflow
echo true;

//two processes: step1->step2


s1_ch = Channel.from(1,2,3)

//There are two processes 
//this process, input, output and script block are included
process step1{
    input:
    val x from s1_ch

    output:
    val x into s2_ch
    """
    echo "step1: $x"
    """
}

process step2{
    input:
    val x from s2_ch

    """
    echo "step2: $x"
    """
}
