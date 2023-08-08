program english_writing_analyser;

uses
  general, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes,  {to use TStringList}
  begin_with_pronoun,
  StrUtils;

var
  link: string;
  paragraph: TStringList;
  count: integer;

begin
  write('Input the name of text file: ');
  readln(link);
  paragraph := get_file(link);
  writeln(paragraph[0]);
  count :=  begin_pronoun(paragraph[0]);
  writeln(count);
  readln();
end.
