#!/usr/bin/env nextflow
echo true


a1 = Channel.from(1,2,3,4)
a2 = [1, 2, 3, 4]
a3 = Channel.from(1..4)