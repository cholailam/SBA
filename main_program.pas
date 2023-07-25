program project1;

uses split_string, SysUtils;

var
  test: TStringArray;
  line: string;

begin
  writeln('Input a sentence: ');
  readln(line);
  test := change(line);
  writeln(test[2]);

  readln();
end.
