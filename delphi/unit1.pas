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
  glClearColor(0.5,0.5,0.5,0);  // öâåò ôîíà
  glClear(GL_COLOR_BUFFER_BIT); // î÷èñòêà áóôåðà êàäðà
  glPointSize(10);

  //////// ðèñóåì òî÷êè ///////
  glBegin(GL_POINTS); // îòêðûâàåì êîìàíäíóþ ñêîáêó

    glColor3f(0,0,0);
    glVertex2f(-0.1,-0.1);
    glVertex2f(0,0);
    glVertex2f(0.1,0.1);
    glVertex2f(0.1,-0.1);
    glVertex2f(0.1,0);
    glVertex2f(0,0.1);
  glEnd;  // çàêðûâàåì êîìàíäíóþ ñêîáêó
SwapBuffers(Canvas.Handle); // âûâîä ñîäåðæèìîãî áóôåðà íà ýêðàí
end;



end.



