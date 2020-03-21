#!/usr/bin/env nextflow
echo true

Channel
    .fromPath('test_data/*_R1*.fq', type: 'file')
    .set {fq_files}

process print1{
    input:
    file fq_file from fq_files
    
    script:
    """
    echo "Hello $fq_file"
    """
    
   
}
println fq_files


