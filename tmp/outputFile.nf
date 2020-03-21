#!/usr/bin/env nextflow
echo true

x = ['a', 'b', 'c']

process test{
    input:
    val e from x

    output:
    val e into receiver



}
receiver.println {"$it"}
