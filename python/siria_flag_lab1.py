from sys import stderr

import glfw
# import random
# import math
from OpenGL.GL import *
# from OpenGL.GLU import *


# Вывод сообщения об ошибке
def fputs(desc, stderr):
    pass


def error(code, desc):
    fputs(desc, stderr)


def drawPicture(window):
    # print('oops!')
    glfw.get_framebuffer_size(window)
    width = glfw.get_framebuffer_size(window)[0]
    height = glfw.get_framebuffer_size(window)[1]
    glViewport(0, 0, width, height)
    # Очистка буфера кадра
    glClear(GL_COLOR_BUFFER_BIT)

    # Цвет фона - белый
    glClearColor(1, 1, 1, 1)

    # верхняя красная полоса
    glColor3f(0.8, 0, 0)
    glRectf(-1, 0.33, 1, 1)

    # нижняя черная полоса
    glColor3f(0, 0, 0)
    glRectf(-1, -1, 1, -0.33)

    # зеленые звезды
    glBegin(GL_TRIANGLES)
    glColor3f(0, 0.39, 0)

    # 1 звезда
    glVertex2f(-0.33, -0.08)
    glVertex2f(-0.53, 0.065)
    glVertex2f(-0.13, 0.065)

    glVertex2f(-0.33, 0.2)
    glVertex2f(-0.455, -0.17)
    glVertex2f(-0.255, -0.025)

    glVertex2f(-0.33, -0.08)
    glVertex2f(-0.205, -0.17)
    glVertex2f(-0.255, -0.025)

    # 2 звезда
    glVertex2f(0.33, -0.08)
    glVertex2f(0.53, 0.065)
    glVertex2f(0.13, 0.065)

    glVertex2f(0.33, 0.2)
    glVertex2f(0.455, -0.17)
    glVertex2f(0.255, -0.025)

    glVertex2f(0.33, -0.08)
    glVertex2f(0.205, -0.17)
    glVertex2f(0.255, -0.025)
    glEnd()

    # glBegin(GL_POLYGON)
    # glColor3f(1, 0, 0.7)
    # for i in range(0, 7):
    #     glVertex2f(0.5 * math.cos(2 * math.pi * i / 6), 0.5 * math.sin(2 * math.pi * i / 6))
    # glEnd()

    # glBegin(GL_TRIANGLES)
    # glColor3f(0, 0, 0)
    # glVertex2f(-1, -1)
    # glVertex2f(-1, 1)
    # glVertex2f(0, 0)
    # glVertex2f(0, 0)
    # glVertex2f(1, 1)
    # glVertex2f(1, -1)
    # glEnd()


# ----------------------------------------------
# Установка обработчика callback-функции
glfw.set_error_callback(error)

# Инициализация библиотеки
if not glfw.init():
    exit(-1)

# Создание окна
window = glfw.create_window(800, 600, "Флаг Сирии", None, None)

# Установка окна текущим контекстом
glfw.make_context_current(window)

# Пока окно не закрыто, рисуй
while not glfw.window_should_close(window):
    drawPicture(window)

    glfw.swap_buffers(window)
    glfw.poll_events()

glfw.destroy_window(window)
# Закрытие всех окон и освобождение ресурсов
glfw.terminate()
