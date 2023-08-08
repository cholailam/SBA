unit begin_with_pronoun;

interface

uses
  Classes, SysUtils, general, StrUtils;

function begin_pronoun(paragraph: ansistring): integer;

var
  sentences: TStringArray;
  line: ansistring;
  words: TStringArray;
  count: integer;
  pronouns: array of String = ('He', 'She', 'It', 'I', 'We', 'You', 'They');

implementation

function begin_pronoun(paragraph: ansistring): integer;
begin
  count := 0;
  sentences := to_array(paragraph, '.');
  for line in sentences do
  begin
    words := to_array(Trim(line), ' ');
    if (words[0] in pronouns)then
    begin
      count := count + 1;
    end;
  end;
  begin_pronoun := count;
end;

end.
