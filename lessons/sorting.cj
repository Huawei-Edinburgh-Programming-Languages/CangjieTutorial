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

// Output:
// 8896 9497 9898 13676 20014 21950 25750 28232 32169 40515 42919 44508 47312 49574 52195 
// 64493 62191 57102 49789 48348 47837 42854 40478 40251 31855 30317 26000 19833 18909 13419 