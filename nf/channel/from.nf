#!/usr/bin/env nextflow

//all 3 syntax methods are equal
a1 = Channel.from(1,2,3,4)
a2 = Channel.from(1..4)
Channel
    .from(1,2,3,4)
    .set {a3}
println a1
println a2
println a3

//two methods for a sole emission
b1 = [1, 2, 3, 4]
println b1
Channel.from(1,2,3,4).collect().println()