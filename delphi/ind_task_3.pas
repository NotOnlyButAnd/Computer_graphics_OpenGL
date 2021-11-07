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
  j:Integer;
  choice: Integer;
  obj: (TETRAHEDRON, ICOSAHEDRON, DODECAHEDRON, CUBE, SPHERE, CONE, TORUS, TEAPOT) = CUBE;
  mode: (POINT, LINE, FILL) = FILL; // режим отображения объектов
  x_1: Extended;
  z_1: Extended;
implementation

uses dglut;

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
glClearColor(1,1,1,1);
glEnable(GL_DEPTH_TEST);
glEnable(GL_LIGHTING); // включаем свет
glEnable(GL_LIGHT0);  // вкл источник ноль
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
//glClearColor(1,1,1,1);

// РИСОВАНИЕ
glTranslatef(x, 0, 0);
glTranslatef(0, y, 0);
glColor3f(0,0,0);

case mode of
POINT: glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);
LINE: glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
FILL: glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
end;

{case obj of
TETRAHEDRON: glutSolidTetrahedron;
DODECAHEDRON: glutSolidDodecahedron;
ICOSAHEDRON: glutSolidIcosahedron;
CUBE: glutSolidCube(2.0);
TEAPOT: glutSolidTeaPot(1.5);
SPHERE: glutSolidSphere(1.0, 50, 50);
TORUS: glutSolidTorus(0.5, 1.0, 50, 50);
CONE: glutSolidCone(0.5, 1.0, 50, 50);
end;}

x_1:= -1.2;
i:= 0;
while x_1 < -0.2 do
begin
  glPushMatrix;
  glTranslatef(1,x_1,-1);
  glutSolidCube(0.2);
  glPopMatrix;

  glPushMatrix;
  glTranslatef(-1,x_1,-1);
  glutSolidCube(0.2);
  glPopMatrix;

  glPushMatrix;
  glTranslatef(1,x_1,1);
  glutSolidCube(0.2);
  glPopMatrix;

  glPushMatrix;
  glTranslatef(-1,x_1,1);
  glutSolidCube(0.2);
  glPopMatrix;

  x_1:= x_1 + 0.2;
end;


// столешница
x_1:= -1.2;
z_1:= 1.2;
While z_1 <> -1.4 do
begin
  While x_1 <> 1.4 do
  begin
    glPushMatrix;
    glTranslatef(x_1,0,z_1);
    glutSolidCube(0.2);
    glPopMatrix;
    x_1:= x_1 + 0.2;
  end;
  x_1:= -1.2;
  z_1:= z_1 - 0.2;
end;


glTranslatef(-x, 0, 0);
glTranslatef(0, -y, 0);


SwapBuffers(DC); // вывод содержимого буфера на экран

//glTranslatef(-x1, -y1, 0);
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
if key=49 then
  begin
    inc(obj);
    if obj>High(obj) then obj:=Low(obj);
    Refresh;
  end;
if key=50 then
  begin
    inc(mode);
    if mode>High(mode) then mode:=Low(mode);
    Refresh;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
glViewPort(0,0,ClientWidth,ClientHeight); // область вывода
glMatrixMode(GL_PROJECTION);
glLoadIdentity; // все матрицы в исходное состояние
glFrustum(-1, 1, -1, 1, 3, 10); // видовые параметры - перспективная проекция
glTranslatef(0.0, 0.0, -8.0); // начальный сдвиг системы координат
glRotatef(30,1,0,0);    // чтобы увидеть
glRotatef(70,0,1,0);    // трехмерность
glMatrixMode(GL_MODELVIEW);
end;

end.
