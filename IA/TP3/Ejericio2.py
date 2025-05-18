import random
import time
import hashlib
import math

class Ejericio2:
    def __init__(
            self, 
            fn,
            restriccion = None,
            metodo: set = ["ruleta"], 
            tamanio_poblacion: int = 500,  
            rango: list = (-10, 10),
            alpha: float = 0.1, 
            dimension: int = 2,
            modo: str = "min",
            max_generacion: int = 20,
            imprimir_generacion: bool = False
        ) -> None:
        
        timestamp: str = str(time.time()).encode()
        self.seed: str = int(hashlib.sha256(timestamp).hexdigest(), 16) % (10**8)
        self.fn: function = fn
        self.dimension: int = dimension if dimension in (2, 3) else 2
        self.n = tamanio_poblacion
        self.alpha = alpha
        self.modo = modo 
        self.max_generaciones_sin_mejora = max_generacion
        self.restriccion = restriccion
        self.imprimir_generacion = imprimir_generacion
        random.seed(self.seed)

        self.poblacion: list = []

        while len(self.poblacion) < tamanio_poblacion:
           if dimension == 3:
               coordenadas = [round(random.uniform(*rango), 2) for _ in range(3)]
           else:
               coordenadas = [round(random.uniform(*rango), 2) for _ in range(2)]

           if self.restriccion is None or self.restriccion(*coordenadas):
               self.poblacion.append(coordenadas)

        for nombre_metodo in metodo:
            if hasattr(self, nombre_metodo):
                metodo = getattr(self, nombre_metodo)
                if callable(metodo):
                    metodo()  # lo llamamos
                else:
                    print(f"{nombre_metodo} no es un método callable.")
            else:
                print(f"No existe el método {nombre_metodo} en esta clase.")


    def fitness(self, elemento) -> float:
        resultado: float = self.fn(*elemento)

        if self.modo == "min":
            return round(1 / (resultado + 0.00001), 2) 

        elif self.modo == "max":
            return round(resultado, 2)

        raise ValueError("Modo debe ser 'min' o 'max'.")

    def generar_rango(self):
        acum = 0.0
        self.rangos = []
        for prob, individuo in self.probabilidades:
            self.rangos.append((acum, acum + prob, individuo))
            acum += prob

    def buscar_padre_torneo(self):
        seleccionar = random.randint(2, len(self.poblacion))  
        es_maximizacion = self.modo.lower() == 'max'          
        torneo = sorted(
            random.sample(self.poblacion, seleccionar),
            key=self.fitness,
            reverse=es_maximizacion
        )
        return torneo[:2]

    def buscar_padre_ruleta(self):
        seleccionar: float = random.random()
        for inicio, fin, individuo in self.rangos:
            if inicio <= seleccionar < fin:
                return individuo
        return self.rangos[-1][2]

    def cruzar(self, p1, p2):
        while True:
            hijo = []

            for i in range(self.dimension):
                min_i = min(p1[i], p2[i])
                max_i = max(p1[i], p2[i])
                d = max_i - min_i
                lower_bound = min_i - self.alpha * d
                upper_bound = max_i + self.alpha * d
                hijo.append(round(random.uniform(lower_bound, upper_bound), 2))

            if self.restriccion is None or self.restriccion(*hijo):
                return hijo

    def seleccionar_porcentaje_aleatorio(self, hijos):
        cantidad = int(len(hijos) * self.alpha)
        return random.sample(range(len(hijos)), cantidad)
    
    def mutar(self, hijo):
        while True:
            nuevo_hijo = hijo.copy()
            for i in range(self.dimension):
                tasa = self.alpha + random.uniform(0, self.alpha)
                if random.random() < tasa:
                    nuevo_hijo[i] = round(nuevo_hijo[i] + random.gauss(0, 0.5), 2)
            if self.restriccion is None or self.restriccion(*nuevo_hijo):
                return nuevo_hijo
    
    def ruleta(self):
        generaciones_sin_mejora = 0 
        mejor_valor = float('inf') if self.modo == "min" else float('-inf')
        mejor_individuo = None
        generacion = 0  
        while generaciones_sin_mejora < self.max_generaciones_sin_mejora:
            self._fitness = [self.fitness(x) for x in self.poblacion]
            valores = [self.fn(*x) for x in self.poblacion] 
            if self.modo == "min":
                mejor_valor_actual = min(valores)
            else:  # max
                mejor_valor_actual = max(valores)   
            index_mejor = valores.index(mejor_valor_actual)
            mejor_individuo_actual = self.poblacion[index_mejor]    
            if ((self.modo == "min" and mejor_valor_actual < mejor_valor) or
                (self.modo == "max" and mejor_valor_actual > mejor_valor)):
                mejor_valor = mejor_valor_actual
                mejor_individuo = mejor_individuo_actual
                generaciones_sin_mejora = 0
            else:
                generaciones_sin_mejora += 1    
            total_fitness = sum(self._fitness)
            self.probabilidades = [
                (x / total_fitness, self.poblacion[i])
                for i, x in enumerate(self._fitness)
            ]
            self.generar_rango()    
            hijos = []
            for _ in range(self.n):
                p1 = self.buscar_padre_ruleta()
                p2 = self.buscar_padre_ruleta()
                while p1 == p2:
                    p2 = self.buscar_padre_ruleta()
                hijos.append(self.cruzar(p1, p2))   
            mutar = self.seleccionar_porcentaje_aleatorio(hijos=hijos)
            for i in mutar:
                hijos[i] = self.mutar(hijo=hijos[i])    
            self.poblacion = hijos
            generacion += 1
            if self.imprimir_generacion :
                print(f"[RULETA] Generacion: {generacion}")  
        print(f"\n🎯 [RULETA]  {'Mínimo' if self.modo == 'min' else 'Máximo'} alcanzado:")
        print(f"[RULETA] Generación: {generacion}")
        print(f"[RULETA] Mejor valor: {mejor_valor}")
        print(f"[RULETA] Mejor individuo: {mejor_individuo}\n")

    def torneo(self):
        generaciones_sin_mejora = 0 
        mejor_valor = float('inf') if self.modo == "min" else float('-inf')
        mejor_individuo = None
        generacion = 0  
        while generaciones_sin_mejora < self.max_generaciones_sin_mejora:
            self._fitness = [self.fitness(x) for x in self.poblacion]
            valores = [self.fn(*x) for x in self.poblacion] 
            if self.modo == "min":
                mejor_valor_actual = min(valores)
            else:
                mejor_valor_actual = max(valores)   
            index_mejor = valores.index(mejor_valor_actual)
            mejor_individuo_actual = self.poblacion[index_mejor]    
            if ((self.modo == "min" and mejor_valor_actual < mejor_valor) or
                (self.modo == "max" and mejor_valor_actual > mejor_valor)):
                mejor_valor = mejor_valor_actual
                mejor_individuo = mejor_individuo_actual
                generaciones_sin_mejora = 0
            else:
                generaciones_sin_mejora += 1
            hijos = []
            for _ in range(self.n):
                p1, p2 = self.buscar_padre_torneo()
                hijos.append(self.cruzar(p1, p2))   

            mutar = self.seleccionar_porcentaje_aleatorio(hijos=hijos)
            for i in mutar:
                hijos[i] = self.mutar(hijo=hijos[i])    
            self.poblacion = hijos
            generacion += 1
            if self.imprimir_generacion :
                print(f"[TORNEO] Generacion: {generacion}")

        print(f"\n🎯 [TORNEO] {'Mínimo' if self.modo == 'min' else 'Máximo'} alcanzado:")
        print(f"[TORNEO] Generación: {generacion}")
        print(f"[TORNEO] Mejor valor: {mejor_valor}")
        print(f"[TORNEO] Mejor individuo: {mejor_individuo}\n")

def funcion1(x, y):
     return (x - 1)**2 + (x - y)**4

def funcion2(x,y):
    return (2 + math.sqrt(9-(x**2)-(y**2)))

def cumple_restriccion2(x,y):
    return 9 - (x**2) - (y**2) >= 0

def funcion3(x,y,z):
    return z - (x**2)-(15*(y**2))

def cumple_restriccion3(x,y,z):
    return -2 < x < 11 and -2 < y < 11 and -2 < z < 11  

#OTRAS FUNCIONES DE PRUEBA
def himmelblau(x, y):
    # Mínimos globales en aproximadamente:
    # (3.0, 2.0), (-2.805, 3.131), (-3.779, -3.283), (3.584, -1.848)
    return (x**2 + y - 11)**2 + (x + y**2 - 7)**2

def rosenbrock(x, y, a=1, b=100):
    # Mínimo global en (a, a^2), por defecto (1,1)
    return (a - x)**2 + b*(y - x**2)**2

def booth(x, y):
    # Mínimo global en (1, 3) con valor 0
    return (x + 2*y - 7)**2 + (2*x + y - 5)**2

def funcion_maximizacion(x, y):
    """Función de prueba con un máximo en (2, 3)"""
    return -((x - 2)**2 + (y - 3)**2) + 10

#a = Ejericio2(fn=funcion1, dimension=2, max_generacion= 50, metodo=["ruleta", "torneo"])
#b = Ejericio2(fn=funcion2,restriccion=cumple_restriccion2, dimension=2, rango=(-3,3), modo="max", max_generacion= 50, metodo=["ruleta", "torneo"])
c = Ejericio2(fn=funcion3,restriccion=cumple_restriccion3,tamanio_poblacion=2000 ,dimension=3, rango=(-2,11), modo="max", max_generacion= 50, metodo=["ruleta", "torneo"])
 