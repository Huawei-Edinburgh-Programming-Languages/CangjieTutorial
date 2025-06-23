import std.sort.*
import std.random.*
main(){
    let r: Random = Random()
    let arr: Array<UInt16> = Array<UInt16>(15, { _ => r.nextUInt16() })
    arr.sort(stable: true)

    let arr2: Array<UInt16> = Array<UInt16>(15, { _ => r.nextUInt16() })
    arr2.sortBy(stable: true) { rht: UInt16, lht: UInt16 =>
        if (rht > lht) {
            return Ordering.LT
        }
        if (rht < lht) {
            return Ordering.GT
        }
        return Ordering.EQ
    }

    for(x in arr){
        print("${x} ")
    }
    println()
    for(x in arr2){
        print("${x} ")
    }
    println()
}