program project1;

uses
  general, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes,  {to use TStringList}
  begin_with_pronoun;
var
  link: string;
  paragraph: TStringList;
  count: integer;

begin
  write('Input the link of text file: ');
  readln(link);
  paragraph := get_file(link);
  writeln(paragraph[0]);
  count :=  begin_pronoun(paragraph[0]);
  writeln(IntToStr(count));
  readln();
end.
