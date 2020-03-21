#!/usr/bin/env nextflow
echo true

Channel
    .fromPath("../test_data/*.fq")
    .splitFastq(record:true)
    .println {record -> record.readHeader}
