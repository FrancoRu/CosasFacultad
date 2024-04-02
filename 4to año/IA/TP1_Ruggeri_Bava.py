import sympy as sp
import numpy as np
import random
import time
import matplotlib.pyplot as plt

def Ejercicio1():
    # Definir las variables
    x, y = sp.symbols('x y')

    # Definir el desplazamiento
    dx = 0.05
    dy = 0.05

    # Definir los arreglos para la pruebas de tiempo
    dx_values = [0.5, 0.05, 0.005]
    dy_values = [0.5, 0.05, 0.005]

    # Definir el punto de comienxo
    punto_x = random.random()
    punto_y = random.random()

    # Definir la funcion
    def f(x,y):
        return 3 * (x ** 2) * (y **2)

    # Definir el cambio de paso
    def move(punto_x, punto_y, dx, dy):
        new_y = punto_y - dy * (punto_y/(sp.sqrt(punto_x**2 + punto_y **2)))
        new_x = punto_x - dx * (punto_x/(sp.sqrt(punto_x**2 + punto_y **2)))
        return new_x, new_y

    # Definir el bucle
    for i in range(100):
        print(f"Iteracion {i}: par ({punto_x:.4f},{punto_y:.4f}), valor funcion f({punto_x:.4f},{punto_y:.4f}) = {f(punto_x, punto_y):.4f}")

        #Desplazarse
        punto_x, punto_y = move(punto_x, punto_y, dx, dy)

    for dx in dx_values:
        for dy in dy_values:
            punto_x = 0.9
            punto_y = 0.9
            start_time = time.time()
            prev_value = float('inf')
            for i in range(100):
                new_value = f(punto_x, punto_y)
                if abs(new_value - prev_value) < 1e-6: 
                    break
                punto_x, punto_y = move(punto_x, punto_y, dx, dy)
                prev_value = new_value
            end_time = time.time()
            tiempo_ejecucion = end_time - start_time
            print(f"dx = {dx}, dy = {dy}, Tiempo de ejecución = {tiempo_ejecucion:.4f} segundos")

# Ejercicio1()

def Ejercicio3():

    def calcular_anillo(n, k):
        return n % k

    # Probar con n = 73 y k = 3
    n = 73
    k = 3
    resultado = calcular_anillo(n, k)
    print(f"El valor en el anillo Z{k} para n={n} es: {resultado}")

    # Crear array aleatorio de 10,000 elementos
    array = np.random.randint(1000, size=10000)

    # Medir el tiempo acumulado en cada iteración
    tiempo_acumulado = []
    tiempo_total = 0

    for i, elemento in enumerate(array):
        inicio = time.time()
        calcular_anillo(elemento, k)
        fin = time.time()
        tiempo_total += (fin - inicio)
        tiempo_acumulado.append(tiempo_total)

    # Graficar el tiempo acumulado en cada iteración
    plt.plot(tiempo_acumulado)
    plt.xlabel('n de interacción')
    plt.ylabel('Tiempo acumulado (s)')
    plt.title('Tiempo acumulado en cada iteración')
    plt.show()
    