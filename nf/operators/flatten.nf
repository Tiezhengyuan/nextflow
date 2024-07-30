#!/usr/bin/env nextflow
echo true

Channel
    .from([0,9], 1, 4, [5, [4,7]])
    .flatten()
    .set { a }

process f{
    input:
    val x from a

    script:
    """
    echo $x
    """

}