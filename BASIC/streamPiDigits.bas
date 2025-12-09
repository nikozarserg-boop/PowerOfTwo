CONST MAX_DIGITS = 100000
CONST LEN_ARR = (10 * MAX_DIGITS) \ 3
CONST LOG_INTERVAL = 500

DIM a(LEN_ARR) AS INTEGER
DIM i, j, k, q, x, nines, predigit AS LONG
DIM digitCount AS LONG
DIM logFile AS INTEGER

logFile = FREEFILE

PRINT "Computing Pi Decimal Digits (Spigot Algorithm - Infinite)"
PRINT "=========================================================="

OPEN "pi_digits_bas.log" FOR OUTPUT AS logFile

FOR j = 1 TO LEN_ARR
    a(j) = 2
NEXT

nines = 0
predigit = 0
digitCount = 1

PRINT "3."; 
PRINT #logFile, "3.";

FOR j = 1 TO MAX_DIGITS
    q = 0
    
    FOR i = LEN_ARR TO 1 STEP -1
        x = 10 * a(i) + q * i
        a(i) = x MOD (2 * i - 1)
        q = x \ (2 * i - 1)
    NEXT
    
    a(1) = q MOD 10
    q = q \ 10
    
    IF q = 9 THEN
        nines = nines + 1
    ELSE IF q = 10 THEN
        PRINT predigit + 1;
        PRINT #logFile, predigit + 1;
        digitCount = digitCount + 1
        FOR k = 1 TO nines
            PRINT "0";
            PRINT #logFile, "0";
            digitCount = digitCount + 1
        NEXT
        predigit = 0
        nines = 0
    ELSE
        PRINT predigit;
        PRINT #logFile, predigit;
        digitCount = digitCount + 1
        predigit = q
        IF nines <> 0 THEN
            FOR k = 1 TO nines
                PRINT "9";
                PRINT #logFile, "9";
                digitCount = digitCount + 1
            NEXT
            nines = 0
        END IF
    END IF
    
    IF (digitCount MOD 50) = 1 THEN
        PRINT
        PRINT #logFile, ""
    END IF
    
    IF (digitCount MOD LOG_INTERVAL) = 0 THEN
        PRINT "Progress: "; digitCount; " digits..."
        PRINT #logFile, "Progress: "; digitCount; " digits..."
    END IF
NEXT

PRINT
PRINT #logFile, ""
PRINT "Finished. Generated "; digitCount; " digits."
PRINT #logFile, "Finished. Generated "; digitCount; " digits."

CLOSE logFile
PRINT "Results saved to pi_digits_bas.log"
