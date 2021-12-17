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
    hrc: HGLRC;  { им€: тип  - ссылка на контекст воспроизведени€}
    DC: HDC;
    pos:array[0..3] of GLfloat;

  public
    { Public declarations }
  end;

  const light_ambient:array[0..3] of GLfloat = ( 0.0, 0.0, 0.0, 1.0 );
  light_diffuse:array[0..3] of GLfloat = ( 1.0, 1.0, 1.0, 1.0 );

var
  Form1: TForm1;
  i: Integer;
  j:Integer;
  choice: Integer;
  obj: (TETRAHEDRON, ICOSAHEDRON, DODECAHEDRON, CUBE, SPHERE, CONE, TORUS, TEAPOT) = CUBE;
  mode: (POINT, LINE, FILL) = FILL; // режим отображени€ объектов
  x_1: Extended;
  z_1: Extended;

  pos1:array[0..3] of GLfloat =(3,0,0,1);
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
DC:=GetDC(Handle); // получаем пр€мую ссылку на контекст устройства
SetDCPixelFormat(DC);  // задаем формат пиксел€
hrc:=wglCreateContext(DC);  // создаем контекст воспроизведени€
wglMakeCurrent(DC, hrc);
glClearColor(0.1,0.1,0.15,0);
glMatrixMode(GL_PROJECTION);
glEnable(GL_DEPTH_TEST);

glEnable(GL_LIGHTING); // включаем свет
glEnable(GL_LIGHT0);  // вкл источник ноль

// начальное положение источника света
pos[0]:= 0.0;
pos[1]:= 1.0;
pos[2]:= -4.0;
pos[3]:= 1.0;
// отображаем источник в позиции pos
glLightfv(GL_LIGHT0, GL_POSITION, @pos);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
wglMakeCurrent(0, 0);
wglDeleteContext(hrc);  // освобождение контекста воспроизведени€
ReleaseDC(Handle, DC);
DeleteDC(DC);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера кадра

// –»—ќ¬јЌ»≈

glPushMatrix;
glTranslatef(-2,0,0);
glutSolidSphere(0.4, 50, 50);
glPopMatrix;

glPushMatrix;
glTranslatef(-1,0,0);
glutSolidSphere(0.6, 50, 50);
glPopMatrix;

glLightfv(GL_LIGHT0, GL_POSITION, @pos);  // выводим света источник
SwapBuffers(DC); // вывод содержимого буфера на экран
wglMakeCurrent(dc,hrc); // освободить контекст
//glTranslatef(-x1, -y1, 0);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_SPACE then InvalidateRect(handle,nil,false);
// плоскость ’ќZ => мен€ем только pos[0] - x, pos[3] - z
// пусть парабола задана уравнением: x = z^2 - 4.
// то есть мы идем по оси икс, а считаем кординату z^2
// начальна€ точка - (0.0, 1.0, -4.0, 1.0)
// четвертый параметр - v, уходит ли источник света в бесконечность (0 - да, 1 - нет)
// движение источника света по параболе в одну сторону
if key=VK_F1 then
  pos[0]:= pos[0] - 0.5;  // иксова€ координата
  pos[2]:= pos[0] * pos[0] - 4.0;  // зетова€ координата
  Refresh;
// движение источника света по параболе в одну сторону
if key=VK_F2 then
  pos[0]:= pos[0] + 0.5;  // иксова€ координата
  pos[2]:= pos[0] * pos[0] - 4.0;  // зетова€ координата
  Refresh;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
glViewPort(0,0,ClientWidth,ClientHeight); // область вывода
glMatrixMode(GL_PROJECTION);
glLoadIdentity; // все матрицы в исходное состо€ние
glFrustum(-1, 1, -1, 1, 3, 10); // видовые параметры - перспективна€ проекци€
glTranslatef(0.0, 0.0, -8.0); // начальный сдвиг системы координат
glRotatef(30,1,0,0);    // чтобы увидеть
glRotatef(70,0,1,0);    // трехмерность
glMatrixMode(GL_MODELVIEW);
end;

end.
