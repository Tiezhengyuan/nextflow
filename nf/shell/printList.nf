#!/usr/local/bin nextflow

names = channel.from("A", "B", "C", "D", "E", "F")

process sayHello {
    debug true
    input:
	    val x
    script:
	    """
        echo "${x} is printed!"
        """
}

workflow {
    sayHello(names)
}