unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
    hrc: HGLRC;  { èìÿ: òèï }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure SetDCPixelFormat (hdc: HDC);
var pfd: TPixelFormatDescriptor;
    nPixelFormat: Integer;
begin
    FillChar(pfd, SizeOf(pfd),0);
    pfd.dwFlags:=PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
    nPixelFormat:=ChoosePixelFormat (hdc,@pfd);
    SetPixelFormat(hdc,nPixelFormat,@pfd);
end;
end.
