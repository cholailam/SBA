program english_writing_analyser;

uses
  general, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes,  {to use TStringList}
  StrUtils, {to use PosEx}
  wordings, readability,
  math, Generics.Collections;

const
  connectives: array[0..3] of string = ('addition', 'result', 'contrast', 'summarize');

var
  {use in file abstraction and choosing analyser}
  link, analyser: string;
  paragraph: TStringList;

  {file preprocessing}
  all_sen: string;
  each_sen: TStringArray;

  {wordings analyser}
  top_3_freq: array[0..3, 0..1] of string;
  number: integer;
  keyword: string;
  each_para: ansistring;

  {readability analyser}
  num_con: integer;
  cata: string;


begin
  repeat
    write('Input the name of text file (eg. if name is text.txt, enter text): ');
    readln(link);
    paragraph := get_file(link+'.txt');
    if paragraph = nil then
      begin
        writeln('Cannot find file');
        writeln('Please input the name again');
        writeln();
      end;
  until paragraph <> nil;

  {Preprocessing text obtained in text file}
  all_sen := pure_sen(paragraph); {convert list of paragraphs to string of sentences}
  each_sen := to_array(all_sen, '.'); {Array of all sentences}

  {showing result}
  repeat
    writeln();
    writeln('Enter 1 for wordings analyser');
    writeln('Enter 2 for readability analyser');
    writeln('Press enter to exit');
    readln(analyser);
    writeln();
    writeln('=================================');

    if analyser = '1' then
      begin
        write('Enter a word to find the frequency of it: ');
        readln(keyword);

        top_3_freq := find_top_3(each_sen, lowercase(trim(keyword)));

        writeln();
        number := 0;
        while (number <= 3) do
        begin
          if (number = 0) then
          begin
            writeln('Frequency of the word = ', top_3_freq[number, 1]);
            writeln();
          end
          else
          begin
            writeln('No. ', number , ' frequency word is: ', trim(top_3_freq[number, 0]));
            writeln('With frequency ', top_3_freq[number, 1]);
            write('Any synonyms? (if no press enter): ');
            readln();
           end;
          number += 1;
        end;
        writeln();

        writeln('Number of sentences start with pronoun');
        for each_para in paragraph do
            writeln('paragraph ', paragraph.IndexOf(each_para)+1, ': ', begin_pronoun(each_para));
      end

    else if analyser = '2' then
      begin
        for cata in connectives do
        begin
          num_con := num_connectives(all_sen, cata);
          write('Number of ', cata, ' connectives: ');
          writeln(num_con);
          if (num_con > 0) then
          begin
            write('Recommand ', cata, ' connective: ');
            writeln(give_connectives(cata));
          end;
        writeln();
        end;

        writeln('---------------------------------');
        writeln('Number of passive voice used: ', passive(each_sen));
        writeln();
      end;

    writeln('=================================');
  until analyser = '';

  writeln('Goodbye');

  readln();
end.
