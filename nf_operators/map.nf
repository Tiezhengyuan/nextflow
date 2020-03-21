#!/usr/bin/env nextflow
echo true

x = Channel.from(1, 2, 3).map { it * it }
println x 

y = Channel.from(1, 2, 3).map { it -> [it*it] }
process testy{
    input:
    val a from y

    """
    echo $a
    """
}
//return tuple
z = Channel.from(1, 2, 3).map { it -> [it, it*10 + it] }

process testz{
    input:
    set a, b from z

    """
    echo $a, $b
    """
}

