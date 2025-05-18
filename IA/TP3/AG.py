import random
import math

# Función objetivo a minimizar
def funcion1(xy):
    x, y = xy
    return (x - y)**2 + (x - y)**4

# Función para generar coordenadas iniciales
def generar_coordenadas(funcion_name, smart_init=True):
    """Genera coordenadas iniciales con posibilidad de inicio inteligente cerca del óptimo conocido"""
    if smart_init and funcion_name == "funcion1":
        # 70% de probabilidad de generar puntos cerca del óptimo (0,0)
        if random.random() < 0.7:
            return [random.gauss(0, 2), random.gauss(0, 2)]
        else:
            return [random.uniform(-10, 10), random.uniform(-10, 10)]
    else:
        dimensiones = 3 if funcion_name == "funcion3" else 2
        return [random.uniform(-10, 10) for _ in range(dimensiones)]

# Función de fitness adaptada para minimización
def calcular_fitness(valor_funcion):
    """Función de fitness que da más peso a valores cercanos a cero"""
    return 1 / (0.001 + abs(valor_funcion)**0.5)

# Operador de mutación mejorado
def mutar(individuo, generacion_actual, max_generaciones):
    """Mutación adaptativa que se reduce con las generaciones"""
    nuevo = []
    # Radio de mutación que decrece exponencialmente
    radio = 2 * math.exp(-5 * generacion_actual/max_generaciones)
    
    for gen in individuo:
        if random.random() < 0.3:  # Probabilidad de mutación fija
            # Mutación gaussiana centrada en el valor actual
            nuevo.append(gen + random.gauss(0, radio))
        else:
            nuevo.append(gen)
    return nuevo

# Operador de cruce
def cruzar(p1, p2, generacion_actual, max_generaciones):
    """Crossover con posible mutación"""
    # Elegir punto de corte aleatorio
    corte = random.randint(1, len(p1)-1)
    hijo = p1[:corte] + p2[corte:]
    
    # Aplicar mutación con cierta probabilidad
    if random.random() < 0.7:
        hijo = mutar(hijo, generacion_actual, max_generaciones)
    return hijo

# Búsqueda local para refinamiento
def busqueda_local(individuo, funcion, pasos=50, radio_inicial=0.5):
    """Refina una solución prometedora con búsqueda local"""
    mejor = individuo.copy()
    mejor_valor = funcion(mejor)
    radio = radio_inicial
    
    for _ in range(pasos):
        # Generar vecino
        vecino = [x + random.uniform(-radio, radio) for x in mejor]
        valor_vecino = funcion(vecino)
        
        # Reducir radio gradualmente
        radio *= 0.95
        
        if valor_vecino < mejor_valor:
            mejor = vecino
            mejor_valor = valor_vecino
    
    return mejor

# Algoritmo genético principal
def algoritmo_genetico(funcion, dimension=2, poblacion_size=100, max_generaciones=500):
    # Inicialización de población
    poblacion = [generar_coordenadas(funcion.__name__) for _ in range(poblacion_size)]
    
    mejor_historico = None
    mejor_valor_historico = float('inf')
    sin_mejora = 0
    umbral_sin_mejora = 50
    
    for generacion in range(max_generaciones):
        # Evaluación
        valores = [funcion(ind) for ind in poblacion]
        
        # Actualizar mejor histórico
        min_valor = min(valores)
        if min_valor < mejor_valor_historico:
            mejor_valor_historico = min_valor
            mejor_historico = poblacion[valores.index(min_valor)]
            sin_mejora = 0
        else:
            sin_mejora += 1
        
        # Verificar criterio de parada
        if mejor_valor_historico < 1e-10:  # Solución óptima encontrada
            print(f"¡Solución óptima encontrada en generación {generacion}!")
            break
            
        if sin_mejora >= umbral_sin_mejora:
            print(f"Sin mejora por {umbral_sin_mejora} generaciones. Deteniendo...")
            break
        
        # Selección por ruleta
        fitness_scores = [calcular_fitness(v) for v in valores]
        total_fitness = sum(fitness_scores)
        if total_fitness == 0:
            prob = [1/len(poblacion)] * len(poblacion)
        else:
            prob = [f/total_fitness for f in fitness_scores]
        
        # Crear rueda de ruleta
        rueda = []
        acumulado = 0
        for p in prob:
            acumulado += p
            rueda.append(acumulado)
        
        # Seleccionar élite (10% de la población)
        elite_size = max(2, poblacion_size//10)
        elite_indices = sorted(range(len(valores)), key=lambda i: valores[i])[:elite_size]
        elite = [poblacion[i] for i in elite_indices]
        
        # Crear nueva población
        nueva_poblacion = elite.copy()
        
        while len(nueva_poblacion) < poblacion_size:
            # Seleccionar padres
            padre1 = poblacion[bisect.bisect_right(rueda, random.random()) % len(poblacion)]
            padre2 = poblacion[bisect.bisect_right(rueda, random.random()) % len(poblacion)]
            
            # Cruzar
            hijo = cruzar(padre1, padre2, generacion, max_generaciones)
            nueva_poblacion.append(hijo)
        
        poblacion = nueva_poblacion
        
        # Mostrar progreso cada 10 generaciones
        if generacion % 10 == 0:
            print(f"Gen {generacion}: Mejor valor = {mejor_valor_historico:.6f}")
    
    # Aplicar búsqueda local al mejor individuo
    if mejor_historico:
        mejor_refinado = busqueda_local(mejor_historico, funcion)
        valor_refinado = funcion(mejor_refinado)
        
        if valor_refinado < mejor_valor_historico:
            mejor_historico = mejor_refinado
            mejor_valor_historico = valor_refinado
    
    return mejor_historico, mejor_valor_historico

# Ejecución del algoritmo
if __name__ == "__main__":
    import bisect
    
    print("Buscando el mínimo de la función (x-y)² + (x-y)⁴...")
    mejor_sol, mejor_valor = algoritmo_genetico(funcion1)
    
    print("\nResultado final:")
    print(f"Coordenadas (x, y): {mejor_sol}")
    print(f"Valor de la función: {mejor_valor}")
    print(f"Distancia al óptimo (0,0): {math.sqrt(mejor_sol[0]**2 + mejor_sol[1]**2)}")