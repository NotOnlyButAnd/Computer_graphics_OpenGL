from sys import stderr

import glfw
import random
from OpenGL.GL import *
import math
# from OpenGL.GLU import *


# Вывод сообщения об ошибке
def fputs(desc, stderr):
    pass


def error(code, desc):
    fputs(desc, stderr)


def drawPicture(window, choice = 0):
    # print('oops!')
    glfw.get_framebuffer_size(window)
    width = glfw.get_framebuffer_size(window)[0]
    height = glfw.get_framebuffer_size(window)[1]
    glViewport(0, 0, width, height)
    # Очистка буфера кадра
    glClear(GL_COLOR_BUFFER_BIT)

    # Цвет фона - черный
    glClearColor(0, 0, 0, 0)

    if choice == 1:
        glTranslatef(x, 0, 0)
        glTranslatef(0, y, 0)
    elif choice == 2:
        glTranslatef(x, 0, 0)
        glTranslatef(0, y, 0)
        glRotatef(15, 0, 0, 1)
    elif choice == 3:
        glTranslatef(x, 0, 0)
        glTranslatef(0, y, 0)
        glRotatef(-15, 0, 0, 1)
    # LAB 3
    glBegin(GL_QUADS)
    glColor3f(1, 1, 1)
    glVertex2f(0.2, 0.2)
    glVertex2f(0.2, -0.2)
    glVertex2f(-0.2, -0.2)
    glVertex2f(-0.2, 0.2)
    print(f"Drawing... {x} - x, {y} - y")
    glEnd()

    glColor3f(0.8, 0, 0)
    glRectf(-0.05, 0.0, 0.05, 0.2)


    if choice == 1 or choice == 2 or choice == 3:
        glTranslatef(-x, 0, 0)
        glTranslatef(0, -y, 0)

    glfw.swap_buffers(window)


# 262 - стрелка вправо, 263 - стрелка влево
# 264 - стрелка вниз, 265 - стрелка вверх
x = 0
y = 0


def onKeyboard(window, key, scancode, action, mods):
    global x, y
    print('keyboard: ', key, scancode, action, mods)
    if action == glfw.PRESS:
        if key == glfw.KEY_DOWN:
            print("arrow down...")
            y = y - 0.1
            drawPicture(window, 1)
        elif key == glfw.KEY_UP:
            print("arrow up...")
            y = y + 0.1
            drawPicture(window, 1)
        elif key == glfw.KEY_LEFT:
            print("arrow left...")
            x = x - 0.1
            drawPicture(window, 1)
        elif key == glfw.KEY_RIGHT:
            print("arrow right...")
            x = x + 0.1
            drawPicture(window, 1)
        elif key == glfw.KEY_R:
            print("R key....")
            drawPicture(window, 2)
        elif key == glfw.KEY_T:
            print("T key....")
            drawPicture(window, 3)
        else:
            # toggle cut
            print("SOMETHING ELSE...")


def onSize(window, width, height):
    print('onsize: ', width, height)
    glfw.get_framebuffer_size(window)
    width = glfw.get_framebuffer_size(window)[0]
    height = glfw.get_framebuffer_size(window)[1]
    glViewport(0, 0, width, height)
    drawPicture(window)


# ----------------------------------------------
# Установка обработчика ошибок
glfw.set_error_callback(error)


# Инициализация библиотеки
if not glfw.init():
    exit(-1)



# Создание окна
window = glfw.create_window(800, 600, "Флаг Сирии", None, None)

# устанавливаем обработчики нажатий клавиши и изменения окна
glfw.set_key_callback(window, onKeyboard)
glfw.set_window_size_callback(window, onSize)

# Установка окна текущим контекстом
glfw.make_context_current(window)

# нарисовали в первый раз
drawPicture(window)


# Пока окно не закрыто, ждем кнопки и события считываем
while not glfw.window_should_close(window):
    glfw.poll_events()



glfw.destroy_window(window)
# Закрытие всех окон и освобождение ресурсов
glfw.terminate()
