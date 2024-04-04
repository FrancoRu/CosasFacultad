import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import tkinter as tk
from tkinter import ttk

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
    
    datos_estandarizados_1 = Estandar(entrada1)
    datos_estandarizados_2 = Estandar(entrada2)
    datos_estandarizados_3 = Estandar(entrada3)
    
    print("Datos originales:", entrada1)
    print("Media:", media(entrada1))
    print("Desviación estándar:", sd(entrada1))
    print("Datos estandarizados:",datos_estandarizados_1)
    print("")
    print("******************************************")
    print("")
    print("Datos originales:", entrada2)
    print("Media:", media(entrada2))
    print("Desviación estándar:", sd(entrada2))
    print("Datos estandarizados:", datos_estandarizados_2)
    print("")
    print("******************************************")
    print("")
    print("Datos originales:", entrada3)
    print("Media:", media(entrada3))
    print("Desviación estándar:", sd(entrada3))
    print("Datos estandarizados:", datos_estandarizados_3)

     # Graficar la distribución normal de los datos estandarizados
    plt.figure(figsize=(15, 5))

    #Posicion del grafico
    plt.subplot(1, 3, 1)

    #Asignacion de valores para el histograma
    plt.hist(datos_estandarizados_1, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    #media de los datos estandarizados
    media_est_1 = media(datos_estandarizados_1)
    
    #Desviacion estandar de los datos estandarizados
    des_est_1 = sd(datos_estandarizados_1)
    
    #Funcion de densidad de probabilidad de la distribucion normal
    pdf = 1/(des_est_1 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_1)**2 / (2 * des_est_1**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 1')

    #Posicion del grafico
    plt.subplot(1, 3, 2)

    #Asignacion de valores para el histograma
    plt.hist(datos_estandarizados_2, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    #media de los datos estandarizados
    media_est_2 = media(datos_estandarizados_2)
    
    #Desviacion estandar de los datos estandarizados
    des_est_2 = sd(datos_estandarizados_2)
    
    #Funcion de densidad de probabilidad de la distribucion normal
    pdf = 1/(des_est_2 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_2)**2 / (2 * des_est_2**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 2')

    #Posicion del grafico
    plt.subplot(1, 3, 3)

    #Asignacion de valores para el histograma
    plt.hist(datos_estandarizados_3, bins=20, density=True, edgecolor='black')
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    #media de los datos estandarizados
    media_est_3 = media(datos_estandarizados_3)
    
    #Desviacion estandar de los datos estandarizados
    des_est_3 = sd(datos_estandarizados_3)
    
    #Funcion de densidad de probabilidad de la distribucion normal
    pdf = 1/(des_est_3 * np.sqrt(2 * np.pi)) * np.exp(-(x - media_est_3)**2 / (2 * des_est_3**2))
    plt.plot(x, pdf, color='r', linestyle='--')
    plt.title('Distribución Normalizada de entrada 3')

    plt.tight_layout()
    plt.show()

   
def Ejercicio2():
    datos = pd.read_csv('onlinefoods.csv')

    #Variables nominales
    gender = pd.get_dummies(datos['Gender'])
    occupation = pd.get_dummies(datos['Occupation'])
    
    #Variables ordinales
    age = datos['Age']
    education = datos['Educational Qualifications']

    def ranking(dataFrame, columns, order):
        df_copy = dataFrame.copy()

        frecuencia = df_copy.value_counts().reset_index()

        frecuencia.columns = columns

        frecuencia = frecuencia.sort_values(by=order, ascending=False)

        frecuencia = frecuencia.reset_index(drop=True)

        return frecuencia

    def showPercentage(data):
        for element in data:
            print(f"              - {element}: {data[element].sum():.4f}%")

    def showRanking(data):
        data['Ranking'] = range(1, len(data) + 1)  
        
        column_names = list(data.columns)

        # Reordenar las columnas para que 'Ranking' se a la primera columna
        column_names.insert(0, column_names.pop(column_names.index('Ranking')))
        data = data[column_names]
        # Imprimir el DataFrame con un formato personalizado
        print(data.to_string(index=False, formatters={'Ranking': lambda x: f"{'':>15}{x}"}))


            
    def percentage(dataFrame):

        df_copy = dataFrame.copy()

        # Calcular el total de observaciones
        total_observaciones = df_copy.sum().sum()

        # Calcular el porcentaje de cada columna
        for columna in df_copy.columns:
            df_copy[columna] = (df_copy[columna] / total_observaciones) * 100

        return df_copy

    # # Configurar el tamaño de la figura
    # plt.figure(figsize=(10, 6))

    # Calcular el porcentaje de ocupaciones
    occupation_percentage = percentage(occupation)

    # Calcular el porcentaje de generos
    gender_percentage = percentage(gender)

    # Obtener el ranking de edades
    age_ranking = ranking(age, ['Age', 'Quantity'], 'Quantity')
    # Obtener el ranking de education
    education_ranking = ranking(education, ['Educational Qualifications', 'Quantity'], 'Quantity')
    
    print("-------------------------------------------------------------------------")
    print("**************************************************************************")
    print("*                            Variables nominales:                        *")
    print("**************************************************************************")
    print("+    Ocupacion: ")
    showPercentage(occupation_percentage)
    print("-------------------------------------------------------------------------")
    print("+    Genero: ")
    showPercentage(gender_percentage)
    print("-------------------------------------------------------------------------")
    
    print("**************************************************************************")
    print("*                            Variables ordinales:                        *")
    print("**************************************************************************")
    print("+    Edad: ")
    showRanking(age_ranking)
    print("-------------------------------------------------------------------------")
    print("+    Educational Qualifications: ")
    showRanking(education_ranking)
    print("-------------------------------------------------------------------------")
    

# def Ejercicio3():
    
Ejercicio2()

