#!/usr/bin/env nextflow
echo true;

//channel is values
s1_ch = Channel.from(1,2,3)

process test{
    input:
    val x from s1_ch

    """
    echo $x
    """

}