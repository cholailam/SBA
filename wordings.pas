unit readability;

interface

uses
  Classes, SysUtils, general, strUtils;

var
  con_addition: array of string = ('also', 'besides', 'furthermore', 'too', 'moreover', 'in addition', 'then', 'of equal importance', 'equally important', 'another', 'additionally', 'apart from this', 'as well as');
  con_result: array of string = ('as a result', 'hence', 'accordingly', 'as a consequence', 'consequently', 'thus', 'since', 'therefore', 'for this reason', 'because of this');
  con_contrast: array of string = ('in contrast', 'conversely', 'however', 'still', 'nevertheless', 'nonetheless', 'yet', 'on the other hand', 'on the contrary', 'in spite of', 'actually', 'in fact', 'despite', 'although', 'alternatively', 'even so', 'instead', 'contrary to', 'notwithstanding', 'on the other hand', 'rather', 'whereas');
  con_summarize: array of string = ('in summary', 'to sum up', 'to repeat', 'briefly', 'in short', 'finally', 'on the whole', 'therefore', 'as I have said', 'in conclusion', 'as you can see');

function count_substring(sub_str, whole_str: string): integer;
function num_connectives(sentences: ansistring; cata: string): integer;
function give_connectives(cata: string): string;

implementation

function count_substring(sub_str, whole_str: string): integer;
var
  start: integer;
  point: integer;
  num_sub: integer;
begin
  num_sub := 0;
  start := 1;
  point := PosEx(sub_str, whole_str, start);
  while (point > 0) do
  begin
    start := point + 1;
    num_sub := num_sub + 1;
    point := PosEx(sub_str, LowerCase(whole_str), start);
  end;
  count_substring := num_sub;
end;



function num_connectives(sentences: ansistring; cata: string): integer;
var
  line: TStringArray;
  words, connect: string;
  count, all_count: integer;

begin
  all_count := 0;
  count := 0;
  line := to_array(sentences,'.');
  for words in line do
  begin
    if (cata = 'addition') then
    begin
      for connect in con_addition do
      begin
        count := count_substring(connect, words);
        all_count := all_count + count;
      end;
    end

    else if (cata = 'result') then
    begin
      for connect in con_result do
      begin
        count := count_substring(connect, words);
        all_count := count + all_count;
      end;
    end

    else if (cata = 'contrast') then
    begin
      for connect in con_contrast do
      begin
        count := count_substring(connect, words);
        all_count := count + all_count;
      end;
    end

    else if (cata = 'summarize') then
    begin
      for connect in con_summarize do
      begin
        count := count_substring(connect, words);
        all_count := count + all_count;
      end;
    end;

  end;
  num_connectives := all_count;
end;


function give_connectives(cata: string): string;
var
  rand_con: string;
begin
  Randomize;
  if (cata = 'addition') then
    rand_con := con_addition[random(length(con_addition))]

  else if (cata = 'result') then
    rand_con := con_result[random(length(con_result))]

  else if (cata = 'contrast') then
    rand_con := con_contrast[random(length(con_contrast))]

  else if (cata = 'summarize') then
    rand_con := con_summarize[random(length(con_summarize))];
  give_connectives := rand_con;
end;

end.

