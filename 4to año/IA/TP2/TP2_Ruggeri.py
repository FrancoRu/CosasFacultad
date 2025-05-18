import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import kagglehub

dt = pd.read_csv('netflix_titles.csv')

#parte 1
# Las variables ordinales son aquellas que se pueden jerarquizar o que poseen algun orden, 
# ejemplo 'Primero', 'Segundo', ... ,'i-esimo'
# Las variables cualitativas son aquellas que no poseen un orden o jerarquia, si no que representan-
# una cualidad o caracteristicas del objeto, ejemplo un titulo, un color, etc

def Ejercicio3():
    def parte2():
        dt['duration'] = dt['duration'].str.replace(' min', '', regex=True)
        dt['duration'] = pd.to_numeric(dt['duration'], errors='coerce')  # Convierte a número

        #parte 2a
        print("🔹 TOP 10 títulos más recientes:")
        print(dt[['title', 'release_year']].sort_values(by='release_year', ascending=False).head(10))

        print("\n🔹 TOP 10 títulos con mayor duración:")
        print(dt[['title', 'duration']].sort_values(by='duration', ascending=False).head(10))

        print(dt['type'].value_counts())

        #parte 2b
        print(pd.get_dummies(dt['type']))

        print(pd.get_dummies(dt['country']))

    def parte3():
        #parte 3
        #Carga el conjunto de datos.
        dt = pd.read_csv('bots_vs_users.csv')
        total_filas = len(dt)
        columns = ['avg_likes', 'has_photo']  

        #Realiza un análisis exploratorio para identificar la cantidad de valores nulos por columna.
        for col in columns:
            nulos = dt[col].isnull().sum()
            no_nulos = total_filas - nulos  
            print(f"Columna '{col}':")
            print(f" - Valores nulos: {nulos} ({nulos * 100 / total_filas:.2f}%)")
            print(f" - Valores no nulos: {no_nulos} ({no_nulos * 100 / total_filas:.2f}%)\n")


        #dt['avg_likes']  numerica
        #dt['has_photo'] categorica

        # Guardamos el número de filas original
        original_filas = dt.shape[0]

        # Contamos nulos considerando 'Unknown' como nulo en 'has_photo'
        dt_filtrado = dt.copy()
        dt_filtrado['has_photo'] = dt_filtrado['has_photo'].replace('Unknown', np.nan)

        # Eliminamos filas con cualquier nulo
        dt_sin_nulos = dt_filtrado.dropna()

        # Comparativa
        filas_restantes = dt_sin_nulos.shape[0]
        print(f"Filas originales: {original_filas}")
        print(f"Filas tras eliminación de nulos: {filas_restantes}")
        print(f"Se eliminaron {original_filas - filas_restantes} filas ({(original_filas - filas_restantes) * 100 / original_filas:.2f}%)")

        # Imputar con la mediana (más robusta si hay outliers)
        mediana = dt['avg_likes'].median()
        dt['avg_likes_imputada'] = dt['avg_likes'].fillna(mediana)

        # Reemplazar 'Unknown' con np.nan y luego imputar
        moda = dt['has_photo'].replace('Unknown', np.nan).mode()[0]
        dt['has_photo_imputada'] = dt['has_photo'].replace('Unknown', np.nan).fillna(moda)


        plt.figure(figsize=(10, 4))

        # Antes de imputar
        plt.subplot(1, 2, 1)
        sns.histplot(dt['avg_likes'], bins=30, kde=True, color='skyblue')
        plt.title("Distribución de 'avg_likes' (original)")
        plt.xlabel("avg_likes")
        plt.ylabel("Frecuencia")

        # Después de imputar
        plt.subplot(1, 2, 2)
        sns.histplot(dt['avg_likes_imputada'], bins=30, kde=True, color='seagreen')
        plt.title("Distribución de 'avg_likes' (imputada con mediana)")
        plt.xlabel("avg_likes")
        plt.ylabel("Frecuencia")

        plt.tight_layout()
        plt.show()

        plt.figure(figsize=(10, 4))

        # Antes de imputar
        columna_original = dt['has_photo'].replace({
            '0.0': 'No',
            '1.0': 'Sí',
            'Unknown': np.nan
        }).fillna('Nulo')

        plt.subplot(1, 2, 1)
        sns.countplot(x=columna_original, palette='Set2')
        plt.title("Distribución de 'has_photo' (original)")
        plt.xlabel("has_photo")
        plt.ylabel("Cantidad")
        plt.grid(axis='y')

        # Después de imputar
        columna_imputada = dt['has_photo_imputada'].replace({
            '0.0': 'No',
            '1.0': 'Sí'
        })

        plt.subplot(1, 2, 2)
        sns.countplot(x=columna_imputada, palette='Set3')
        plt.title("Distribución de 'has_photo' (imputada con moda)")
        plt.xlabel("has_photo")
        plt.ylabel("Cantidad")
        plt.grid(axis='y')

        plt.tight_layout()
        plt.show()

