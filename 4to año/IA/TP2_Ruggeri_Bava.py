import numpy as np
import matplotlib.pyplot as plt

def Ejecricio1():
    
    # Media
    def media(datos):
        return sum(datos) / len(datos)

    # Desvio estandar
    def sd(datos):
        cont = 0
        med = media(datos)
        for element in datos:
            cont += ((element - med) ** 2) / (len(datos) -1)
        return np.sqrt(cont)

    # Estandarizacion
    def Estandar(datos):
        estandarizado = []
        med = media(datos)
        des_est = sd(datos)
        if des_est == 0 :
            return datos
        else:
            for element in datos:
                estandarizado.append((element - med) / des_est)
        return estandarizado


    entrada1 = [2.3, 4, 5, 6, 1, 1, 1, 1, 2, 3, 4, 6, 9] 
    entrada2 = [2.3, 2.3, 2.3]
    entrada3 = [2.1111, 4, 4, 4, 4, 4, 4, 4, 4, 99, 99, 1, -5, -99]
    print("Datos originales:", entrada1)
    print("Media:", media(entrada1))
    print("Desviación estándar:", sd(entrada1))
    print("Datos estandarizados:", Estandar(entrada1))
    print("")
    print("******************************************")
    print("")
    print("Datos originales:", entrada2)
    print("Media:", media(entrada2))
    print("Desviación estándar:", sd(entrada2))
    print("Datos estandarizados:", Estandar(entrada2))
    print("")
    print("******************************************")
    print("")
    print("Datos originales:", entrada3)
    print("Media:", media(entrada3))
    print("Desviación estándar:", sd(entrada3))
    print("Datos estandarizados:", Estandar(entrada3))

    datos_estandarizados_1 = Estandar(entrada1)
    datos_estandarizados_2 = Estandar(entrada2)
    datos_estandarizados_3 = Estandar(entrada3)

     # Graficar la distribución normal de los datos estandarizados
    plt.figure(figsize=(15, 5))

    plt.subplot(1, 3, 1)
    plt.hist(datos_estandarizados_1, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    media_est_1 = media(datos_estandarizados_1)
    des_est_1 = sd(datos_estandarizados_1)
    pdf = 1/(des_est_1 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_1)**2 / (2 * des_est_1**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 1')

    plt.subplot(1, 3, 2)
    plt.hist(datos_estandarizados_2, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    media_est_2 = media(datos_estandarizados_2)
    des_est_2 = sd(datos_estandarizados_2)
    pdf = 1/(des_est_2 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_2)**2 / (2 * des_est_2**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 2')

    plt.subplot(1, 3, 3)
    plt.hist(datos_estandarizados_3, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    media_est_3 = media(datos_estandarizados_3)
    des_est_3 = sd(datos_estandarizados_3)
    pdf = 1/(des_est_3 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_3)**2 / (2 * des_est_3**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 3')

    plt.tight_layout()
    plt.show()

   
def Ejercicio2():
    

Ejecricio1()


