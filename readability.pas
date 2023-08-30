unit readability;

interface

uses
  Classes, SysUtils, general, strUtils;

var
  con_addition: array of string = ('and', 'also', 'besides', 'further', 'furthermore', 'too', 'moreover', 'in addition', 'then', 'of equal importance', 'equally important', 'another', 'additionally', 'apart from this', 'as well as');
  con_result: array of string = ('as a result', 'hence', 'so', 'accordingly', 'as a consequence', 'consequently', 'thus', 'since', 'therefore', 'for this reason', 'because of this');
  con_contrast: array of string = ('but', 'in contrast', 'conversely', 'however', 'still', 'nevertheless', 'nonetheless', 'yet', 'and yet', 'on the other hand', 'on the contrary', 'or', 'in spite of', 'actually', 'in fact', 'despite', 'although', 'alternatively', 'even so', 'instead', 'contrary to', 'notwithstanding', 'on the other hand', 'rather', 'whereas');
  con_summarize: array of string = ('in summary', 'to sum up', 'to repeat', 'briefly', 'in short', 'finally', 'on the whole', 'therefore', 'as I have said', 'in conclusion', 'as you can see');

function num_connectives(sentences: ansistring; cata: string): integer;
function count_substring(sub_str, whole_str: string): integer;

implementation

function count_substring(sub_str, whole_str: string): integer;
var
  start: integer;
  point: integer;
  num_sub: integer;
begin
  start := 1;
  point := PosEx(sub_str, whole_str, start);
  while (point > 0) do
  begin
    start := point + 1;
    num_sub := num_sub + 1;
    point := PosEx(sub_str, whole_str, start);
  end;
  count_substring := num_sub;
end;

function num_connectives(sentences: ansistring; cata: string): integer;
var
  line: TStringArray;
  words: string;
  connect: string;
  count: integer;

begin
  count := 0;
  line := to_array(sentences,'.');
  for words in line do
  begin
    for connect in con_addition do
    begin
      count := count_substring(connect, words);
    end;

  end;
  num_connectives := count;
end;

end.

{function give_connectives():}
