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
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    hrc: HGLRC;  { имя: тип  - ссылка на контекст воспроизведения}
    DC: HDC;
    x: Extended;   // для glTranslateF
    y: Extended;   // для glTranslateF
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
DC:=GetDC(Handle); // получаем прямую ссылку на контекст устройства
SetDCPixelFormat(DC);  // задаем формат пикселя
hrc:=wglCreateContext(DC);  // создаем контекст воспроизведения
wglMakeCurrent(DC, hrc);
glEnable(GL_DEPTH_TEST);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
wglMakeCurrent(0, 0);
wglDeleteContext(hrc);  // освобождение контекста воспроизведения
ReleaseDC(Handle, DC);
DeleteDC(DC);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера кадра
//glClearColor(0,0,0);

// РИСОВАНИЕ
glTranslatef(x, 0, 0);
glTranslatef(0, y, 0);

//////// рисуем точки ///////
glBegin(GL_TRIANGLES);
    // верхняя часть елки
    glColor3f(0.5, 1.0, 0.5);
    glVertex3f(-0.238, 1.0, -0.4);
    glVertex3f(0.462, 1.0, 0.0);
    glVertex3f(-0.238, 1.0, 0.4);

    glColor3f(0.5, 1, 1);
    glVertex3f(-0.238, 1.0, -0.4);
    glVertex3f(-0.238, 1.0, 0.4);
    glVertex3f(0.0, 1.7, 0.0);

    glColor3f(0.5, 0.5, 1);
    glVertex3f(0.462, 1.0, 0.0);
    glVertex3f(-0.238, 1.0, -0.4);
    glVertex3f(0.0, 1.7, 0.0);

    glColor3f(0.5, 0.5, 0.5);
    glVertex3f(0.462, 1.0, 0.0);
    glVertex3f(-0.238, 1.0, 0.4);
    glVertex3f(0.0, 1.7, 0.0);

    // средняя часть елки
    glColor3f(0.5, 1, 1);
    glVertex3f(-0.349, 0.0, -0.6);
    glVertex3f(0.693, 0.0, 0.0);
    glVertex3f(-0.349, 0.0, 0.6);

    glColor3f(0.5, 1.0, 0.5);
    glVertex3f(-0.349, 0.0, -0.6);
    glVertex3f(-0.349, 0.0, 0.6);
    glVertex3f(0.0, 1.0, 0.0);

    glColor3f(0.5, 0.5, 0.5);
    glVertex3f(0.693, 0.0, 0.0);
    glVertex3f(-0.349, 0.0, -0.6);
    glVertex3f(0.0, 1.0, 0.0);

    glColor3f(0.5, 0.5, 1);
    glVertex3f(0.693, 0.0, 0.0);
    glVertex3f(-0.349, 0.0, 0.6);
    glVertex3f(0.0, 1.0, 0.0);

    // нижняя часть елки
    glColor3f(0.5, 0.5, 1);
    glVertex3f(1.039, -1.4, 0.0);
    glVertex3f(-0.519, -1.4, -0.9);
    glVertex3f(-0.519, -1.4, 0.9);

    glColor3f(0.5, 0.5, 0.5);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(-0.519, -1.4, -0.9);
    glVertex3f(-0.519, -1.4, 0.9);

    glColor3f(0.5, 1.0, 0.5);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(-0.519, -1.4, -0.9);
    glVertex3f(1.039, -1.4, 0.0);

    glColor3f(0.5, 1, 1);
    glVertex3f(0.0, 0.0, 0.0);
    glVertex3f(-0.519, -1.4, 0.9);
    glVertex3f(1.039, -1.4, 0.0);
glEnd();

glBegin(GL_QUADS);
  // ствол внизу
  glColor3f(0.7, 0.9, 1);
  glVertex3f(0.15, -1.4, 0.15);
  glVertex3f(-0.15, -1.4, 0.15);
  glVertex3f(-0.15, -1.9, 0.15);
  glVertex3f(0.15, -1.9, 0.15);

  glColor3f(0.7, 1, 0.3);
  glVertex3f(-0.15, -1.4, 0.15);
  glVertex3f(-0.15, -1.4, -0.15);
  glVertex3f(-0.15, -1.9, -0.15);
  glVertex3f(-0.15, -1.9, 0.15);

  glColor3f(1, 0.2, 0.4);
  glVertex3f(-0.15, -1.4, -0.15);
  glVertex3f(0.15, -1.4, -0.15);
  glVertex3f(0.15, -1.9, -0.15);
  glVertex3f(-0.15, -1.9, -0.15);

  glColor3f(0.123, 0.2, 0.8);
  glVertex3f(0.15, -1.4, -0.15);
  glVertex3f(0.15, -1.4, 0.15);
  glVertex3f(0.15, -1.9, 0.15);
  glVertex3f(0.15, -1.9, -0.15);

  glColor3f(0.431, 0.123, 531);
  glVertex3f(0.15, -1.9, -0.15);
  glVertex3f(0.15, -1.9, 0.15);
  glVertex3f(-0.15, -1.9, 0.15);
  glVertex3f(-0.15, -1.9, -0.15);

glEnd();

glTranslatef(-x, 0, 0);
glTranslatef(0, -y, 0);


SwapBuffers(Canvas.Handle); // вывод содержимого буфера на экран
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
  glRotatef(-15, 0.0, 1.0, 0.0);
  Refresh;
if key=VK_F2 then
  glRotatef(15, 0.0, 1.0, 0.0);
  Refresh;
if key=VK_F3 then
  glRotatef(-15, 1.0, 0.0, 0.0);
  Refresh;
if key=VK_F4 then
  glRotatef(15, 1.0, 0.0, 0.0);
  Refresh;
if key=VK_F5 then
  glRotatef(-15, 0.0, 0.0, 1.0);
  Refresh;
if key=VK_F6 then
  glRotatef(15, 0.0, 0.0, 1.0);
  Refresh;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
glViewPort(0,0,ClientWidth,ClientHeight); // область вывода
glLoadIdentity; // все матрицы в исходное состояние
glFrustum(-1, 1, -1, 1, 3, 10); // видовые параметры - перспективная проекция
glTranslatef(0.0, 0.0, -8.0); // начальный сдвиг системы координат
glRotatef(30,1,0,0);    // чтобы увидеть
glRotatef(70,0,1,0);    // трехмерность
end;

end.
