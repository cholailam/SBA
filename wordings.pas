unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, math, Generics.Collections;

function find_top_3(each_sen: TStringArray; keyword: string): specialize Tdictionary<string, integer>;
function begin_pronoun(paragraph: ansistring): integer;

const
  pronouns: array[0..6] of string = ('he', 'she', 'it', 'I', 'we', 'you', 'they');


implementation

function find_top_3(each_sen: TStringArray; keyword: string): specialize Tdictionary<string, integer>;
var
  sentences: string;
  word: string;
  all_words: TStringArray;
  all_words_freq, top_3_dict: specialize Tdictionary<string, integer>;
  freq_key1, freq_key2, freq_key3: string;
  item: string;
  i: integer;
  j: TStringArray;
begin
  all_words_freq := specialize TDictionary<string, integer>.create;
  top_3_dict := specialize TDictionary<string, integer>.create;

  for sentences in each_sen do
  begin
    all_words := to_array(sentences, ' ');

  for word in all_words do
  begin
    try
      all_words_freq.add(lowercase(trim(word)), 1);
    except on E: Exception do
      all_words_freq[lowercase(trim(word))] := all_words_freq[lowercase(trim(word))] + 1;
    end;
  end;
  end;

j := all_words_freq.Keys.toarray;
    freq_key1 := j[1];
    freq_key2 := j[1];
    freq_key3 := j[1];

  for item in all_words_freq.Keys do
  begin
    if (all_words_freq[freq_key3] < all_words_freq[item]) and (item <> '')then
    begin
      if all_words_freq[freq_key2] < all_words_freq[item] then
      begin

        if all_words_freq[freq_key1] < all_words_freq[item] then
        begin
          freq_key3 := freq_key2;
          freq_key2 := freq_key1;
          freq_key1 := item;
        end
        else
        begin
          freq_key3 := freq_key2;
          freq_key2 := item;
        end;

      end
      else freq_key3 := item;
    end;
  end;

  top_3_dict.add(freq_key1,all_words_freq[freq_key1]);
  top_3_dict.add(freq_key2, all_words_freq[freq_key2]);
  top_3_dict.add(freq_key3, all_words_freq[freq_key3]);
  top_3_dict[keyword] := all_words_freq[keyword];
  find_top_3 := top_3_dict;
end;



function begin_pronoun(paragraph: ansistring): integer;
{const
  pronouns: array[0..6] of String = ('He', 'She', 'It', 'I', 'We', 'You', 'They');}
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
