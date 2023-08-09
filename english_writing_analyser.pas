program english_writing_analyser;

uses
  general, {a unit with function: to_array, get_file}
  SysUtils, {to use TStringArray}
  Classes,  {to use TStringList}
  wordings;

var
  link, analyser: string;
  paragraph: TStringList;
  each_para: ansistring;

begin
  repeat
    write('Input the name of text file: ');
    readln(link);
    paragraph := get_file(link);
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

    if analyser = '1' then
      begin
        writeln('Number of sentences start with pronoun');
        for each_para in paragraph do
          begin
            writeln('paragraph ', paragraph.IndexOf(each_para)+1, ': ', begin_pronoun(each_para));
          end;
      end;
    writeln('=================================');
    until analyser = '';
    writeln('Goodbye');

  readln();
end.
