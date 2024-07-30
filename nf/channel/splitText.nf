#!/usr/bin/env nextflow

// splitText() return 1-n lines at a time
// return 2 lines
workflow {
    Channel
        .fromPath('data/sample.txt') 
        .splitText(by: 2)
        .view()
}