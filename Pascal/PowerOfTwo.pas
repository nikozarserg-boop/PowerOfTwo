{$mode objfpc}{$H+}

program PowerOfTwo;

uses
  SysUtils, Classes;

type
  TBigInt = class
  private
    digits: array of Integer;
    count: Integer;
  public
    constructor Create(value: Integer);
    destructor Destroy; override;
    procedure MultiplyBy2;
    function ToString: string; override;
  end;

constructor TBigInt.Create(value: Integer);
begin
  inherited Create;
  SetLength(digits, 1);
  digits[0] := value;
  count := 1;
end;

destructor TBigInt.Destroy;
begin
  SetLength(digits, 0);
  inherited;
end;

procedure TBigInt.MultiplyBy2;
var
  i, product, carry: Integer;
begin
  carry := 0;
  for i := 0 to count - 1 do
  begin
    product := digits[i] * 2 + carry;
    digits[i] := product mod 10;
    carry := product div 10;
  end;

  while carry > 0 do
  begin
    if count >= Length(digits) then
      SetLength(digits, count + 10);
    digits[count] := carry mod 10;
    carry := carry div 10;
    Inc(count);
  end;
end;

function TBigInt.ToString: string;
var
  i: Integer;
begin
  Result := '';
  for i := count - 1 downto 0 do
    Result := Result + IntToStr(digits[i]);
end;

var
  logFile: TextFile;
  logPath: string;
  value: TBigInt;
  power: Int64;
  result: string;
  header: string;
  separator: string;

begin
  { Get log file path }
  logPath := GetCurrentDir + PathDelim + 'PowerOfTwo.log';

  { Create/overwrite log file }
  AssignFile(logFile, logPath);
  Rewrite(logFile);

  header := 'Computing powers of two (Big Integer)';
  separator := '======================================';

  WriteLn(logFile, header);
  WriteLn(logFile, separator);
  WriteLn(logFile, '');

  WriteLn(header);
  WriteLn(separator);
  WriteLn('');

  value := TBigInt.Create(1);
  power := 0;

  try
    while True do
    begin
      result := '2^' + IntToStr(power) + ' = ' + value.ToString;

      WriteLn(logFile, result);
      Flush(logFile);
      WriteLn(result);

      value.MultiplyBy2;
      Inc(power);
    end;
  finally
    value.Free;
    CloseFile(logFile);
  end;
end.
