unit split_string;

interface
uses SysUtils;
function change(sentence: string): TStringArray;

implementation

function change(sentence: string): TStringArray;
  begin
    change := sentence.Split(' ');
    readln;
  end;
end.
