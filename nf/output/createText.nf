#!/usr/local/bin nextflow

//create 3 text files
files = []
process text {
  debug true
  output:
    file '*.txt' into files

  script:
    """
    echo Hello there! > file1.txt
    echo What a beautiful day > file2.txt
    echo I wish you are having fun1 > file3.txt
    """
}

workflow {
  text()
}


