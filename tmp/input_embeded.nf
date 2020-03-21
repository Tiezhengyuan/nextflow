#!/usr/bin/env nextflow
echo true

Channel.fromPath('../test_data/*_R1*.fq')
       .map { file -> [file.baseName, file] }
       .groupTuple()
       .set {R1}
Channel.fromPath('../test_data/*_R2*.fq')
       .map { file -> [file.baseName, file] }
       .groupTuple()
       .set {R2}

process test{
    input:
    val R1ID, file(r1) from R1
    val R2ID, file(r2)  from R2

    """
    echo "$R1ID, $R2ID"
    """
}