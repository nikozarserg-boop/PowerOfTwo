$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$logFile = Join-Path $scriptDir "PowerOfTwo.log"

if (Test-Path $logFile) {
    Remove-Item $logFile
}

$stream = [System.IO.StreamWriter]::new($logFile, $false)

$header = "Computing powers of two (Big Integer)"
$separator = "======================================"

$stream.WriteLine($header)
$stream.WriteLine($separator)
$stream.WriteLine("")
$stream.Flush()

Write-Host $header
Write-Host $separator
Write-Host ""

# Use .NET BigInteger
$type = [System.Numerics.BigInteger]
$num = $type::new(1)
$power = 0
$two = $type::new(2)

try {
    while ($true) {
        $result = "2^$power = $num"
        
        $stream.WriteLine($result)
        $stream.Flush()
        Write-Host $result
        
        $num = $num * $two
        $power++
    }
}
finally {
    $stream.Close()
    $stream.Dispose()
}
