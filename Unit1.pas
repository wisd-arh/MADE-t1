unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, strUtils, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart, ComCtrls, Math;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    StatusBar1: TStatusBar;
    Button4: TButton;
    Edit3: TEdit;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit4: TEdit;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
    procedure ClearTable();
  public
    { Public declarations }
    function F(x: array of double; n: integer): double;
    procedure Normalization(k: integer);
    procedure NormalizationTR(k: integer);
    procedure LoadWeight();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const
  c1 = 10000;
  c2 = 12;//30;
  c3 = 2000;
var
  ry: array of double;
  trN : integer;
//  sw: array of array of double;
  sw: array of double;
  sx: array of array of double;
  GlobalStop: boolean;
  tmin, tmax: array of double;
  trx: array of array of double;

procedure TForm1.Button1Click(Sender: TObject);
var
  f: TextFile;
  i, j, k: integer;
  s: string;
//  sl: TStringList;
begin
  AssignFile(f, Edit1.Text);
  Reset(f);
//  ClearTable();

  s:='';
//  sl:=TStringList.Create();
  for i:=0 to c1-1 do begin
//    sl.Clear();
    Readln(f, s);
    s:=Trim(s);
//    s:=StringReplace(s, '.', ',', [rfReplaceAll]);
    for j:=0 to c2-2 do begin
      k:=Pos(',', s);
      StringGrid1.Cells[j, i]:=LeftStr(s, k-1);
//      sl.Add(LeftStr(s, k-1));
      s:=Copy(s, k+1, Length(s)-k);
    end;
    StringGrid1.Cells[c2-1, i]:=s;
//    sl.Add(s); //Last substring

//    StringGrid1.Rows[i].AddStrings(sl);
  end;
  CloseFile(f);
//  sl.Free();

  DecimalSeparator:='.';
  if FileExists('sw.txt')=true then begin
    LoadWeight();
  end else begin
    SetLength(sw, c2);
{
    for i:=0 to c2-1 do begin
      SetLength(sw[i], c2);
    end;
}
    for i:=0 to c2-1 do begin
{      for j:=0 to c2-1 do begin
        sw[i][j]:=Random;   //0...1
      end;
}
        sw[i]:=Random;   //0...1
    end;
  end;


  SetLength(sx, c1);
  for i:=0 to c1-1 do begin
    SetLength(sx[i], c2);
  end;

  for i:=0 to c1-1 do begin
    for j:=0 to c2-1 do begin
      sx[i][j]:=StrToFloat(StringGrid1.Cells[j, i]);
    end;
  end;

  Normalization(c1);

end;

procedure TForm1.ClearTable;
var
  i: integer;
begin
with StringGrid1 do
  for i:=FixedCols to ColCount-1 do
    Cols[i].Clear;
end;

function TForm1.F(x: array of double; n: integer): double;
var
  i, j: integer;
  y: double;
begin
  y:=0;
{  for i:=0 to n-1 do begin
    for j:=0 to c2-1 do begin
      y:=y+sw[i][j]*x[i];
    end;

  end;
}
  for i:=0 to n-1 do begin
    y:=y+sw[i]*x[i];
  end;


  y:=1.0/(1.0+exp(-1*y));

  result:=y;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f: TextFile;
  i, n: integer;
  sl: TStringList;
  s: string;
begin
  AssignFile(f, Edit2.Text);
  Reset(f);

  sl:=TStringList.Create();
  s:='';
  n:=0;
  while (not EOF(f)) do begin
    Readln(f, s);
    sl.Add(s);
    Inc(n);
  end;

  SetLength(ry, n);
  for i:=0 to n-1 do begin
    ry[i]:=StrToInt(sl.Strings[i]);
  end;

  trN:=n; //Global

  sl.Free();
  CloseFile(f);
  StatusBar1.SimpleText:='Load done.'
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, j, k, l: integer;
  y, error, terr: double;
  epoh: integer;
begin
//
  StatusBar1.SimpleText:='Start training.';

  epoh:=StrToInt(Edit3.Text);
  Series1.Clear();
  for l:=0 to epoh-1 do begin
    error:=0;
    for i:=0 to c1-1 do begin
      y:=F(sx[i], c2);
      terr:=ry[i]-y;
      for j:=0 to c2-1 do begin
{        for k:=0 to c2-1 do begin
          sw[j][k]:=sw[j][k]+sx[i][j]*terr*0.1;
        end;
}
        sw[j]:=sw[j]+sx[i][j]*terr*0.1;

      end;
      error:=error+terr*terr;
    end;
//    error:=error/c1;
    if (l < 10) then
       Series1.Add(error)
    else
      if ((l+1) mod 100) = 0 then begin
        Series1.Add(error);
        if (l > 300) then //TChar error
          Application.ProcessMessages();
        if (GlobalStop = true) then break; // Stop Training;
      end;
  end;

  StatusBar1.SimpleText:='Train done.'
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize();
  GlobalStop:=false;
end;

procedure TForm1.Normalization(k: integer);
var
  i, j: integer;
  t: double;

  f: TextFile;
begin
  AssignFile(f, 'max.txt');
  Rewrite(f);
  SetLength(tmin, c2);
  SetLength(tmax, c2);
  for i:=0 to c2-1 do begin
    tmin[i]:=1000000;
    tmax[i]:=-1000000;
  end;


  for j:=0 to c2-1 do begin
    for i:=0 to k-1 do begin
      if (sx[i][j] < tmin[j]) then tmin[j]:=sx[i][j];
      if (sx[i][j] > tmax[j]) then tmax[j]:=sx[i][j];

    end;
    Writeln(f, FloatToStr(tmin[j]));
    Writeln(f, FloatToStr(tmax[j]));
  end;

  for i:=0 to k-1 do begin
    for j:=0 to c2-1 do begin
      t:=sx[i][j];
      t:= t-tmin[j];
      t:=t/(tmax[j]-tmin[j]);
      sx[i][j]:=t;
    end;
  end;

  CloseFile(f);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Button1.Click();
  Button2.Click();
  Button3.Click();
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  GlobalStop:=true;
  StatusBar1.SimpleText:='stopped.'
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i, j: integer;
  f: TextFile;
begin
  AssignFile(f, 'sw.txt');
  Rewrite(f);
  for i:=0 to c2-1 do begin
{    for j:=0 to c2-1 do begin
      Writeln(f, FloatToStr(sw[i][j]));
    end;
}
    Writeln(f, FloatToStr(sw[i]));

  end;
  StatusBar1.SimpleText:='Saved sw[].';

  CloseFile(f);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  LoadWeight();
end;

procedure TForm1.LoadWeight();
var
  i, j: integer;
  f: TextFile;
  s: string;
begin
  AssignFile(f, 'sw.txt');
  Reset(f);
  s:='';
  SetLength(sw, c2);
{  for i:=0 to c2-1 do begin
    SetLength(sw[i], c2);
  end;
}
  for i:=0 to c2-1 do begin
{    for j:=0 to c2-1 do begin
      Readln(f, s);
      sw[i][j]:=StrToFloat(s);
    end;
}
      Readln(f, s);
      sw[i]:=StrToFloat(s);

  end;


  StatusBar1.SimpleText:='loaded sw[].';

  CloseFile(f);
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  f1, answer: TextFile;
  i, j, k: integer;
  s: string;
//  sl: TStringList;
  y: double;
begin

  ClearTable();
  AssignFile(f1, Edit4.Text);
  Reset(f1);
  s:='';
  for i:=0 to c3-1 do begin
    Readln(f1, s);
    s:=Trim(s);
    for j:=0 to c2-2 do begin
      k:=Pos(',', s);
      StringGrid1.Cells[j, i]:=LeftStr(s, k-1);
      s:=Copy(s, k+1, Length(s)-k);
    end;
    StringGrid1.Cells[c2-1, i]:=s;
  end;
  CloseFile(f1);

  SetLength(trx, c3);
  for i:=0 to c3-1 do begin
    SetLength(trx[i], c2);
  end;

  DecimalSeparator:='.';
  for i:=0 to c3-1 do begin
    for j:=0 to c2-1 do begin
      trx[i][j]:=StrToFloat(StringGrid1.Cells[j, i]);
    end;
  end;

  if (Abs(tmax[0]-tmin[0]) < 0.1) then
    ShowMessage('Possible min, max error initalized');

  NormalizationTR(c3);

  AssignFile(answer, 'answer.csv');
  Rewrite(answer);

  for i:=0 to c3-1 do begin
    y:=F(trx[i], c2);
    Write(answer, FloatToStrF(y, ffFixed, 15, 15)+'0'+#$0A);
  end;

  CloseFile(answer);
  StatusBar1.SimpleText:='Test done.';
end;


procedure TForm1.NormalizationTR(k: integer);
var
  i, j: integer;
  t: double;
  f: TextFile;
  s: string;
begin
  AssignFile(f, 'max.txt');
  Reset(f);
  for i:=0 to c2-1 do begin
    Readln(f, s);
    tmin[i]:=StrToFloat(s);
    Readln(f, s);
    tmax[i]:=StrToFloat(s);
  end;

  for i:=0 to k-1 do begin
    for j:=0 to c2-1 do begin
      t:=trx[i][j];
      t:=t-tmin[j];
      t:=t/(tmax[j]-tmin[j]);
      trx[i][j]:=t;
    end;
  end;
  closeFile(f);
end;


procedure TForm1.Button9Click(Sender: TObject);
var
  i, j: integer;
  sum: double;
  f: TextFile;
  sigma: double;
  sred_y, sigma_y: double;
  sigma_x: array of double;
  sred_x: array of double;
begin
  AssignFile(f, 'sigma.txt');
  Rewrite(f);
  SetLength(sigma_x, c2);
  SetLength(sred_x, c2);
  for j:=0 to c2-1 do begin
    sum:=0;
    sigma:=0;
    for i:=0 to c1-1 do begin
      sum:=sum+sx[i][j];
    end;
    sum:=sum/c1;
    sred_x[j]:=sum;

    for i:=0 to c1-1 do begin
      sigma:=sigma+Sqr(sx[i][j]-sum);
    end;
    sigma:=Sqrt(sigma/(c1-1));
    Writeln(f, FloatToStr(sigma));
    sigma_x[j]:=sigma;
  end;
{
  sum:=0;
  sigma:=0;
  for i:=0 to c1-1 do begin
    sum:=sum+ry[i];
  end;
  sum:=sum/c1;

  for i:=0 to c1-1 do begin
    sigma:=sigma+Sqr(ry[i]-sum);
  end;

  sigma:=Sqrt(sigma/(c1-1));
  Writeln(f, 'y =' + #9 +  FloatToStr(sigma));
}
  sred_y:=0.5;
  sigma_y:=0.5;

  for i:=0 to c2-1 do begin
    sum:=0;
    for j:=0 to c1-1 do begin
      sum:=sum+((sx[j][i]-sred_x[i])/sigma_x[i])*((ry[j]-sred_y)/sigma_y);
    end;
    sum:=sum/(c1-1);
    Writeln(f, 'r' + IntToStr(i) + #9 +  FloatToStr(sum));
  end;

  CloseFile(f);

  StatusBar1.SimpleText:='Calc sigma done.';
end;

procedure TForm1.Button10Click(Sender: TObject);
const
  m: array [0..11] of integer = (0, 2, 8, 10, 12, 14, 15, 16, 17, 19, 22, 29);

var
  i, j: integer;
  f: TextFile;
begin
  Button1.Click();
  Application.ProcessMessages();

  AssignFile(f, 'train_s.csv');
  Rewrite(f);


  for i:=0 to c1-1 do begin
    for j:=0 to 10 do begin
      Write(f, StringGrid1.Cells[m[j], i]+',');
    end;
    Write(f, StringGrid1.Cells[m[11], i]+#$0A);
  end;
  CloseFile(f);

  Button2.Click();
  Application.ProcessMessages();

  AssignFile(f, 'test_s.csv');
  Rewrite(f);

  for i:=0 to c3-1 do begin
    for j:=0 to 10 do begin
      Write(f, StringGrid1.Cells[m[j], i]+',');
    end;
    Write(f, StringGrid1.Cells[m[11], i]+#$0A);
  end;
  CloseFile(f);

  StatusBar1.SimpleText:='Simplifying done.';
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  if FileExists('sw.txt') then DeleteFile('sw.txt');
  
end;

end.
