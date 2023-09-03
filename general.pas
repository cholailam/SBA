unit general;

interface
uses SysUtils, Classes, Generics.Collections, StrUtils;

function to_array(paragraph: ansistring; divide: string): TStringArray;
function get_file(file_name: string): TStringList;
function pure_sen(paragraph: TStringList): string;


implementation


{change string to array, divided by 'divide'}
function to_array(paragraph: ansistring; divide: string): TStringArray;
  begin
    to_array := paragraph.Split([divide])
  end;


{get the file and store the content by list}
function get_file(file_name: string): TStringList;
  var
    passage: TextFile; {variable for the file}
    temp_list: TStringList; {list to store content of file}
    temp: string; {variable for content of file}


  begin
    AssignFile(passage, file_name); {name the file as 'passage'}
    try
      reset(passage); {open file}
      temp_list := TStringList.Create; {initialize list}

      while not eof(passage) do {read every line in the file}
      begin
        readln(passage,temp);
        temp_list.append(temp); {add the content in each line as the last element}
      end;
      {finish storing all content into the list}

      CloseFile(passage);
      get_file := temp_list;

    except
      on E: EInOutError do
        get_file := nil;
    end;
  end;


function pure_sen(paragraph: TStringList): string;
var
  each_para: string;
  all_sen: string;
begin
  all_sen := '';
  for each_para in paragraph do
  begin
    appendstr(all_sen, each_para);
  end;
  pure_sen := all_sen;
end;



end.
