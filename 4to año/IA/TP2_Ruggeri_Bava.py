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
    

def Ejercicio3():

    def numeric(columnas_numericas):
         # Columnas numéricas
        for columna in columnas_numericas:
            data[columna].plot(kind='hist', title=columna, bins=20)
            plt.xlabel(columna)
            plt.ylabel('Frecuencia')
            plt.show()

    def categoric(columnas_categoricas):
        # Columnas categóricas
        for columna in columnas_categoricas:
            if columna == 'model': # para que se distingan bien todos los modelos, hacemos que el gráfico sea mas ancho
                plt.figure(figsize=(15,5))
            data[columna].value_counts(dropna=False).plot(kind='bar', title=columna)
            plt.xlabel(columna)
            plt.ylabel('Frecuencia')
            plt.xticks(rotation=45)
            plt.show()
    #Carga conjunto de datos
    data = pd.read_csv('study_performance.csv')

    #Analisis exploratorio
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
    print('Informacion general del dataFrame: ')
    print(data.info())
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
    print('Cantidad de datos nulos por columnas: ')
    print(data.isnull().sum())
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')

    #Visualizacion de datos

    # Distribución de los datos para cada columna
    columnas_numericas = data.select_dtypes(include=['int64']).columns
    columnas_categoricas = data.select_dtypes(include='object').columns
    numeric(columnas_numericas)
    categoric(columnas_categoricas)

    #Cantidad de datos faltantes
    percentage =  (data.isnull().sum().sum() / data.shape[0] ) * 100
    print(f"porcentaje de faltante: {percentage:.2f}%")

    #Dado que el numero es alto, un 10,7% realizaremos una imputaicon de la columna con nulos test_preparation_course y lo reemplazaremos por el valor mas frecuente

    # Obtener una lista de columnas con valores nulos
    columnas_con_nulos = data.columns[data.isnull().any()].tolist()

    # Iterar sobre las columnas con valores nulos
    for columna in columnas_con_nulos:
        # Imputar el valor más frecuente en la columna actual
        valor_mas_frecuente = data[columna].mode()[0]
        data[columna].fillna(valor_mas_frecuente, inplace=True)

    # Mostramos que ya no hay valores nulos
    valores_nulos_por_columna = data.isnull().sum()
    print("Cantidad de valores nulos por columna actualizada:")
    print(valores_nulos_por_columna)

    # Distribución de los datos para cada columna
    columnas_numericas = data.select_dtypes(include=['int64']).columns
    columnas_categoricas = data.select_dtypes(include='object').columns
    numeric(columnas_numericas)
    categoric(columnas_categoricas)

Ejercicio3()


#RESPUESTAS

#1
# b) Ante la presencia de muchos valores atípicos la media se ve influenciada si estos se encuentran en los extremos 
# causando un desplazamiento de la media ya que todos los valores que implican sumas y promedio se ven influenciado con 
# valores atípicos.
# En presencia de múltiples valores atípicos, no se recomienda utilizar la media y puede ser más apropiado utilizar 
# medidas de tendencia central más robustas, como la mediana, que es menos sensible a los valores extremos. 
# c) Las conclusiones son:
# La entrada 1 tiene simetría positiva, que tiende a tener valores bajos o inferiores a la media.
# La entrada 2 no tiene campana de Gauss por que todos los valores son iguales y no se genera un área de probabilidad.
# Se observa una forma simétrica en la campana ya que los valores atípicos extremos compensan en cierto modo. Los valores 
# son muy heterogéneos.

# 2
# a) Variable Ordinal: Una variable ordinal es una variable cuyos valores representan categorías con un orden inherente o jerarquía.
# Aunque hay un orden, la distancia entre los valores puede no ser uniforme o significativa.
# Por lo tanto, aunque podemos decir que un valor es mayor que otro, no podemos asumir que la diferencia entre ellos es la misma 
# en todas partes de la escala. Ejemplo: Los niveles educativos: Primaria, Secundaria, Terciario, Universitario, Máster, Doctorado, etc.
# b) Variable Nominal: Una variable nominal es una variable cuyos valores representan categorías sin un orden inherente o jerarquía.
# No hay una relación de orden entre las categorías. Por lo tanto, no se puede decir que una categoría sea "mayor" o "mejor" que otra, s
# implemente son diferentes. Ejemplos comunes de variables nominales son el género (masculino, femenino), el estado civil (soltero, casado, 
# divorciado, viudo), el color de los ojos (azul, verde, marrón), etc.

# 3
# Eliminacion: La eliminación de datos la podemos hacer de dos formas:
#     *   La primera se conoce como eliminación de la lista (listwise deletion)
#     y consiste en remover del set de datos las filas que contengan datos faltantes, con la desventaja de que al eliminar la fila completa eliminaremos 
#     también algunos datos existentes, lo que puede llevar a una pérdida significativa de información.
#     *   La segunda forma es la eliminación por pares (pairwise deletion), que es un método menos agresivo que el anterior, pues en lugar de 
#     eliminar la fila completa se quitarán únicamente las casillas con el dato faltante. La ventaja es que preservaremos los datos conocidos, 
#     pero la desventaja es que podremos tener características (es decir columnas) con diferente cantidad de datos, lo que puede complicar el 
#     entrenamiento de un modelo.
# Imputacion: En la imputación lo que hacemos es mirar el comportamiento de los datos vecinos para poder estimar el valor del dato faltante. Para esta imputación 
# podemos usar dos técnicas: la imputación simple y la imputación múltiple:
#     *   Imputacion Simple: En la imputación simple se usa un algoritmo para hacer una única estimación y el valor obtenido se usa para reemplazar el dato 
#     faltante correspondiente
#         + La imputación por la media o la mediana es la más sencilla de todas: simplemente se toman los valores conocidos en la variable donde están los 
#         datos faltantes, se calculan la media o la mediana y se reemplazan los datos faltantes con cualquiera de estos dos valores. Aunque es muy fácil de 
#         implementar, este método tiene la desventaja de que al reemplazar muchos datos faltantes con un único valor estaremos cambiando la distribución de 
#         los datos.
#         + El tercer método de imputación simple es la imputación hot-deck. En este caso, el dato faltante es reemplazado con valores tomados de datos “cercanos” 
#         al dato faltante
#     *   Imputacion multiple: En lugar de hacer una sola estimación, en la imputación múltiple (como su nombre lo indica) se hacen múltiples estimaciones, 
#     que luego se combinan para producir un único valor, que será el usado para reemplazar el dato faltante correspondiente, con lo cual se puede disminuir 
#     el sesgo de la estimación.


