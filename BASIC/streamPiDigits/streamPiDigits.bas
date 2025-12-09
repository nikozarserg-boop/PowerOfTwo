'' Computing Pi Decimal Digits using Spigot Algorithm
'' Improved version with logging and better performance

DECLARE FUNCTION ComputePiSpigot() AS LONG

CONST MAX_DIGITS = 100000
CONST LEN_ARR = (10 * MAX_DIGITS) \ 3
CONST LOG_INTERVAL = 500

DIM a(LEN_ARR) AS INTEGER
DIM i, j, q, x, nines, predigit AS LONG
DIM digitCount AS LONG
DIM logFile AS STRING
DIM fileNum AS INTEGER

logFile = "pi_digits_bas.log"
fileNum = FREEFILE

PRINT "Computing Pi Decimal Digits (Spigot Algorithm - Infinite)"
PRINT "=========================================================="

'' Open log file
OPEN logFile FOR OUTPUT AS fileNum

'' Initialize array
FOR j = 1 TO LEN_ARR
    a(j) = 2
NEXT

nines = 0
predigit = 0
digitCount = 1

PRINT "3."; : PRINT #fileNum, "3.";

'' Main computation loop
FOR j = 1 TO MAX_DIGITS
    q = 0
    
    '' Inner loop for spigot algorithm
    FOR i = LEN_ARR TO 1 STEP -1
        x = 10 * a(i) + q * i
        a(i) = x MOD (2 * i - 1)
        q = x \ (2 * i - 1)
    NEXT
    
    a(1) = q MOD 10
    q = q \ 10
    
    '' Output digit or handle carries
    IF q = 9 THEN
        nines = nines + 1
    ELSE IF q = 10 THEN
        PRINT predigit + 1;
        PRINT #fileNum, predigit + 1;
        digitCount = digitCount + 1
        FOR k = 1 TO nines
            PRINT "0";
            PRINT #fileNum, "0";
            digitCount = digitCount + 1
        NEXT
        predigit = 0
        nines = 0
    ELSE
        PRINT predigit;
        PRINT #fileNum, predigit;
        digitCount = digitCount + 1
        predigit = q
        IF nines <> 0 THEN
            FOR k = 1 TO nines
                PRINT "9";
                PRINT #fileNum, "9";
                digitCount = digitCount + 1
            NEXT
            nines = 0
        END IF
    END IF
    
    '' Format output
    IF (digitCount MOD 50) = 1 THEN
        PRINT
        PRINT #fileNum, ""
    END IF
    
    '' Progress indicator
    IF (digitCount MOD LOG_INTERVAL) = 0 THEN
        PRINT #fileNum, ""
        PRINT "Progress: "; digitCount; " digits..."
        PRINT #fileNum, "Progress: "; digitCount; " digits..."
    END IF
NEXT

'' Output final digit and close file
PRINT
PRINT #fileNum, ""
PRINT "Finished. Generated "; digitCount; " digits."
PRINT #fileNum, "Finished. Generated "; digitCount; " digits."

CLOSE fileNum
PRINT "Results saved to "; logFile
