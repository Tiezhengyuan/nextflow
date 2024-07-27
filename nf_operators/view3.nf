#!/usr/local/bin nextflow

// The view operator prints the items emitted by a channel 
// to the console standard output, appending a new line character to each item.
workflow {
    Channel.of('A', 'B', 'C').view( it -> "This is ${it}")
}