program StreamPiDigits;

uses
    SysUtils,
    Classes;

const
    N = 100000;
    LEN = (10 * N) div 3;
    LOG_INTERVAL = 500;

var
    i, j, k, q, x, nines, predigit: longint;
    digitCount: longint;
    a: array[1..LEN] of integer;
    logFile: TextFile;
    logFileName: string;
    progressMsg: string;

begin
    logFileName := 'pi_digits_pas.log';
    
    WriteLn('Computing Pi Decimal Digits (Spigot Algorithm - Infinite)');
    WriteLn('===========================================================');
    WriteLn('Logging to: ', logFileName);
    WriteLn;
    
    AssignFile(logFile, logFileName);
    Rewrite(logFile);
    
    for j := 1 to LEN do
        a[j] := 2;
    
    nines := 0;
    predigit := 0;
    digitCount := 1;
    
    Write('3.');
    Write(logFile, '3.');
    
    for j := 1 to N do
    begin
        q := 0;
        
        for i := LEN downto 1 do
        begin
            x := 10 * a[i] + q * i;
            a[i] := x mod (2 * i - 1);
            q := x div (2 * i - 1);
        end;
        
        a[1] := q mod 10;
        q := q div 10;
        
        if q = 9 then
            nines := nines + 1
        else if q = 10 then
        begin
            Write(predigit + 1);
            Write(logFile, predigit + 1);
            Inc(digitCount);
            for k := 1 to nines do
            begin
                Write('0');
                Write(logFile, '0');
                Inc(digitCount);
            end;
            predigit := 0;
            nines := 0;
        end
        else
        begin
            Write(predigit);
            Write(logFile, predigit);
            Inc(digitCount);
            predigit := q;
            if nines <> 0 then
            begin
                for k := 1 to nines do
                begin
                    Write('9');
                    Write(logFile, '9');
                    Inc(digitCount);
                end;
                nines := 0;
            end;
        end;
        
        if (digitCount mod 50) = 1 then
        begin
            WriteLn;
            WriteLn(logFile, '');
        end;
        
        if (digitCount mod LOG_INTERVAL) = 0 then
        begin
            Str(digitCount, progressMsg);
            WriteLn('Progress: ' + progressMsg + ' digits...');
            WriteLn(logFile, 'Progress: ' + progressMsg + ' digits...');
            Flush(logFile);
        end;
    end;
    
    WriteLn;
    WriteLn(logFile, '');
    Str(digitCount, progressMsg);
    WriteLn('Finished. Generated ' + progressMsg + ' digits.');
    WriteLn(logFile, 'Finished. Generated ' + progressMsg + ' digits.');
    CloseFile(logFile);
    
    WriteLn('Results saved to: ' + logFileName);
end.
