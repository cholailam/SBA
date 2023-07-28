unit split_string;

interface
uses SysUtils, Classes;

function to_array(sentence: string): TStringArray;
function get_file(file_name: string): TStringList;

implementation



function to_array(sentence: string): TStringArray;
  begin
    to_array := sentence.Split('.');
    readln;
  end;



function get_file(file_name: string): TStringList;
  var
    passage: TextFile;
    temp_list: TStringList;
    temp: string;
  begin
    AssignFile(passage, file_name);
    try
      reset(passage);
      temp_list := TStringList.Create;

      while not eof(passage) do
      begin
        readln(passage,temp);
        temp_list.append(temp);
      end;

      CloseFile(passage);
      get_file := temp_list;
    finally
    end;
  end;

end.   
