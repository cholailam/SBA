unit general;

interface
uses SysUtils, Classes;

function to_array(paragraph, divide: string): TStringArray;
function get_file(file_name: string): TStringList;

implementation


{change string to array, divided by 'divide'}
function to_array(paragraph, divide: string): TStringArray;
  begin
    to_array := paragraph.Split(divide);
    readln;
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
    finally
    end;
  end;


end.
