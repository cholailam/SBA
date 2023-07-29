unit begin_with_pronoun;

interface

uses
  Classes, SysUtils, general;

function begin_pronoun(paragraph: string): integer;

var
  sentences: TStringArray;
  line: string;
  words: TStringArray;
  count: integer;

implementation

function begin_pronoun(paragraph: string): integer;
begin
  sentences := to_array(paragraph, '.');
  for line in sentences do
  begin
    words := to_array(line, ' ');
    if (words[0] = 'He') then
    begin
      count := count + 1;
    end;
  end;
  begin_pronoun := count;
end;

end.
