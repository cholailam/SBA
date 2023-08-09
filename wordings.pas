unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils;

function frequency(paragraph: ansistring):
function begin_pronoun(paragraph: ansistring): integer;


implementation

function begin_pronoun(paragraph: ansistring): integer;
var
  sentences, words: TStringArray;
  line: ansistring;
  count: integer;
  pronouns: array of String = ('He', 'She', 'It', 'I', 'We', 'You', 'They');
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
