#!/usr/local/bin nextflow


// create one text
params.output = '/home/yuan/bio/nextflow/process_output'

process randomNum {
    output:
    file "result.txt"

    '''
    echo $RANDOM > result.txt
    '''
}

workflow {
  numbers = randomNum()
  numbers.view { "Received: ${it.text}" }
}