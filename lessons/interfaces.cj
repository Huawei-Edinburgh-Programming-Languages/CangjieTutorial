









interface Ia { // 'open' modifier is optional.
    func f(): Unit
}
interface Ib {
    func g(): Int64
}

class C <: Ia & Ib {
    func f() : Unit{
        println("Function F is implemented")
    }
    func g() : Unit{
        println("Function G is implemented")
        return 5
    }
}






