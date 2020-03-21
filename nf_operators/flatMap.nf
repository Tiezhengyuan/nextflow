#!/usr/bin/env nextflow
echo true

Channel
    .from([1,10], 2, [0,4,3])
    .flatMap()
    .subscribe { print it}


Channel
    .from(1, 2, 3)
    .flatMap { it -> [number: it, square: it*it] }
    .subscribe { print it.key + ':' + it.value + '\n'}



