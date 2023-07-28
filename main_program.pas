program project1;

uses
  split_string, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes; {to use TStringList}

var


begin
  writeln((get_file('text.txt'))[4]);
  readln();
end.
