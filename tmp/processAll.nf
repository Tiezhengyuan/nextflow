#!/usr/bin/env nextflow
echo true


Channel.fromPath('test_data/*.fq').set { samples_ch }
println samples_ch
process foo {
  input:
  file x from samples_ch
  output:
  file 'file.fq' into unzipped_ch
  script:
  """
  < $x zcat > file.fq
  """
}

process bar {
  echo true
  input:
  file '*.fq' from unzipped_ch.collect()
  """
  cat *.fq
  """
}


