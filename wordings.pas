unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, Generics.Collections;

type top_3 = array[0..3, 0..1] of string;

function find_top_3(each_sen: TStringArray; keyword: string): top_3;
function begin_pronoun(paragraph: ansistring): integer;

const
  pronouns: array[0..6] of string = ('he', 'she', 'it', 'I', 'we', 'you', 'they');
  auxiliary: array[0..15] of string = ('the', 'is', 'am', 'are', 'was', 'were', 'have', 'has', 'will', 'isn''t', 'aren''t', 'wasn''t', 'weren''t', 'haven''t', 'hasn''t', 'won''t');
  diff_be: array[0..3] of string = ('be', 'been', 'being', 'not');

implementation


function find_top_3(each_sen: TStringArray; keyword: string): top_3;
var

  {frequency of all words}
  all_words: TStringArray;
  sentences, word: string;
  all_words_freq: specialize Tdictionary<string, integer>;

  {finding top 3 highest frequency words}
  top_3_freq: array[0..3, 0..1] of string;
  freq_key, item: string;
  times: integer;
  j: TStringArray;

begin
  all_words_freq := specialize TDictionary<string, integer>.create;

  {finding frequency of every words}
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

  {finding frequency of the keyword}
  if all_words_freq.ContainsKey(keyword) then
  begin
    top_3_freq[0, 0] := keyword;
    top_3_freq[0, 1] := IntToStr(all_words_freq[keyword]);
  end
  else
  begin
    top_3_freq[0, 0] := keyword;
    top_3_freq[0, 1] := '0';
  end;

  j := all_words_freq.Keys.toarray;
    freq_key := j[1];

  {finding top 3 frequency}
  times := 1;
  while (times <= 3) do
  begin
    for item in all_words_freq.Keys do
    begin
      if (all_words_freq[freq_key] < all_words_freq[item]) and not(item in pronouns) and not(item in auxiliary) and not(item in diff_be) then
        freq_key := item;
    end;

    try
    begin
      top_3_freq[times, 0] := freq_key;
      top_3_freq[times, 1] := IntToStr(all_words_freq[freq_key]);
    end;
    except on E: exception do
    begin
      top_3_freq[times, 0] := freq_key+' ';
      top_3_freq[times, 1] := IntToStr(all_words_freq[freq_key]);
    end;
    end;

    all_words_freq[freq_key] := 0;
    times += 1;
  end;
    find_top_3 := top_3_freq;
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
