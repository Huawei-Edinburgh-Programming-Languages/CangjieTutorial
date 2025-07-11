import stdx.effect.*

class Luka <: Command<String> {}
class Alin <: Command<Unit> {}
class Eff <: Command<Unit> {}

main() {
    // Deferred Resumptions
    let res: Box<Option<Resumption<String, Unit>>> = Box<Option<Resumption<String, Unit>>>(None)
    try {
        println(0)
        println(perform Luka())
        println(3)
    } handle (_: Luka, next: Resumption<String, Unit>) {
        //                               |      - return type of resumption
        //                               - expected type to resume with

        // res: Resumption<A, B>
        // (resume next with <A>) : B
        println(1)
        res.value = Some(next)
    }

    println(2)
    resume res.value.getOrThrow() with "resumed from outside"
    println(4)

    // Resumption with return type
    let res2: Box<Option<Resumption<Unit, String>>> = Box<Option<Resumption<Unit, String>>>(None)
    try {
        perform Alin()
        "try block"
    } handle (_: Alin, next: Resumption<Unit, String>) {
        res2.value = Some(next)
        "handle block"
    }

    println(resume res2.value.getOrThrow())

    let res3: Box<Option<Resumption<Unit, String>>> = Box<Option<Resumption<Unit, String>>>(None)
    let cnt: Box<Int64> = Box(0)
    let val = try {
        perform Eff()
        println("returned back to first perform")
        perform Eff()
        println("returned back to the secoond perform")
        "try block. cnt = ${cnt.value}"
    } handle (_: Eff, next: Resumption<Unit, String>) {
        cnt.value++
        res3.value = Some(next)
        "handle block. cnt = ${cnt.value}"
    }

    // Eff() is performed at the line 42. The handler increments cnt, saves resumption state, and returns
    // "handle block. cnt = 1" string that's stored in val
    println(val)
    // Value of cnt is 1 now 
    println(cnt)
    // Will jump to and execute lines 43 and 44
    // and will then jump to handler and return the string "handle block. cnt = 2"
    println(resume res3.value.getOrThrow())
    // The confusion may arise here when we call the handler for the second time.
    // As it does not contain resume statement you may think it should continue executing
    // lines 53-58 like before, but that's not true. Let's explain what happens in detail

    // First, when we reach try-handle clause a new stack is created and execution is switched to this stack.
    // When Eff is performed for the first time and handler finishes, what happens is that we return to the main
    // stack and that's why lines 56-61 get executed. Then, as we resume the effect, execution will switch stacks
    // again. After Eff is performed at the line 45 and handler finishes, the stack gets switched back to the
    // main one, which was stopped at the line 61. So we proceed from here.

    // val is not updated, it's value is "handle block. cnt = 1" again
    println(val)
    // handler got executed two times so cnt is 2
    println(cnt)
}

// Output:
// 0
// 1
// 2
// resumed from outside
// 3
// 4
// try block
// handle block. cnt = 1
// 1
// returned back to first perform
// handle block. cnt = 2
// handle block. cnt = 1
// 2
