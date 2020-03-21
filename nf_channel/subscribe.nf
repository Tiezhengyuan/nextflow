#!/usr/bin/env nextflow

//method 1
Channel
    .from(1,2,3,4)
    .subscribe {println it}

//method 2
a1 = Channel.from(1,2,3,4)
a1.subscribe {println it}

//method 3
Channel
    .from('abc', '3b', '32431')
    .subscribe { String it -> 
        println "${it}:${it.size()}"
        println "---"
     }


"""
return error due null object
Channel
    .from(1,2,3,4)
    .set {a1}
    .subscribe {println it}
"""