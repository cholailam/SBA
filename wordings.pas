unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils;

function find_max_fre(fre_of_vocab: TList): integer;
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


{return the index of max value}
function find_max_fre(fre_of_vocab: TList): integer;
var
  max_fre: integer;
  i: integer;
begin
  max_fre := maxValue(fre_of_vocab);
  for i := 0 to (length(fre_of_vocab)-1) do
  begin
    if (fre_of_vocab[i] = max_fre) then
    find_max_fre := i;
  end;
  find_max_fre := -1;
end;



end.
