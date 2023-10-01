unit wordings;

interface

uses
  Classes, SysUtils, general, StrUtils, Generics.Collections;

type
  top_3 = array[0..3, 0..1] of string;
  oneD = array of string;
  twoD = array of oneD;

function find_top_3(each_sen: TStringArray; keyword: string): top_3;
function read_syno_file(): twoD;
function check_str(target_str: string; line_of_syno: Array of string): boolean;
function add_syno(keyword, syno: string; grp_array: twoD): twoD;
function begin_pronoun(paragraph: ansistring): integer;

const
  pronouns: array[0..13] of string = ('he', 'she', 'it', 'i', 'we', 'you', 'they', 'my', 'a', 'me', 'his', 'her', 'its', 'him');
  auxiliary: array[0..15] of string = ('the', 'is', 'am', 'are', 'was', 'were', 'have', 'has', 'will', 'isn''t', 'aren''t', 'wasn''t', 'weren''t', 'haven''t', 'hasn''t', 'won''t');
  diff_be: array[0..3] of string = ('be', 'been', 'being', 'not');
  prep: array[0..10] of string = ('on', 'in', 'at', 'for', 'to', 'by', 'over', 'from', 'of', 'as', 'with');

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
      if (all_words_freq[freq_key] < all_words_freq[item]) and not(item in pronouns) and not(item in auxiliary) and not(item in diff_be) and not(item in prep) then
        freq_key := item;
    end;

    top_3_freq[times, 0] := freq_key;
    top_3_freq[times, 1] := IntToStr(all_words_freq[freq_key]);

    all_words_freq[freq_key] := 0;
    times += 1;
  end;
    find_top_3 := top_3_freq;
end;


function read_syno_file(): twoD;
var
  syno_file: textfile;
  syno_grps: twoD;
  syno_array: oneD;
  temp: string;
begin
  assign(syno_file, 'synonym.txt');
  reset(syno_file);
  setlength(syno_grps, 0, 0);
  while not EOF(syno_file) do
  begin
    readln(syno_file, temp);
    if temp <> '' then
    begin
      syno_array := trim(temp).Split(' ');
      insert(syno_array, syno_grps, -1);
    end;
  end;

  close(syno_file);
  read_syno_file := syno_grps;

end;


function check_str(target_str: string; line_of_syno: Array of string): boolean;
var
  relate: string;
begin
  for relate in line_of_syno do
  begin
    if target_str = relate then
      exit(true);
  end;
  check_str := false;
end;


function add_syno(keyword, syno: string; grp_array: twoD): twoD;
var
  i: integer;
  each_grp, temp: oneD;
  inside_grp: boolean;
begin
  i := -1;
  temp := oneD.create(keyword, syno);
  inside_grp := false;
  for each_grp in grp_array do
  begin
    i += 1;
    if check_str(keyword, each_grp) and not(check_str(syno, each_grp)) then
    begin
      insert([syno], grp_array[i], -1);
      inside_grp := true;
      break;
    end

    else if check_str(syno, each_grp) and not(check_str(keyword, each_grp)) then
    begin
      insert([keyword], grp_array[i], -1);
      inside_grp := true;
      break;
    end

    else if check_str(syno, each_grp) and check_str(keyword, each_grp) then
    begin
      inside_grp := true;
      break;
    end;
  end;

  if not(inside_grp) then
    insert(temp, grp_array, -1);
  add_syno := grp_array;

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
    if (lowercase(words[0]) in pronouns)then
    begin
      count := count + 1;
    end;
  end;
  begin_pronoun := count;
end;


end.
