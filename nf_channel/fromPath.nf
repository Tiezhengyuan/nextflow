#!/usr/bin/env nextflow
echo true

//get file using fromPath90

Channel
    .fromPath('../test_data/*_R1*.fq', type: 'file')
    .set {fq_files}

process print1{
    input:
    file fq_file from fq_files
    
    script:
    """
    echo "Hello $fq_file"
    """
    
   
}


