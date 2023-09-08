unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, math, Generics.Collections;

function find_top_3(each_sen: TStringArray; keyword: string): specialize Tdictionary<string, integer>;
function begin_pronoun(paragraph: ansistring): integer;

const
  pronouns: array[0..6] of string = ('he', 'she', 'it', 'I', 'we', 'you', 'they');
  auxiliary: array[0..15] of string = ('the', 'is', 'am', 'are', 'was', 'were', 'have', 'has', 'will', 'isn''t', 'aren''t', 'wasn''t', 'weren''t', 'haven''t', 'hasn''t', 'won''t');
  diff_be: array[0..3] of string = ('be', 'been', 'being', 'not');

implementation

function find_top_3(each_sen: TStringArray; keyword: string): specialize Tdictionary<string, integer>;
var
  sentences: string;
  word: string;
  all_words: TStringArray;
  all_words_freq, top_3_dict: specialize Tdictionary<string, integer>;
  freq_key: string;
  item: string;
  times: integer;
  j: TStringArray;
begin
  all_words_freq := specialize TDictionary<string, integer>.create;
  top_3_dict := specialize TDictionary<string, integer>.create;

  for sentences in each_sen do
  begin
    all_words := to_array(sentences, ' ');

    for word in all_words do
    begin
      if (word <> '') and (word <> ' ') then
      begin
        try
          all_words_freq.add(lowercase(trim(word)), 1)
        except on E: Exception do
          all_words_freq[lowercase(trim(word))] := all_words_freq[lowercase(trim(word))] + 1;
        end;
      end;
    end;
  end;

  if all_words_freq.ContainsKey(keyword) then
    top_3_dict.add(keyword, all_words_freq[keyword])
  else
    top_3_dict.add(keyword, 0);

  j := all_words_freq.Keys.toarray;
    freq_key := j[1];

  times := 1;
  while (times <= 3) do
  begin
    for item in all_words_freq.Keys do
    begin
      if (all_words_freq[freq_key] < all_words_freq[item]) and not(item in pronouns) and not(item in auxiliary) and not(item in diff_be) then
        freq_key := item;
    end;

    try
      top_3_dict.add(freq_key, all_words_freq[freq_key]);
    except on E: exception do
      top_3_dict.add(freq_key+' ', all_words_freq[freq_key]);
    end;
    all_words_freq[freq_key] := 0;
    times += 1;
  end;

    find_top_3 := top_3_dict;
end;



function begin_pronoun(paragraph: ansistring): integer;
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
