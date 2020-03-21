#!/usr/bin/env nextflow
echo true

//generate range string sequences
//generate 23 sets. There are sampleid and del.vcf name and snp.vcf name
Channel
  .from(1..23)
  .map { chr -> tuple("chr$chr", file("human.chr${chr}.del.vcf"), file("human.chr${chr}.snp.vcf")) }
  .set { pairs_ch }


process foo {
  tag "$sampleId"

  input:
  set sampleId, file(dels), file(snps) from pairs_ch

  """
  echo $sampleId
  echo $dels
  echo $snps
  """
}
