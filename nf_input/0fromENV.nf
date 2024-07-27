#!/usr/local/bin nextflow

env {
    PYTHONPATH = "${x}/utils"
}

process A {
    debug true
    input:
        env x
    script:
        """
        echo $x
        """
}

workflow {
   def env = channel.of('PATH')
   A(env)
}