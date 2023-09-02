unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, math, Generics.Collections;

function find_max_fre(fre_of_vocab: TIntegerArray): integer;
function freq_of_keyword(keyword: string; all_words: specialize TList<string>): integer;
function begin_pronoun(paragraph: ansistring): integer;


implementation


{return the index of max value}
function find_max_fre(fre_of_vocab: TIntegerArray): integer;
var
  max_fre: integer;
  i: integer;
begin
  max_fre := maxvalue(fre_of_vocab);
  for i := 0 to (length(fre_of_vocab)-1) do
  begin
    if (fre_of_vocab[i] = max_fre) then
    find_max_fre := i;
  end;
  find_max_fre := -1;
end;


function freq_of_keyword(keyword: string; all_words: specialize TList<string>): integer;
var
  count: integer;
  word: string;
begin
  for word in all_words do
  begin
    if (word = keyword) then
      count += 1;
  end;
  freq_of_keyword := count;
end;


function begin_pronoun(paragraph: ansistring): integer;
const
  pronouns: array[0..6] of String = ('He', 'She', 'It', 'I', 'We', 'You', 'They');
var
  sentences, words: TStringArray;
  line: ansistring;
  count: integer;
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
