#!/usr/bin/env nextflow
echo true

//embed pthon code
process runPrint {

    """
    #!/usr/bin/python
    x = 'Hello'
    y = 'cbb'
    print("%s - %s" % (x,y))
    """

}



