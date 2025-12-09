Imports System
Imports System.IO

Module PowerOfTwo
    Sub Main()
        Dim logPath As String = Path.Combine(Directory.GetCurrentDirectory(), "PowerOfTwo.log")
        
        Try
            Using logFile As New StreamWriter(logPath)
                Dim header As String = "Computing powers of two (Big Integer)"
                Dim separator As String = "======================================"
                
                logFile.WriteLine(header)
                logFile.WriteLine(separator)
                logFile.WriteLine("")
                logFile.Flush()
                
                Console.WriteLine(header)
                Console.WriteLine(separator)
                Console.WriteLine("Press Ctrl+C to stop")
                Console.WriteLine("")
                
                Dim digits As Integer() = New Integer(10000) {}
                Dim count As Integer = 1
                Dim power As Long = 0
                Dim maxPowers As Long = 10000
                
                digits(0) = 1
                
                While power < maxPowers
                    Dim result As String = "2^" & power & " = " & ToString(digits, count)
                    
                    logFile.WriteLine(result)
                    Console.WriteLine(result)
                    
                    If power Mod 100 = 0 Then
                        logFile.Flush()
                        Console.Error.WriteLine($"Progress: {power} powers computed, {count} digits")
                    End If
                    
                    MultiplyBy2(digits, count)
                    power = power + 1
                End While
                
                Console.WriteLine($"Finished. Computed {power} powers with {count} digits")
                logFile.WriteLine($"Finished. Computed {power} powers with {count} digits")
                logFile.Flush()
            End Using
            
            Console.WriteLine($"Results saved to: {logPath}")
        Catch ex As Exception
            Console.WriteLine($"Error: {ex.Message}")
        End Try
    End Sub
    
    Sub MultiplyBy2(digits As Integer(), ByRef count As Integer)
        Dim i As Integer
        Dim product As Integer
        Dim carry As Integer = 0
        
        For i = 0 To count - 1
            product = digits(i) * 2 + carry
            digits(i) = product Mod 10
            carry = product \ 10
        Next i
        
        While carry > 0
            If count >= digits.Length Then
                ReDim Preserve digits(digits.Length + 1000)
            End If
            digits(count) = carry Mod 10
            carry = carry \ 10
            count = count + 1
        End While
    End Sub
    
    Function ToString(digits As Integer(), count As Integer) As String
        Dim result As String = ""
        Dim i As Integer
        
        For i = count - 1 To 0 Step -1
            result = result & digits(i).ToString()
        Next i
        
        Return result
    End Function
End Module
