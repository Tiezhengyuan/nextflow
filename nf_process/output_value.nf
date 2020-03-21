#!/usr/bin/env nextflow
echo true

ch1 = ['a', 'b', 'c']

process step1{
    input:
    val e from ch1

    output:
    val e into ch2

    """
    echo "step1: $e"
    """
}

process step2{
    input:
    val e from ch2

    """
    echo "step2: $e"
    """
}
