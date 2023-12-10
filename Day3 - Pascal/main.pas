program AOC202303;
{$mode objfpc}{$H+}
uses
        Sysutils, Strutils;

type
Coordinate = record
        x: UInt8;
        y: UInt8;
end;

type
Number = record
        number: UInt16;
        coords: Coordinate;
        Length: UInt8;
end;

function CheckNext(s: string; i: Integer): boolean;
var
        n: Integer;
        Code: Integer;
begin
        try

                Val(s[i+1], n, Code);
                if Code <> 0 then
                        CheckNext := False
                else
                        CheckNext := True;
        except
                on E: EAccessViolation do
                        CheckNext := False;
        end;
end;

function ReadWholeFile(filepath: string): string;
var
        tfIn: TextFile;
        line: string;
        s: string;
begin
        AssignFile(tfIn, filepath);
        try
                s := '';
                reset(tfIn);
                while not eof(tfIn) do
                begin
                        readln(tfIn, line);
                        s := s + line + sLineBreak;
                end;
                CloseFile(tfIn);
        except
                on E: EInOutError do
                        writeln('An error occured while handling the file: ', E.Message);
        end;
        ReadWholeFile := s;
end;

function SolveDay1(s: string): Integer;
var
        lines: Array of string;
        l: String;
        n: Integer;
        numbers: Array of Number;
        tempNumber: Number;
        tempCoord: Coordinate;
        c: char;
        Code: Integer;
        y: Integer;
        sb: String;
        start: Integer;
        j: Integer;
        i: Integer;
        position: Integer;
        isNumeric: boolean;
        currX: Integer;
        currY: Integer;
        num: Integer;
begin
        lines := SplitString(s, sLineBreak);

        SetLength(numbers, 0);

        y := 0;
        j := 0;

        for l in lines do
        begin
                y := y + 1;
                i := 1;
                while i < Length(l) do
                begin
                        val(l[i], n, Code);
                        if Code = 0 then
                        begin
                                start := i;
                                sb := IntToStr(n);
                                while CheckNext(l, i) do
                                begin
                                        i := i + 1;
                                        val(l[i], n, Code);
                                        sb := sb + IntToStr(n);
                                end;
                                val(sb, n, Code);
                                tempNumber.number := n;
                                tempCoord.x := start;
                                tempCoord.y := y;
                                tempNumber.coords := tempCoord;
                                tempNumber.Length := i - start;
                                SetLength(numbers, j+1);
                                numbers[j] := tempNumber;
                                j := j + 1;
                                i := i + 1;
                        end
                        else
                                i := i + 1;
                end;
        end;

        y := 0;

        for num in numbers do
        begin
                for i:=0 to num.Length-1 do
                begin
                        currX := num.coords.x + i;
                        currY := num.coords.y;
                        c := lines[currY][currX];
                        writeln(c);
                end;
        end;
        SolveDay1:=69;
end;



// main function
const
        C_FName = 'sample.txt';
var
        s: string;
        lines: Array of string;
        l: string;
        numbers: Array of Number;
        tempNumber: Number;
        tempCoord: Coordinate;
        c: char;
        n: Integer;
        Code: Integer;
        y: Integer;
        sb: string;
        start: Integer;
        j: Integer;
        i: Integer;
begin
        writeln('Input File: ',C_FName);
        writeln('Current Directory: ', GetCurrentDir);
        s := ReadWholeFile(C_FName);
        SolveDay1(s);
        readln;
end.
