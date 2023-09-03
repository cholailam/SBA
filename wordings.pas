unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, math, Generics.Collections;

function find_top_3(all_words: specialize TList<string>; keyword: string): specialize Tdictionary<string, integer>;
function find_max_fre(fre_of_vocab: TIntegerArray): integer;
function freq_of_keyword(keyword: string; all_words: specialize TList<string>): integer;
function begin_pronoun(paragraph: ansistring): integer;


implementation

function find_top_3(all_words: specialize TList<string>; keyword: string): specialize Tdictionary<string, integer>;
var
  word: string;
  all_words_freq, top_3_dict: specialize Tdictionary<string, integer>;
  freq_key1, freq_key2, freq_key3: string;
  item: string;
  i: integer;
begin
  all_words_freq := specialize TDictionary<string, integer>.create;
  top_3_dict := specialize TDictionary<string, integer>.create;

  for word in all_words do
  begin
    try
      all_words_freq[word] := 1;
    except on E: Exception do
      all_words_freq[word] := all_words_freq[word] + 1;
    end;
  end;

  freq_key1 := all_words[0];
  freq_key2 := all_words[0];
  freq_key3 := all_words[0];

  for item in all_words_freq.Keys do
  begin
    if all_words_freq[freq_key3] < all_words_freq[item] then
    begin
      if all_words_freq[freq_key2] < all_words_freq[item] then
      begin

        if all_words_freq[freq_key1] < all_words_freq[item] then
        begin
          freq_key1 := item;
          freq_key2 := freq_key1;
          freq_key3 := freq_key2;
        end
        else
        begin
          freq_key2 := item;
          freq_key3 := freq_key2;
        end;

      end
      else freq_key3 := item;
    end;
  end;

  top_3_dict[freq_key1] := all_words_freq[freq_key1];
  top_3_dict[freq_key2] := all_words_freq[freq_key2];
  top_3_dict[freq_key3] := all_words_freq[freq_key3];
  top_3_dict[keyword] := all_words_freq[keyword];
  find_top_3 := top_3_dict;
end;

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
