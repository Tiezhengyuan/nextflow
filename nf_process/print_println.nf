#!/usr/bin/env nextflow

//two syntax using println

Channel.from('a', 'b', 'c')
       .println{"$it"}

Channel.from('qwe', 'ccd', 'a3c')
       .subscribe { println it }