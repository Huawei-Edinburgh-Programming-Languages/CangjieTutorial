



main()
{
    let s = "hello"

    println("Len: ${s.size}")

    for(i in 0..s.size)
    {
        print("${s[i]} ")
    }

    println()

    for(i in s)
    {
        println("${i}: ${Rune(i)}") 
    }


    let c: Rune = r'T'
    println(c) 

}