import random
import numpy as np
from ucimlrepo import fetch_ucirepo 
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

class AG:
    def __init__(
        self,
        dataset,
        tam_poblacion: int = 200,
        generaciones: int = 50,
        metodo: str = "accuracy"):
        
        self.dt = dataset
        self.n: int = tam_poblacion
        self.generacion: int = generaciones
        self.metodo: str = metodo

        # Variables del dataset
        self.variables: list = dataset.data.features.columns.tolist()
        self.dimension: int = len(self.variables)

        # Dividir los datos
        self.X = dataset.data.features.values
        self.y = dataset.data.targets.values.ravel()
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(
            self.X, self.y, test_size=0.3, random_state=42)

        # Inicializar población binaria (0/1) de tamaño (n_individuos x n_features)
        self.poblacion: np.ndarray = np.random.randint(2, size=(self.n, self.dimension))

        # Almacenar mejor solución
        self.mejor_score = 0
        self.mejor_individuo = None


    def fitness(self, individuo):
        indices = np.where(individuo == 1)[0]
        if len(indices) == 0:
            return 0
        modelo = RandomForestClassifier()
        modelo.fit(self.X_train[:, indices], self.y_train)
        preds = modelo.predict(self.X_test[:, indices])
        return accuracy_score(self.y_test, preds)

    def torneo(self, scores, k=3):
        idxs = random.sample(range(self.n), k)
        mejor_idx = idxs[np.argmax([scores[i] for i in idxs])]
        return self.poblacion[mejor_idx]

    def crossover(self, p1, p2):
        punto = random.randint(1, self.dimension - 1)
        return np.concatenate([p1[:punto], p2[punto:]])

    def mutar(self, individuo, tasa=0.1):
        for i in range(len(individuo)):
            if random.random() < tasa:
                individuo[i] = 1 - individuo[i]
        return individuo

    def run(self):
        for gen in range(self.generacion):
            scores = [self.fitness(ind) for ind in self.poblacion]
            nueva_poblacion = []

            print(f"Generación {gen + 1} - Mejor score: {max(scores):.4f}")

            for _ in range(self.n):
                padre1 = self.torneo(scores)
                padre2 = self.torneo(scores)
                hijo = self.crossover(padre1, padre2)
                hijo = self.mutar(hijo)
                nueva_poblacion.append(hijo)

            self.poblacion = np.array(nueva_poblacion)

            # Actualizar mejor individuo
            mejor_idx = np.argmax(scores)
            if scores[mejor_idx] > self.mejor_score:
                self.mejor_score = scores[mejor_idx]
                self.mejor_individuo = self.poblacion[mejor_idx]

        print("\n✅ Mejores características seleccionadas:")
        for i in np.where(self.mejor_individuo == 1)[0]:
            print(f"- {self.variables[i]}")
        print(f"\n🎯 Accuracy final: {self.mejor_score:.4f}")

# Ejecutar con el dataset Wine
wine = fetch_ucirepo(id=109)
algoritmo = AG(dataset=wine, tam_poblacion=30, generaciones=10)
algoritmo.run()
