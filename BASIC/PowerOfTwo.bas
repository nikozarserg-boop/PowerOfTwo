Declare Sub MultiplyBy2(digits() As Integer, ByRef count As Integer)
Declare Function ToString(digits() As Integer, count As Integer) As String

Dim digits(10000) As Integer
Dim count As Integer
Dim logPath As String
Dim logFile As Integer
Dim header As String
Dim separator As String
Dim power As Long
Dim result As String

logPath = CurDir & "\PowerOfTwo.log"
logFile = FreeFile
Open logPath For Output As logFile

header = "Computing powers of two (Big Integer)"
separator = "======================================"

Print #logFile, header
Print #logFile, separator
Print #logFile, ""

Print header
Print separator
Print ""

digits(0) = 1
count = 1
power = 0

Do While True
    result = "2^" & Str(power) & " = " & ToString(digits(), count)
    Print #logFile, result
    Print result
    MultiplyBy2 digits(), count
    power = power + 1
Loop

Close logFile
End

Sub MultiplyBy2(digits() As Integer, ByRef count As Integer)
    Dim i As Integer
    Dim product As Integer
    Dim carry As Integer
    
    carry = 0
    For i = 0 To count - 1
        product = digits(i) * 2 + carry
        digits(i) = product Mod 10
        carry = product \ 10
    Next i
    
    While carry > 0
        digits(count) = carry Mod 10
        carry = carry \ 10
        count = count + 1
    Wend
End Sub

Function ToString(digits() As Integer, count As Integer) As String
    Dim result As String
    Dim i As Integer
    
    result = ""
    For i = count - 1 To 0 Step -1
        result = result & Str(digits(i))
    Next i
    
    ToString = result
End Function
