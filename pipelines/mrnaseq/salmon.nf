/*
    input: single-end or paried-end in fastq
    aligner: salmon
    QC: MultipleQC

    example:
      nextflow run pipelines/mrnaseq/salmon.nf \
        -c pipelines/mrnaseq/salmon_paired_fq.config
*/

include { alignPaired; alignSingle } from '../../modules/salmon'
include { fastQC } from '../../modules/fastqc'
include { multiQC } from '../../modules/multiqc'

qc_outdir = file("${params.outDir}/fastqc")
if ( ! qc_outdir.isDirectory() ) {
    qc_outdir.mkdirs()
}

workflow {
  
  main:
    if ( params.mode == "paired_end" ) {
      Channel
        .fromFilePairs( params.reads, checkIfExists: true )
        .set { ch_pair }
      ch_aln = alignPaired( ch_pair )

      Channel
        .fromPath( params.reads, checkIfExists: true )
        .set { ch_reads }
      ch_fastqc = fastQC(ch_reads, qc_outdir)
    } else if ( params.mode == "single_end" ) {
      Channel
        .fromPath( params.reads, checkIfExists: true )
        .set { ch_single }
      ch_fastqc = fastQC(ch_single, qc_outdir)
      ch_aln = alignSingle( ch_single )
    }
    ch_qc = multiQC(ch_aln, params.multiqc_config)

  emit:
    ch_aln.view {
      println "output of alignment: ${it}"
    }
    ch_qc.view {
      println "output of MultiQC: ${it}"
    }
    ch_fastqc.view {
      println "output of FastqQC: ${it}"
    }
}