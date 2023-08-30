program english_writing_analyser;

uses
  general, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes,  {to use TStringList}
  StrUtils, {to use PosEx}
  wordings, readability,
  Generics.Collections;

var
  link, analyser: string;
  paragraph: TStringList;
  each_para: ansistring;
  all_sen: string;
  connectives: array of string = ('addition', 'result', 'contrast', 'summarize');
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

  repeat
    writeln();
    writeln('Enter 1 for wordings analyser');
    writeln('Enter 2 for readability analyser');
    writeln('Press enter to exit');
    readln(analyser);
    writeln();
    writeln('=================================');

    all_sen := pure_sen(paragraph); {convert list of paragraphs to string of sentences}
    if analyser = '1' then
      begin
        writeln('Frequency of');
        writeln(frequency(all_sen)['is']);
        writeln();

        writeln('Number of sentences start with pronoun');
        for each_para in paragraph do
          begin
            writeln('paragraph ', paragraph.IndexOf(each_para)+1, ': ', begin_pronoun(each_para));
          end;
      end

    else if analyser = '2' then
      begin
        for cata in connectives do
        begin
          write('Number of ', cata, ' connectives: ');
          writeln(num_connectives(all_sen, cata));
        end;
      end;

    writeln('=================================');
  until analyser = '';

  writeln('Goodbye');

  readln();
end.
