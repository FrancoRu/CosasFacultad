import random
import time
import matplotlib.pyplot as plt
import numpy as np
from sklearn import svm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D


#Ejercicio 1:

def Ejercicio1():
    d = float(input("Ingrese el tamaño de paso (ejemplo: 0.05): "))
    # Punto inicial entre 0 y 1
    x, y = round(random.random(), 4), round(random.random(), 4)

    # Función a minimizar
    def calcularFn(x, y):
        return 3 * (x**2) * (y**2)

    # Calcular el gradiente
    def calcularPuntos(x, y):
        return (6 * x * (y**2), 6 * (x**2) * y)

    # Número máximo de iteraciones
    n = 100
    # Umbral de tolerancia para detenerse
    tolerancia = 1e-4

    print(f"Inicio (x, y) = ({x:.6f}, {y:.6f}), f(x, y) = {calcularFn(x, y):.6f}")

    for i in range(n):
        grad_x, grad_y = calcularPuntos(x, y)  # Calculamos el gradiente
        x_nuevo = x - (d * grad_x)
        y_nuevo = y - (d * grad_y)

        # Actualizar valores de x e y con redondeo a 6 decimales
        x, y = x_nuevo, y_nuevo

        print(f"Iteración {i+1}: (x, y) = ({x:.6f}, {y:.6f}), f(x, y) = {calcularFn(x, y):.6f}")

    print("Proceso finalizado.")

#1) El algoritmo funciona yendo al punto minimo de una funcion usando la direccion negativa del gradiente
#   donde el mismo esta definido por las derivadas parciales con respecto a x e y, actualizando en cada
#   iteracion el nuevo valor de x e y usando la formula x = x - dx * grad_x e y = y - dy * grad_y  

#2) Segun el factor multiplicativo que asignemos obtendremos unos resultados u otros, ejemplo, en este
#   algortimo si se usa un factor multiplicativo muy grande para el desplazamiento, podremos salirnos de 
#   la misma funcion alejandonos de su minimo, en cambio si se elige un desplazamiento muy inferior podriamos
#   tener que necesitar mas iteraciones y costo computacional para llegar al minimo. Por eso es fundamental
#   elegir un buen desplazamiento como por ejemplo 0.005.

#Ejercicio 2
def Ejercicio2():
    print("")

#Ejercicio 3
def Ejercicio3(k):
    #Definimos la variables
    n = 73 #Esto es para la primera prueba
    min_val = 1 #Valor minimo en el arreglo
    max_val = 100000 #Valor maximo en el arreglo
    numeros_aleatorios = random.sample(range(min_val, max_val), 20000) #Asignacion de 20k numeros al arreglo

    #Funcion que calcula el valor un numero n en el anillo k
    def calcularAnillo(value):
        return value % k

    tiempos_acumulados = []
    
    start_time = time.time()
    print(f"Primer prueba: con n = {n} y k = {k}: {calcularAnillo(n)}")
    elapsed_time = time.time() - start_time
    tiempos_acumulados.append(elapsed_time)

    for i in range(n):
        start_time = time.time()
        calcularAnillo(numeros_aleatorios[i])
        elapsed_time = time.time() - start_time
        tiempos_acumulados.append(tiempos_acumulados[-1] + elapsed_time)
        if (i+1) % 1000 == 0: 
            print(f"Iteración {i+1} con n = {numeros_aleatorios[i]} y k = {k}: Tiempo acumulado = {tiempos_acumulados[-1]:.6f} segundos")

    plt.plot(range(n+1), tiempos_acumulados, label='Tiempo acumulado')
    plt.xlabel('Iteración')
    plt.ylabel('Tiempo acumulado (segundos)')
    plt.title(f'Tiempo acumulado de cómputo con k = {k}')
    plt.grid(True)
    plt.show()

#Ejercicio 4
def Ejercicio4():
    # Crear los conjuntos de puntos
    # Conjunto 1 
    C1 = np.array([[1, 2, 3], [2, 3, 5], [3, 4, 7]])

    # Conjunto 2 
    C2 = np.array([[-1,-2,-1], [-2,-4,-2], [-3,-6,-3]])

    # Etiquetas de los puntos
    y_C1 = np.ones(len(C1))  # Etiquetas para el conjunto 1
    y_C2 = -np.ones(len(C2))  # Etiquetas para el conjunto 2

    # Concatenar los datos y etiquetas
    X = np.vstack((C1, C2))
    y = np.hstack((y_C1, y_C2))

    # Crear y entrenar el clasificador SVM
    clf = svm.SVC(kernel='linear')
    clf.fit(X, y)

    # Coeficientes del hiperplano
    w = clf.coef_[0]
    b = clf.intercept_[0]

    # Mostrar los coeficientes del hiperplano
    print(f"Coeficientes del hiperplano: w = {w}, b = {b}")

    # Graficar los puntos y el hiperplano
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    # Puntos del conjunto 1
    ax.scatter(C1[:, 0], C1[:, 1], C1[:, 2], c='r', label='Conjunto 1')

    # Puntos del conjunto 2
    ax.scatter(C2[:, 0], C2[:, 1], C2[:, 2], c='b', label='Conjunto 2')

    # Definir el hiperplano
    xx, yy = np.meshgrid(np.linspace(min(X[:, 0]), max(X[:, 0]), 100),
                         np.linspace(min(X[:, 1]), max(X[:, 1]), 100))

    # Resolver para zz
    zz = (-w[0] * xx - w[1] * yy - b) * 1.0 / w[2]

    # Graficar el hiperplano
    ax.plot_surface(xx, yy, zz, alpha=0.5, rstride=100, cstride=100)

    # Etiquetas
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')

    # Mostrar leyenda
    ax.legend()

    plt.show()