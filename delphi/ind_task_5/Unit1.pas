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
    pos:array[0..3] of GLfloat;

  public
    { Public declarations }
  end;

  const no_shine:array[0..1] of GLfloat = ( 0.0, 0.0 );
  low_shine:array[0..1] of GLfloat = ( 5.0, 0.0 );
  med_shine:array[0..1] of GLfloat = ( 20.0, 0.0 );
  high_shine:array[0..1] of GLfloat = ( 128.0, 0.0 ); // вотрая координата кажись ничего не меняет
  no_mat:array[0..3] of GLfloat = ( 0, 0, 0, 1 );
  mat_amb:array[0..3] of GLfloat = ( 0.9, 0.2, 0.2, 1 );
  mat_dif:array[0..3] of GLfloat = ( 0.2, 0.1, 0.8, 1 );
  mat_spec:array[0..3] of GLfloat = ( 1, 1, 1, 1 );
  mat_emis:array[0..3] of GLfloat = ( 1, 1, 0, 1 );


var
  Form1: TForm1;
  i: Integer;
  j:Integer;
  choice: Integer;
  obj: (TETRAHEDRON, ICOSAHEDRON, DODECAHEDRON, CUBE, SPHERE, CONE, TORUS, TEAPOT) = CUBE;
  mode: (POINT, LINE, FILL) = FILL; // режим отображения объектов
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
DC:=GetDC(Handle); // получаем прямую ссылку на контекст устройства
SetDCPixelFormat(DC);  // задаем формат пикселя
hrc:=wglCreateContext(DC);  // создаем контекст воспроизведения
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
wglDeleteContext(hrc);  // освобождение контекста воспроизведения
ReleaseDC(Handle, DC);
DeleteDC(DC);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера кадра

// РИСОВАНИЕ
// no_mat  mat_amb   mat_dif   mat_spec  mat_emis
glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @no_shine);
glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, @no_mat);
glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @mat_dif); // для болшей красоты и наглядности тоже включим
glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @mat_spec); // отражения - нужны нам
glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @no_mat);
// рисуем гусеничку
glPushMatrix;
glTranslatef(0,0,-1);
glutSolidSphere(0.6, 50, 50);
glPopMatrix;

glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @low_shine);
// рисуем гусеничку
glPushMatrix;
glTranslatef(0,0,0);
glutSolidSphere(0.6, 50, 50);
glPopMatrix;

glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @med_shine);
// рисуем гусеничку
glPushMatrix;
glTranslatef(0,0,1);
glutSolidSphere(0.6, 50, 50);
glPopMatrix;

glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, @high_shine);
// рисуем гусеничку
glPushMatrix;
glTranslatef(0,0,2);
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
// плоскость ХОZ => меняем только pos[0] - x, pos[3] - z
// пусть парабола задана уравнением: x = z^2 - 4.
// то есть мы идем по оси икс, а считаем кординату z^2
// начальная точка - (0.0, 1.0, -4.0, 1.0)
// четвертый параметр - v, уходит ли источник света в бесконечность (0 - да, 1 - нет)
// движение источника света по параболе в одну сторону
if key=VK_F1 then
  pos[0]:= pos[0] - 0.5;  // иксовая координата
  pos[2]:= pos[0] * pos[0] - 4.0;  // зетовая координата
  Refresh;
// движение источника света по параболе в одну сторону
if key=VK_F2 then
  pos[0]:= pos[0] + 0.5;  // иксовая координата
  pos[2]:= pos[0] * pos[0] - 4.0;  // зетовая координата
  Refresh;
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
