import sympy as sp
import numpy as np
import pandas as pd
import random
import time
import matplotlib.pyplot as plt
import math
# from google.colab import auth, drive 
# drive.mount('/content/drive') 

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

def Ejercicio2(): 
    var_x = [1,2,3,4,5]
    var_y = [2,3,5,4,6]

    def prod(datos_x, datos_y):
        productos = []
        for i in range(len(datos_x)):
            productos.append(datos_x[i] * datos_y[i])
        return productos

    def cua(datos):
        productos = []
        for elemento in datos:
            productos.append(elemento**2)
        return productos
    
    def m(datos_x, datos_y):
       pro = prod(datos_x, datos_y)
       cuad = cua(datos_x)
       pen = (sum(pro) - (sum(datos_x) * sum(datos_y)/len(datos_x))) / (sum(cuad) - (sum(datos_x)**2 / len(datos_x)))
       return pen

    def b(datos_x, datos_y, pen):
        return (sum(datos_y) / len(datos_y)) - (pen * (sum(datos_x) / len(datos_x)))

    pendiente = m(var_x, var_y)
    termino = b(var_x, var_y, pendiente)
    
    # Valores de x
    x = np.linspace(0, 10, 100)

    # Calculamos los valores correspondientes de 'y' usando la ecuación de la recta
    y = pendiente * x + termino

    # Graficamos la recta
    plt.figure(figsize=(8, 6))
    plt.plot(x, y, color='blue', label=f'y = {pendiente:.2f}x + {termino:.2f}')
    plt.scatter(var_x, var_y, color='red', label='Puntos')

    # Añadimos etiquetas y título
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title(f"Gráfico de la recta y={pendiente:.2f}x+{termino:.2f}")
    plt.legend()

    # Mostramos la gráfica
    plt.grid(True)
    plt.show()
    print(f"La ecuacion de la recta es y={pendiente:.2f}x+{termino:.2f}")


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

    for  i, elemento in enumerate(array):
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
    
    plt.ticklabel_format(style='plain', axis='y')
    plt.show()

def Ejercicio4():
    
    def convertirDF(dataFrame):

        # Encontrar la columna numérica y aplicar la función logarítmica
        for col in dataFrame.columns:
            #Se valida el tipo en la columna
            if dataFrame[col].dtype == "int64":
                #Si es un int64 entonces se aplica la transformacion logaritmica
                dataFrame[col] = dataFrame[col].apply(lambda x: math.log(x))

        if len(dataFrame.columns) > 10:
            dataFrame = dataFrame.iloc[:, :10]
            
        # Convertir los nombres de las columnas a minúsculas
        dataFrame.columns = map(str.lower, dataFrame.columns)

        # Transformar la columna ordinal a escala numérica
        # Dividir la cadena por comas y asignar valores numéricos a cada categoría
        categorias = {'Malo': 0, 'Neutro': 1, 'Bueno': 2, 'Muy bueno': 3}
        dataFrame['columna_ordinal'] = dataFrame['columna_ordinal'].apply(lambda x: categorias.get(x.split(',')[0].strip(), None))

        print(dataFrame)


        # Exportar a Google Drive
        # writer = pd.ExcelWriter('/content/drive/MyDrive/ejercicio4_ia.xlsx')
        # dataFrame.to_excel(writer, index=False)
        # writer.save()
        # auth.authenticate_user() # para poder guardar el excel en drive

    data = pd.DataFrame({
        'coluMna_numerico': [1,2,3,4],
        'columna_Ordinal': ['Malo', 'Neutro', 'Bueno', 'Muy bueno'],
        'columna_texto1': ['a', 'b', 'c', 'd'],
        'columna_texto2': ['a', 'b', 'c', 'd'],
        'columna_booleana': [True, False, True, False],
        'columna_booleana2': [True, False, True, False],
        'columna_BOOLEANA': [True, False, True, False],
        'columna_booleana3': [True, False, True, False],
        'COLUMNA_booleana': [True, False, True, False],
        'columna_booleana4': [True, False, True, False],
    })
    convertirDF(data)
Ejercicio3()
#RESPUESTAS

# 1
# a) Conforme pasan las iteraciones, el punto (x,y) se desplaza en la dirección del gradiente negativo de la función f(x,y). En otras palabras, 
# el punto se mueve hacia donde la función disminuye más rápidamente. Si la función tiene un mínimo local, el punto convergerá hacia ese mínimo.
# b) Acá pueden surgir 2 posibilidades:
#     * dx y dy pequeños: La función tendrá más precisión pero requerirá más iteraciones para llegar al punto de convergencia
#     * dx y dy grandes: La función sacrifica precisión pero tendrá que realizar menos iteraciones, pero cabe la posibilidad de que si el desplazamiento es muy grande la misma sólo diverge y no converja en un punto en particular.
# c) Si la función no es diferenciable en el rango en cuestión, esto puede causar problemas con el método del gradiente descendente. En primer lugar, el gradiente podría no estar definido en ciertos puntos, lo que dificultará la determinación de la dirección del movimiento. Además, incluso si el gradiente está definido, podría ser poco confiable cerca de los puntos de no diferenciabilidad, lo que podría llevar a comportamientos inesperados, como oscilaciones o divergencia en el algoritmo.
# Cuando los diferenciales son extremadamente pequeños, el costo computacional tiende a aumentar. Esto se debe a que se necesitan más iteraciones para alcanzar la convergencia, ya que cada paso es más pequeño y se necesita más tiempo para alcanzar el mínimo global. Además, la precisión numérica también puede influir en el costo computacional, ya que calcular los gradientes con diferenciales muy pequeños puede introducir errores numéricos adicionales.
