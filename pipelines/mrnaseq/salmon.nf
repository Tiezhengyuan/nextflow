/*
    input: single-end or paried-end in fastq
    aligner: salmon
    QC: MultipleQC

    example:
      nextflow run pipelines/mrnaseq/salmon.nf \
        -c pipelines/mrnaseq/salmon_paired_fq.config
*/

include { alignPaired } from '../../modules/salmon'
include { multiQC } from '../../modules/multiqc'

workflow {
  
  main:
    if ( params.mode == "paired_fq" ) {
      Channel
        .fromFilePairs( params.reads, checkIfExists: true ) 
        .set { ch_pair }
      ch_aln = alignPaired( params.index, params.options, ch_pair )
    }
    ch_qc = multiQC( ch_aln, params.multiqc_config )

  emit:
    ch_aln.view {
      println "output of alignment: ${it}"
    }
    ch_qc.view {
      println "output of QC: ${it}"
    }
}