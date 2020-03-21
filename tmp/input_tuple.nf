#!/usr/bin/env nextflow
echo true

//return tuple using map()
Channel
    .fromPath('../test_data/*.fa', type: 'file')
    .map{file -> (
            return tuple(file.baseName(), file)
        )}
    .set {fa_ch}

//input is file type
process print1{
    input:
    file sampleId, file(fa) from fa_ch
    
    script:
    """
    echo "sampleId: $sampleId"
    echo "fa file: fa"
    """
}



