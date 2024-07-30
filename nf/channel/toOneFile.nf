#!/usr/local/bin nextflow

// export list to text
workflow {
    Channel.of('alpha', 'beta', 'gamma')
    .collectFile(name: 'sample.txt', newLine: true)
    .subscribe(el -> {
        println "Entries are saved to file: $el"
        println "File content is: ${el.text}"
    })
}