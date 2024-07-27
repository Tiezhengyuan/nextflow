#!/usr/local/bin nextflow

// export list to text
workflow {
    Channel
        .of('Hola', 'Ciao', 'Hello', 'Bonjour', 'Halo')
        .collectFile (it ->{
            [ "${it}.txt", "Name is ${it}\n" ]
        })
        .subscribe( it -> {
            println "File '${it.name}' contains:"
            println it.text
        })
}