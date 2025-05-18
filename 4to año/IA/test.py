import numpy as np
import matplotlib.pyplot as plt
from typing import Callable, Tuple, List

class GeneticAlgorithm:
    def __init__(self, 
                 objective_func: Callable[[np.ndarray], float],
                 bounds: Tuple[Tuple[float, float], Tuple[float, float]],
                 population_size: int = 50,
                 mutation_rate: float = 0.1,
                 crossover_rate: float = 0.9,
                 max_generations: int = 100,
                 elitism_count: int = 2):
        """
        Inicializa el algoritmo genético para minimizar una función en R².
        
        Args:
            objective_func: Función objetivo a minimizar (debe tomar un array de 2 elementos)
            bounds: Límites para cada dimensión ((x_min, x_max), (y_min, y_max))
            population_size: Tamaño de la población
            mutation_rate: Probabilidad de mutación
            crossover_rate: Probabilidad de cruce
            max_generations: Número máximo de generaciones
            elitism_count: Número de mejores individuos que pasan directamente a la siguiente generación
        """
        self.objective_func = objective_func
        self.bounds = np.array(bounds)
        self.population_size = population_size
        self.mutation_rate = mutation_rate
        self.crossover_rate = crossover_rate
        self.max_generations = max_generations
        self.elitism_count = elitism_count
        
        # Inicializar población
        self.population = self.initialize_population()
        
    def initialize_population(self) -> np.ndarray:
        """Genera una población inicial aleatoria dentro de los límites especificados."""
        return np.array([
            np.random.uniform(low=self.bounds[:, 0], high=self.bounds[:, 1]) 
            for _ in range(self.population_size)
        ])
    
    def evaluate_population(self) -> np.ndarray:
        """Evalúa la población actual y devuelve los valores de fitness."""
        return np.array([self.objective_func(ind) for ind in self.population])
    
    def selection_roulette(self, fitness: np.ndarray) -> List[np.ndarray]:
        """Selección por ruleta (proporcional al fitness)."""
        # Para minimización, convertimos el problema a maximización
        adjusted_fitness = 1 / (1 + fitness)  # Evita división por cero
        
        total_fitness = np.sum(adjusted_fitness)
        if total_fitness == 0:
            probabilities = np.ones(len(fitness)) / len(fitness)
        else:
            probabilities = adjusted_fitness / total_fitness
        
        selected_indices = np.random.choice(
            len(self.population), 
            size=len(self.population) - self.elitism_count, 
            p=probabilities
        )
        
        return [self.population[i] for i in selected_indices]
    
    def crossover(self, parent1: np.ndarray, parent2: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
        """Cruza dos padres para producir dos hijos (crossover aritmético)."""
        if np.random.rand() > self.crossover_rate:
            return parent1.copy(), parent2.copy()
        
        alpha = np.random.rand()
        child1 = alpha * parent1 + (1 - alpha) * parent2
        child2 = alpha * parent2 + (1 - alpha) * parent1
        
        return child1, child2
    
    def mutate(self, individual: np.ndarray) -> np.ndarray:
        """Aplica mutación a un individuo."""
        mutated = individual.copy()
        for i in range(len(mutated)):
            if np.random.rand() < self.mutation_rate:
                mutated[i] = np.random.uniform(
                    low=self.bounds[i, 0], 
                    high=self.bounds[i, 1]
                )
        return mutated
    
    def run(self) -> Tuple[np.ndarray, float, List[float]]:

        """Ejecuta el algoritmo genético y devuelve el mejor individuo, su fitness y el historial."""
        best_fitness_history = []
        
        for generation in range(self.max_generations):
            # Evaluar población
            fitness = self.evaluate_population()
            best_idx = np.argmin(fitness)
            best_fitness = fitness[best_idx]
            best_fitness_history.append(best_fitness)
            
            # Seleccionar élite
            elite_indices = np.argsort(fitness)[:self.elitism_count]
            elite = [self.population[i] for i in elite_indices]
            
            # Selección por ruleta
            selected = self.selection_roulette(fitness)
            
            # Cruzar y mutar
            next_population = elite.copy()
            
            for i in range(0, len(selected), 2):
                if i + 1 >= len(selected):
                    break  # Si hay un número impar, ignoramos el último
                
                parent1, parent2 = selected[i], selected[i+1]
                child1, child2 = self.crossover(parent1, parent2)
                
                next_population.extend([
                    self.mutate(child1),
                    self.mutate(child2)
                ])
            
            # Asegurar que la población tenga el tamaño correcto
            self.population = np.array(next_population[:self.population_size])
            
            # Mostrar progreso
            if generation % 10 == 0:
                print(f"Generación {generation}: Mejor fitness = {best_fitness}")
        
        # Devolver el mejor resultado
        final_fitness = self.evaluate_population()
        best_idx = np.argmin(final_fitness)
        return self.population[best_idx], final_fitness[best_idx], best_fitness_history
    
def rastrigin(x: np.ndarray) -> float:
    """Función de Rastrigin en 2D, común para pruebas de optimización."""
    A = 10
    return A * 2 + (x[0]**2 - A * np.cos(2 * np.pi * x[0])) + (x[1]**2 - A * np.cos(2 * np.pi * x[1]))

def funcion1(x: np.ndarray) -> float:
    return (x[0]-x[1])**2 + (x[0]-x[1])**4

# Configurar y ejecutar el algoritmo genético
ga = GeneticAlgorithm(
    objective_func=rastrigin,
    bounds=((-5.12, 5.12), (-5.12, 5.12)),  # Límites típicos para Rastrigin
    population_size=100,
    mutation_rate=0.05,
    crossover_rate=0.85,
    max_generations=100,
    elitism_count=2
)

best_solution, best_fitness, history = ga.run()

print("\nMejor solución encontrada:")
print(f"Coordenadas (x, y): {best_solution}")
print(f"Valor de la función: {best_fitness}")

# Graficar la convergencia
plt.plot(history)
plt.title("Convergencia del Algoritmo Genético")
plt.xlabel("Generación")
plt.ylabel("Mejor Fitness")
plt.grid(True)
plt.show()