open System
open System.IO

let computePiDigits () =
    printfn "Computing Pi Decimal Digits (Spigot Algorithm - Infinite)"
    printfn "========================================================="
    
    use logFile = new StreamWriter("pi_digits_fsharp.log")
    printfn "Logging to: pi_digits_fsharp.log\n"
    
    printf "3."
    logFile.Write("3.")
    
    let mutable q = bigint 1
    let mutable r = bigint 0
    let mutable t = bigint 1
    let mutable k = bigint 1
    let mutable n = bigint 3
    let mutable l = bigint 3
    
    let mutable digitCount = 1
    let maxDigits = 100000
    
    for iterations = 0 to maxDigits - 1 do
        if 4I * q + r - t < n * t then
            printf "%O" n
            logFile.Write(sprintf "%O" n)
            digitCount <- digitCount + 1
            
            let nr = 10I * (r - n * t)
            n <- ((10I * (3I * q + r)) / t) - 10I * n
            q <- 10I * q
            r <- nr
            
            if digitCount % 50 = 1 then
                printfn ""
                logFile.WriteLine()
            
            if digitCount % 500 = 0 then
                eprintfn "Progress: %d digits..." digitCount
            
            Console.Out.Flush()
            logFile.Flush()
        else
            let nr = (2I * q + r) * l
            let nn = (q * (7I * k + 2I) + r * l) / (t * l)
            q <- q * k
            t <- t * l
            l <- l + 2I
            k <- k + 1I
            n <- nn
            r <- nr
    
    printfn "\n\nFinished. Generated %d digits." digitCount
    logFile.WriteLine(sprintf "\n\nFinished. Generated %d digits." digitCount)

computePiDigits ()
