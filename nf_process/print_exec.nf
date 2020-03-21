#!/usr/bin/env nextflow


x = Channel.from('a', 'b', 'c')

process print1{
    input:
    val x

    exec:
    println "Hello $x"

}


