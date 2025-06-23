main(){
    var i = 1
    while( i <= 3){
        println(i)
        i++
    }

    for (j in 0..3){
        println(j)
    }

    for (j in 0..=3){
        println(j)
    }
    let words= ["This", "is", "Cangjie"]
    for (word in words){
        println(word)
    }
    
    let array = [(1, 2), (3, 4), (5, 6)]
    for ((x,y) in array){
        println("${x}, ${y}")
    }

    for (j in 0..8 where j%2 == 1){
        println(j)
    }
    var number = 2
    for(_ in 0..3){
        number*=number
    }
    println(number)
}