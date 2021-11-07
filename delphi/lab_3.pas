unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL;

type
    TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    hrc: HGLRC;  { èìÿ: òèï  - ññûëêà íà êîíòåêñò âîñïðîèçâåäåíèÿ}
    x: Extended;   // äëÿ glTranslateF
    y: Extended;   // äëÿ glTranslateF
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i: Integer;
  choice: Integer;

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

procedure TForm1.FormCreate(Sender: TObject);
begin
SetDCPixelFormat(Canvas.Handle);  // çàäàåì ôîðìàò ïèêñåëÿ
hrc:=wglCreateContext(Canvas.Handle);  // ñîçäàåì êîíòåêñò âîñïðîèçâåäåíèÿ
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
wglDeleteContext(hrc);  // îñâîáîæäåíèå êîíòåêñòà âîñïðîèçâåäåíèÿ
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
wglMakeCurrent(Canvas.Handle,hrc);  // óñòàíîâèòü êîíòåêñò
glViewPort(0,0,ClientWidth,ClientHeight); // îáëàñòü âûâîäà
glClearColor(0,0,0,0);  // öâåò ôîíà
glClear(GL_COLOR_BUFFER_BIT); // î÷èñòêà áóôåðà êàäðà
glPointSize(10);

// ÐÈÑÎÂÀÍÈÅ
glTranslatef(x, 0, 0);
glTranslatef(0, y, 0);

//////// ðèñóåì òî÷êè ///////
glBegin(GL_QUADS);
  Randomize;
  glColor3f(1,1,1);
  glvertex2f(0.5, 0.5);
  glvertex2f(0.5, -0.5);
  glvertex2f(-0.5, -0.5);
  glvertex2f(-0.5, 0.5);
glEnd;

glTranslatef(-x, 0, 0);
glTranslatef(0, -y, 0);


SwapBuffers(Canvas.Handle); // âûâîä ñîäåðæèìîãî áóôåðà íà ýêðàí
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_SPACE then Refresh;
if key=VK_LEFT then
  begin
    x:= x - 0.1;
    Refresh;
  end;
if key=VK_RIGHT then
  begin
    x:= x + 0.1;
    Refresh;
  end;
if key=VK_UP then
  begin
    y:= y + 0.1;
    Refresh;
  end;
if key=VK_DOWN then
  begin
    y:= y - 0.1;
    Refresh;
  end;
if key=VK_F1 then
  glRotatef(-45, 0.0, 0.0, 1.0);
  Refresh;
end;

end.
