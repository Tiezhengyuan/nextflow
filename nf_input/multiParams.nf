#!/usr/local/bin nextflow

process bar {
    debug true
    input:
        val x
        val y

    script:
        """
        echo $x and $y
        """
}

workflow {
  x = Channel.value(1)
  y = Channel.of('a', 'b', 'c')
  bar(x, y)
}