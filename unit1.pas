unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs,
  StdCtrls, LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
const
  BUF_SIZE = 2048;
var
  process: TProcess;
  Buffer: array[1..BUF_SIZE] of char;

begin
  Memo1.Lines.Clear;

  process := TProcess.Create(nil);
  process.Executable := 'ping';
  process.Parameters.Add('1.1.1.1');
  process.Options := process.Options + [poUsePipes, poNoConsole];
  process.Execute;

  repeat
    process.Output.Read(Buffer, BUF_SIZE);
    Memo1.Lines.Add(ConsoleToUTF8(Buffer));
  until not process.Running;

  process.Free;
end;

end.
