#!/usr/bin/env nextflow
echo true;

//force channel in one process using collect()

Channel.from(1,2,3)
       .collect()
       .set {ch1}


process step1{
    input:
    val x from ch1

    """
    echo "step1: $x"
    """
}

