#!/usr/local/bin nextflow

// an optional closure paramerter define what items could be exported
workflow {
    Channel
        .fromPath('test_data/sequences.fa')
        .splitFasta( record: [id: true, sequence: true] )
        .collectFile( name: 'result.fa', sort: { it.size() } ) {
            it.sequence
        }
        .view { it.text }
}