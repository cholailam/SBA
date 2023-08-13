unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, Generics.Collections;

function frequency(paragraph: ansistring): specialize TDictionary<string, integer>;
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



function frequency(paragraph: ansistring): specialize TDictionary<string, integer>;
var
  sentences, words: TStringArray;
  line, each_word: ansistring;
  fre: specialize TDictionary<string, integer>;
begin
  fre := specialize TDictionary<string, integer>.Create;
  sentences := to_array(paragraph, '.');
  for line in sentences do
  begin
    words := to_array(Trim(line), ' ');

    for each_word in words do
    begin
      try
        fre.add(each_word, 1);
      except
        on E: Exception do
          fre[each_word] := fre[each_word] +1;
      end;
    end;

  end;
  frequency := fre;
end;



end.
