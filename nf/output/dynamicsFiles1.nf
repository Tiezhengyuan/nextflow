Channel
   .from('Hola', 'Ciao', 'Hello', 'Bonjour', 'Halo')
   .collectFile() { item ->
       [ "${item[0]}.txt", item + '\n' ]
   }
   .subscribe {
       println it
       println "File ${it.name} contains:"
       println it.text
   }
