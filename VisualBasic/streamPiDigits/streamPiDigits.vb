Imports System
Imports System.IO
Imports System.Numerics

Module StreamPiDigits
    Sub Main()
        Console.WriteLine("Computing Pi Decimal Digits (Spigot Algorithm - Infinite)")
        Console.WriteLine("=========================================================")
        
        Dim logFile As String = "pi_digits_vb.log"
        
        Try
            Using sw As New StreamWriter(logFile)
                Console.WriteLine($"Logging to: {logFile}")
                Console.WriteLine()
                
                Console.Write("3.")
                sw.Write("3.")
                
                Dim q As BigInteger = 1
                Dim r As BigInteger = 0
                Dim t As BigInteger = 1
                Dim k As BigInteger = 1
                Dim n As BigInteger = 3
                Dim l As BigInteger = 3
                
                Dim digitCount As Integer = 1
                Dim maxDigits As Integer = 100000
                
                For iterations = 0 To maxDigits - 1
                    If 4 * q + r - t < n * t Then
                        Console.Write(n)
                        sw.Write(n)
                        digitCount += 1
                        
                        Dim nr As BigInteger = 10 * (r - n * t)
                        n = ((10 * (3 * q + r)) / t) - 10 * n
                        q = 10 * q
                        r = nr
                        
                        If digitCount Mod 50 = 1 Then
                            Console.WriteLine()
                            sw.WriteLine()
                        End If
                        
                        If digitCount Mod 500 = 0 Then
                            Console.Error.WriteLine($"Progress: {digitCount} digits...")
                        End If
                        
                        Console.Out.Flush()
                        sw.Flush()
                    Else
                        Dim nr As BigInteger = (2 * q + r) * l
                        Dim nn As BigInteger = (q * (7 * k + 2) + r * l) / (t * l)
                        q = q * k
                        t = t * l
                        l = l + 2
                        k = k + 1
                        n = nn
                        r = nr
                    End If
                Next
                
                Console.WriteLine()
                Console.WriteLine($"Finished. Generated {digitCount} digits.")
                sw.WriteLine($"Finished. Generated {digitCount} digits.")
            End Using
        Catch ex As Exception
            Console.WriteLine($"Error: {ex.Message}")
        End Try
    End Sub
End Module
