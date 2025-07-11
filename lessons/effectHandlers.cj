import stdx.effect.Command

class Example <: Command<Int64> {}
class Luka <: Command<Unit> {}
class Alin <: Command<Unit> {}
class Teo <: Command<Unit> {}
class Default <: Command<Unit> {
    public func defaultImpl() {
        println("defaultImpl called")
    }
}

main() {
    // Simple Example With Producing a Value
    try {
        print("Luka ")
        var foo = perform Example()
        print("Teo: ${foo} ")
    } handle (_: Example) {
        print("Alin ")
        resume with 99
    }
    println("Magnus")

    // Nested Effects and Dynamic Binding
    try { 
        // Handled with outer handler
        perform Luka()

        try {
            // Handled with inner handlers
            perform Luka()
            perform Alin()

            // Handled with outer handler as it's not available here
            perform Teo()
        } handle (_: Luka) {
            println("Luka inner")
            resume
        } handle (_: Alin) {
            println("Alin")
            resume
        }

        // After perform Teo() is handled from line 50 it is not resumed, which means we will never reach this statement
        println("Unreachable")
    } handle(_: Luka) {
        println("Luka")
        resume
    } handle(_: Teo) {
        println("Teo")
    }

    // Default Handlers
    // It is not handled here so default handlers gets called
    perform Default()
    try {
        // Handler below gets called
        perform Default()
    } handle(_: Default) {
        println("handler executed")
    }

    // The effect neither has a default handler not is handled explicitly, so an exception is thrown
    perform Alin()
}

// Luka Alin Teo: 99 Magnus
// Luka
// Luka inner
// Alin
// Teo
// defaultImpl called
// handler executed
// An exception has occurred:
// UnhandledCommand: Unhandled command
