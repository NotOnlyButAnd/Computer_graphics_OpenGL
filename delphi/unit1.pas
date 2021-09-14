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
    hrc: HGLRC;  { имя: тип }
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
  SetDCPixelFormat(Canvas.Handle);  // задаем формат пикселя
  hrc:=wglCreateContext(Canvas.Handle);  // создаем контекст воспроизведения
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglDeleteContext(hrc);  // освобождение контекста воспроизведения
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  wglMakeCurrent(Canvas.Handle,hrc);  // установить контекст
  glViewPort(0,0,ClientWidth,ClientHeight); // область вывода
  glClearColor(0.5,0.5,0.5,0);  // цвет фона
  glClear(GL_COLOR_BUFFER_BIT); // очистка буфера кадра
  glPointSize(10);

  //////// рисуем точки ///////
  glBegin(GL_POINTS); // открываем командную скобку

    glColor3f(0,0,0);
    glVertex2f(-0.1,-0.1);
    glVertex2f(0,0);
    glVertex2f(0.1,0.1);
    glVertex2f(0.1,-0.1);
    glVertex2f(0.1,0);
    glVertex2f(0,0.1);
  glEnd;  // закрываем командную скобку
SwapBuffers(Canvas.Handle); // вывод содержимого буфера на экран
end;



end.



