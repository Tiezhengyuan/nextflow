#!/usr/bin/env nextflow
echo true;

//two processes: step1 and step2 are concurrent using separate()

ch1 = Channel.create()
ch2 = Channel.create()
Channel.from(1,2,3)
       .separate (ch1, ch2) { it -> [it, it] }

//There are two processes 
//this process, input, output and script block are included
process step1{
    input:
    val x from ch1

    """
    echo "step1: $x"
    """
}

process step2{
    input:
    val x from ch2

    """
    echo "step2: $x"
    """
}
