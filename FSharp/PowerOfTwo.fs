module PowerOfTwo

open System
open System.IO

let logPath = Path.Combine(__SOURCE_DIRECTORY__, "PowerOfTwo.log")
let logFile = new StreamWriter(logPath, false)

let header = "Computing powers of two (Big Integer)"
let separator = "======================================"

logFile.WriteLine(header)
logFile.WriteLine(separator)
logFile.WriteLine("")
logFile.Flush()

printfn "%s" header
printfn "%s" separator
printfn ""

let rec computePowers (value: bigint) (power: int) =
    let result = sprintf "2^%d = %A" power value
    logFile.WriteLine(result)
    logFile.Flush()
    printfn "%s" result
    computePowers (value * 2I) (power + 1)

try
    computePowers 1I 0
finally
    logFile.Close()
