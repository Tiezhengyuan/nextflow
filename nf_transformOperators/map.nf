#!/usr/bin/env nextflow
echo true

//x = Channel.from(1, 2, 3).map { it * it }
//println x 

//y = Channel.from(1, 2, 3).map { it ->[it*it] }
//println y

z = Channel.from(1, 2, 3).map { it ->[it*10, it*100] }
println z

//z = Channel.from(1, 2, 3)
//             .flatMap { it -> [number: it, square: it*it] }
//             .subscribe { print it.key + ':' + it.value + '\n'}
//println z


