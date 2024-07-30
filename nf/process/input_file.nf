#!/usr/bin/env nextflow
echo true

//get files as input using fromPath()
Channel
    .fromPath('../test_data/*_R1*.fq', type: 'file')
    .set {fq_ch}

//input is file type
process print1{
    input:
    file fq_file from fq_ch
    
    script:
    """
    echo "Hello $fq_file"
    """
}



