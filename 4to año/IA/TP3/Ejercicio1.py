import random
import string
import time
import matplotlib.pyplot as plt

# -----------------------------
# Entradas del usuario
# -----------------------------
objetivo_default = "Los algoritmos genéticos sirven para optimizar"
user_input = input(f"\n\tIngrese objetivo o presione Enter para usar el default:\n> ")
objetivo = user_input if user_input.strip() else objetivo_default

print_generaciones = input("¿Desea imprimir cada generación? (s/n): ").lower() == 's'
modo = input("¿Qué algoritmo querés correr? (ruleta(r) / torneo(t) / ambos(a)): ").lower()

# -----------------------------
# Configuración de caracteres
# -----------------------------
spanish_letters = 'áéíóúÁÉÍÓÚñÑ'
chars = ''
if(any(c in string.ascii_letters for c in objetivo)):
    chars += string.ascii_letters + spanish_letters
if(any(c in string.punctuation for c in objetivo)):
    chars += string.punctuation
if(any(c in string.digits for c in objetivo)):
    chars += string.digits
if(' ' in objetivo):
    chars += ' '

# -----------------------------
# Funciones auxiliares
# -----------------------------
def random_char(y):
    return ''.join(random.choice(chars) for _ in range(y))

def fitness(candidato):
    return sum(1 for i in range(len(objetivo)) if candidato[i] == objetivo[i])

def calcular_acumulado(prob):
    acumulado = []
    s = 0
    for p in prob:
        s += p
        acumulado.append(s)
    return acumulado

def calcular_probabilidades(total_fitness, fitness_scores):
    return [f / total_fitness for f in fitness_scores]

def seleccion_ruleta(muestra, acum):
    r = random.random()
    for i, value in enumerate(acum):
        if r <= value:
            return muestra[i]

def mutar(individuo):
    nuevo = ""    
    alpha = random.uniform(0.01, 0.07)
    for c in individuo:
        if random.random() < alpha:
            nuevo += random.choice(chars)
        else:
            nuevo += c
    return nuevo

def verificar_muestra(candidato):
    return fitness(candidato) == (len(objetivo))

def cruzar(p1, p2):
    corte = random.randint(0, len(objetivo) - 1)
    hijo = p1[:corte] + p2[corte:]
    return mutar(hijo)

# -----------------------------
# Algoritmo Torneo
# -----------------------------
def torneo(muestra, n, imprimir_generaciones=False):
    def seleccionar_individuo(muestra):
        k = random.randint(2, 50)
        candidatos = random.sample(muestra, k)
        return max(candidatos, key=fitness)

    generacion = 1
    while True:
        for i in range(n):
            if verificar_muestra(muestra[i]):
                return i, generacion

        nueva_muestra = []
        for _ in range(n):
            p1 = seleccionar_individuo(muestra)
            p2 = seleccionar_individuo(muestra)
            while p1 == p2:
                p2 = seleccionar_individuo(muestra)
            hijo = cruzar(p1, p2)
            nueva_muestra.append(hijo)

        muestra = nueva_muestra

        if imprimir_generaciones:
            mejor = max(muestra, key=fitness)
            print(f"[Torneo] Generación {generacion} - Individuo: {mejor} - Fitness: {fitness(mejor)}")
        generacion += 1

# -----------------------------
# Algoritmo Ruleta
# -----------------------------
def ruleta(muestra, n, imprimir_generaciones=False):
    generacion = 1
    while True:
        for i in range(n):
            if verificar_muestra(muestra[i]):
                return i, generacion

        fitness_scores = [fitness(x) for x in muestra]
        total_fitness = sum(fitness_scores)
        prob = calcular_probabilidades(total_fitness, fitness_scores)
        acum = calcular_acumulado(prob)

        muestra_con_fitness = list(zip(muestra, fitness_scores))
        muestra_con_fitness.sort(key=lambda x: x[1], reverse=True)
        elite = [individuo for individuo, _ in muestra_con_fitness[:5]]

        nueva_muestra = elite.copy()
        while len(nueva_muestra) < n:
            p1 = seleccion_ruleta(muestra, acum)
            p2 = seleccion_ruleta(muestra, acum)
            while p1 == p2:
                p2 = seleccion_ruleta(muestra, acum)
            hijo = cruzar(p1, p2)
            nueva_muestra.append(hijo)

        muestra = nueva_muestra

        if imprimir_generaciones:
            mejor = max(muestra, key=fitness)
            print(f"[Ruleta] Generación {generacion} - Individuo: {mejor} - Fitness: {fitness(mejor)}")
        generacion += 1

# -----------------------------
# Ejecución y Resultados
# -----------------------------
n = random.randint(100, 500)
print(f"\nUsando muestra de tamaño: {n}")
resultados = {}

if modo == "ruleta" or modo == "ambos" or modo == "r" or modo == "a":
    muestra = [random_char(len(objetivo)) for _ in range(n)]
    start = time.time()
    _, generaciones_ruleta = ruleta(muestra, n, print_generaciones)
    end = time.time()
    resultados["Ruleta"] = (generaciones_ruleta, end - start)

if modo == "torneo" or modo == "ambos" or modo == "t" or modo == "a":
    muestra = [random_char(len(objetivo)) for _ in range(n)]
    start = time.time()
    _, generaciones_torneo = torneo(muestra, n, print_generaciones)
    end = time.time()
    resultados["Torneo"] = (generaciones_torneo, end - start)

# -----------------------------
# Mostrar Gráfica Comparativa
# -----------------------------
if len(resultados) > 1:
    labels = list(resultados.keys())
    generaciones = [resultados[k][0] for k in labels]
    tiempos = [resultados[k][1] for k in labels]

    fig, axs = plt.subplots(1, 2, figsize=(12, 5))

    axs[0].bar(labels, generaciones, color='skyblue')
    axs[0].set_title("Generaciones necesarias")
    axs[0].set_ylabel("Cantidad de generaciones")

    axs[1].bar(labels, tiempos, color='lightgreen')
    axs[1].set_title("Tiempo de ejecución")
    axs[1].set_ylabel("Segundos")

    plt.suptitle("Comparativa entre Ruleta y Torneo")
    plt.tight_layout()
    plt.show()
