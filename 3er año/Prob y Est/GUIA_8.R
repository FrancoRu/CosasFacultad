#EJER 1
#Una empresa de material eléctrico fabrica focos cuya
#duración presenta una distribución aproximadamente normal,
#con una desviación estándar de 40 horas. Si una muestra
#aleatoria de 30 focos tiene una duración promedio de 780 horas,
#encuentre un intervalo del 96% de confianza para la media de la
#población de todos los focos que produce la empresa. 

#X v.a.c / X :"Representa la duracion promedio de un foco en horas"

#X ~ N

muestra_focos <- 30
des_est_poblacional_focos <- 40
media_focos <- 780
alpha <- 1-0.96

intervalo_inf_focos <- media_focos - qnorm(alpha/2, lower.tail = FALSE)*des_est_poblacional_focos/sqrt(muestra_focos)
intervalo_sup_focos <- media_focos + qnorm(alpha/2, lower.tail = FALSE)*des_est_poblacional_focos/sqrt(muestra_focos)

#Por lo tanto podemos afirmar con un 96% de confianza que la media poblacional se encuentra entre 765 y 795
#765 < µ < 795

#EJER 2
#Las estaturas de una muestra aleatoria de 50 estudiantes de
#nuestra carrera exhiben una media de 174.5 cm y una
#desviación estándar de 6.9 cm.
#a. Construya un intervalo del 98% de confianza para la estatura
#media de todos los estudiantes de la carrera.
#b. ¿Qué puede afirmar con un 98% de confianza sobre el
#tamaño posible del error de estimación al utilizar la media de
#esta muestra para estimar la media de la población?
#c. Repita el inciso (a) al 90, 95 y 99% de confianza. Calcule el
#error máximo de de estimación en caso.
#d. ¿Qué relación encuentra entre el nivel de confianza y la
#magnitud del error de estimación? 

#X v.a.c. /X :"Estaturo promedio de un estudiante de sistemas en cm" 
muestra_est <- 50
#Se desconoce la media poblacional
media_muestral_est <- 174.5
#Se desconoce la desviacion estandar poblacional
des_est_muestral <- 6.9

#punto a:
alpha_est <- 1-0.98
intervalo_inf_est<- media_muestral_est - qnorm(alpha_est/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
intervalo_sup_est <- media_muestral_est + qnorm(alpha_est/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
#por lo tanto podemos afirmar con un 98% de confianza que la media poblacional esta entre el siguiente intervalo:
#172.23 < µ < 176.77

#punto b:
err_est_punto2 <- qnorm(alpha_est/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
#El error estimado es de 2.27

#punto c:


alpha_est_2c1 <- 1-0.90
intervalo_inf_est<- media_muestral_est - qnorm(alpha_est_2c1/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
intervalo_sup_est <- media_muestral_est + qnorm(alpha_est_2c1/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)

err_est_punto2c1 <- qnorm(alpha_est_2c1/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
#por lo tanto podemos afirmar con un 98% de confianza que la media poblacional esta entre el siguiente intervalo:
#172.89 < µ < 176.10
#Con un error de 1.60

alpha_est_2c2 <- 1-0.95
intervalo_inf_est<- media_muestral_est - qnorm(alpha_est_2c2/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
intervalo_sup_est <- media_muestral_est + qnorm(alpha_est_2c2/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)

err_est_punto2c2 <- qnorm(alpha_est_2c2/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
#por lo tanto podemos afirmar con un 98% de confianza que la media poblacional esta entre el siguiente intervalo:
#172.59 < µ < 176.41
#Con un error de 1.91

alpha_est_2c3 <- 1-0.99
intervalo_inf_est<- media_muestral_est - qnorm(alpha_est_2c2/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
intervalo_sup_est <- media_muestral_est + qnorm(alpha_est_2c2/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)

err_est_punto2c3 <- qnorm(alpha_est_2c3/2, lower.tail = FALSE)*des_est_muestral/sqrt(muestra_est)
#por lo tanto podemos afirmar con un 98% de confianza que la media poblacional esta entre el siguiente intervalo:
#172.59 < µ < 176.41
#Con un error de 2.51

#Podemos observar, que caunto mayor el niuvel de confianza, mayor es el nivel del error

#EJER 3

#Una muestra aleatoria de 100 propietarios de autos muestra
#que, en Paraná, un auto se maneja, en promedio, 23500 km al
#año con una desviación estándar de 3900 km.
#a. Construya un intervalo del 99% de confianza para la cantidad
#promedio recorrida en automóvil por los conductores de Paraná
#anualmente.
#b. ¿Qué puede afirmar con un 99% de confianza acerca del
#tamaño posible del error de estimación cometido al utilizar esta
#muestra? 

#X v.a.c / X: "Representa la cantaidad de km recorridos por un auto de Parana en un año"

n <- 100
media_muestral <- 23500
des_est_muestral <- 3900
alpha <- 1-0.99

#media poblacional y desvio estandar pobalcional desconocidos
#el n es mayor a 30 por lo tanto es grande

int_inf <- media_muestral - qnorm(alpha/2, lower.tail = FALSE)*des_est_muestral/sqrt(n)
int_sup <- media_muestral + qnorm(alpha/2, lower.tail = FALSE)*des_est_muestral/sqrt(n)

#por lo tanto podemos afirmar con un 98% de confianza que la media poblacional esta entre el siguiente intervalo:
#22495.43 < µ < 24504.57

error_est <- qnorm(alpha/2, lower.tail = FALSE)*des_est_muestral/sqrt(n)
# el valor real de la media poblacional podría diferir en hasta 1004.57 kilómetros de la estimación basada en esta muestra.

#EJER 4

#¿De qué tamaño se necesita la muestra en el ejercicio 1 si
#se desea tener un 96% de confianza de que la media muestral
#diste de la media real en a lo sumo 10 horas? 

error_est = 10
alpha = 1 - 0.96
sd = 40
n = (qnorm(alpha/2,lower.tail=FALSE)*sd/error_est)^2

#Por lo tanto para que haya un error de 10 horas con una confianza del 96%
#el tamaño de muestra de focos deberia ser de 68

#EJER 5

#Un experto en eficiencia desea determinar el tiempo
#promedio que toma perforar una cierta placa metálica.
#a. ¿De qué tamaño se necesita una muestra para tener 95% de
#confianza de que la media de la muestra esté dentro de 12
#segundos de la media real? Suponga que por estudios previos
#se sabe que el desvío estándar de la variable aleatoria
#considerada en la población es de 40 segundos.
#b. Repita el inciso anterior contemplando que el error máximo de
#estimación debe disminuir a la mitad. 


#X v.a.c / X: "Representa el tiempo que se toma en perforar cierta placa metalica en segundos"

#punto a
alpha = 1-0.95
error_est = 12
des_est = 40
n = (qnorm(alpha/2,lower.tail=FALSE)*des_est/error_est)^2

#Por lo tanto el tamaño de la muestra para que el error este entre los 12 segundos de la media real
#y con una confianza del 95% es de 43 segundos

#punto b
alpha = 1-0.95
error_est = 12/2
des_est = 40
n = (qnorm(alpha/2,lower.tail=FALSE)*des_est/error_est)^2
#Por lo tanto el tamaño de la muestra para que el error este entre los 6 segundos de la media real
#y con una confianza del 95% es de 171 segundos

#EJER 6
#En una muestra aleatoria de 20 barras de cereales similares,
#de la misma marca y variedad, el contenido promedio de azúcar
#fue de 11.3 gramos con una desviación estándar de 2.45
#gramos. Suponiendo que el contenido de azúcar está distribuido
#normalmente, construya un intervalo del 95% de confianza para
#el contenido medio de azúcar para barras de esta marca y
#variedad

#X v.a.c / X:"Representa el contenido, en mg, de azucar de una barra de cereal dada"

n = 20
media = 11.3
des_est = 2.45
alpha = 1 - 0.95

#Como la media poblacional es desconocida y ademans el n es pequeño (n < 30) usaremos t de student

int_inf = media - qt(alpha/2, df= n -1, lower.tail = FALSE)*des_est/sqrt(n)
int_sup = media + qt(alpha/2, df= n -1, lower.tail = FALSE)*des_est/sqrt(n)

#Por lo tanto, podemos afirmar con un 95% de confianza que la media poblacional
#del contenido de azucar en las barras se encuentra entre:
# 10.15 < µ < 12.45 

#EJER 7
#Una máquina produce piezas metálicas de forma cilíndrica.
#Se toma una muestra de los diámetros de las piezas
#obteniendo: 1.01, 0.97, 1.03, 1.04, 0.99, 0.98, 0.99, 1.01 y 1.03
#cm. Determine un intervalo de confianza del 99% para el
#diámetro medio de las piezas producidas por esta máquina.
#Suponga una distribución aproximadamente normal en los
#diámetros.

#X v.a.c / X:"Representa el diamentro promedio en cm de una pieza metalica dada"

muestra = c(1.01, 0.97, 1.03, 1.04, 0.99, 0.98, 0.99, 1.01 , 1.03)
n = 9

#Como la muestra es chica, la varianza poblacional desconocida y la población normal, utilizaremos la T
#de Student. 

t.test(muestra, conf.level= 0.99)$conf.int

#Por lo tanto podemos afirmar con un 99% de confianza que el diametro medio
#entre las piezas metalicas producidas se encruentra entre:
#0.98 < µ < 1.03 cm

#EJER 8
#Se registran las siguientes mediciones del tiempo de secado, en
#horas, de cierta marca de pintura vinílica:
#  3.4 2.5 4.8 2.9 3.6 2.8 3.3 5.6
#  4.4 4.0 5.2 3.0 4.8 3.7 2.8
#Suponga que las mediciones representan una muestra aleatoria de
#una población normal y con base en esto calcule un intervalo de
#confianza del 95% para el tiempo medio de secado de dicha pintura.

#X v.a.c / X: "Representa el timepo de secado en horas de una pintura vinilica dada"

n = 15
muestra = c(3.4, 2.5, 4.8, 2.9, 3.6, 2.8, 3.3, 5.6, 4.4, 4.0, 5.2, 3.0, 4.8, 3.7, 2.8)
#Como la muestra es chica, la varianza poblacional desconocida y la población normal, utilizaremos la T
#de Student.
t.test(muestra, conf.level=0.95)$conf.int

#Por lo tanto podemos afirmar con un 95% de confianza que el tiempo medio
#de secado entre el tipo de pintura vinilica es:
#3.25 < µ < 4.32 hr 

#EJER 9
#Se ha extraído una muestra aleatoria de 12 graduados de la
#carrera de Analista en Sistemas, quienes teclearon un promedio de
#79.3 caracteres por minuto, con una desviación estándar de 7.8
#caracteres por minuto. Bajo el supuesto de distribución normal para el
#número de caracteres tipeados por minuto, encuentre un intervalo del
#95% de confianza para la cantidad media de caracteres tecleados en
#un minuto por todos los graduados de esta carrera. 

#X v.a.c / X:"Representa la cantidad de caracteres tecleado por un graduada de la carrera de analisis de sistemas"

n = 12
media = 79.3
des_est = 7.8
alpha = 1 - 0.95

int_inf = media - qt(alpha/2, df= n -1, lower.tail = FALSE)*des_est/sqrt(n)
int_sup = media + qt(alpha/2, df= n -1, lower.tail = FALSE)*des_est/sqrt(n)

#Por lo tanto, podemos afirmar con un 95% de confianza que la media poblacional
#de la cantidad de caracteres tecleados por un estudiante de la carrera de analisis de sistemas se encuentra entre:
# 74.34 < µ < 84.26 

#EJER 10 ANULADO
#EJER 11 ANULADO

#EJER 12
#Se considera usar dos marcas diferentes de pintura látex. El
#tiempo de secado, en horas, se mide en 15 pequeñas muestras de
#uso de cada una de las dos pinturas. Los tiempo de secado obtenidos
#son los siguientes:
#  - Látex Alba: 3.5, 2.7, 3.9, 4.2, 3.6, 2.7, 3.3, 5.2, 4.2, 2.9, 4.4, 5.2,
#     4.0, 4.1, 3.4.
#  -Látex Nogopaint: 4.7, 3.9, 4.5, 5.5, 4.0, 5.3, 4.3, 6.0, 5.2, 3.7, 5.5,
#     6.2, 5.1, 5.4, 4.8.
#Suponga que los tiempos de secado en ambas marcas siguen
#distribuciones normales con variancias iguales. Encuentre un
#intervalo del 95% de confianza para la diferencia de tiempos
#promedios de secado entre Nogopaint y Alba. ¿Qué marca de
#látex brinda tiempo secado más rápido? 
  
#X1 v.a.c / X1:"Representa el tiempo de secado en horas de la pintura Alba"
#X2 v.a.c / X2:"Representa el tiempo de secado en horas de la pintura Nogopaint"

n = 15
muestr_a = c(3.5, 2.7, 3.9, 4.2, 3.6, 2.7, 3.3, 5.2, 4.2, 2.9, 4.4, 5.2, 4.0, 4.1, 3.4)
muestr_b = c(4.7, 3.9, 4.5, 5.5, 4.0, 5.3, 4.3, 6.0, 5.2, 3.7, 5.5, 6.2, 5.1, 5.4, 4.8)

#Como el n es pequeño y la varianza poblacional desconocida usamos t.test
#tambien como no se menciona si las muestras son iguales debemos verificar con var.test
#si el 1 esta en el intervalo como resultado se dice que no haya diferencia significativa entre las medias
 
var.test(muestr_a, muestr_b, conf.level = 0.95)

#Como el intervalo contiene al 1 (0.3588543 3.1837492) entonces decimos que no hay diferencia 
#significativa entre las medias

t.test(muestr_a, muestr_b, var.equal = TRUE, conf.level=0.95)$conf.int

#Con un 95% de confianza podemos concluir que existe diferencia
#significativa entre las medias (ya que 0∉IC) y que el tiempo de secado
#de la pintura nogopaint es mayor que la de alba
#ya que -1.69 < µ1 - µ2 < -0.55 ya que al intervalo ser negativo indica que la segunda media es mas grande

#EJER 13
# Los siguientes datos representan los tiempos de duración de
#muestras de distintas películas disponibles en dos sitios web.
#Website Duración (minutos)
#A 103, 94, 110, 87, 98
#B 97, 82, 123, 92, 175, 88, 118
#Determine un intervalo de confianza del 90% para la diferencia
#entre las duraciones promedios de las películas disponibles en los
#sitios web tomados. Suponga que los tiempos de duración se
#distribuyen de forma aproximadamente normal con variancias
#diferentes. ¿Considera que hay diferencias significativas en los
#tiempos de duración promedio de las películas de cada sitio?

#X1 v.a.c / X1:"Representa el tiempo de duracion de peliculas en el sitio B"
#X2 v.a.c / X2:"Representa el tiempo de duracion de peliculas en el sitio A"

n_a = 7
n_b = 5
muestra_b = c(97,82,123,92,175,88,118)
muestra_a = c(103,94,110,87,98)

#como el n es pequeño y las variables poblaicones son desconocidas
#se utilizara t de student

var.test(muestra_b, muestra_a, conf.leve=0.90)
#Como el intervalo no contiene al 1 (2.202895 61.552523) entonces decimos hay diferencia 
#significativa entre las medias

t.test(muestra_b, muestra_a, var.equal = FALSE, conf.level = 0.90)$conf.int
#-11.80 < 𝜇1 − 𝜇2 < 36.43 Con un 90% de confianza podemos concluir que no existe
#diferencia significativa entre las medias (ya que 0𝜖IC) de los tiempos de duración de las películas en
#sitios web A y B. 

#EJER 14
#Se quiere probar la efectividad de una dieta nueva para
#lograr ganancia en el peso del ganado porcino. A 24 cerdos de
#pesos similares se los asigna aleatoriamente a dos grupos: a la
#mitad se le suministra la dieta tradicional y a la otra mitad la
#dieta nueva. Las ganancias en peso (kg) luego de un tiempo
#prudencial fueron las siguientes:
#Dieta tradiciona (16,24,18,19,22,12,15,16,11,14,25,31)
#Nueva Dieta (31,34,29,25,38,34,29,31,32,29,32,28)
#Asumiendo poblaciones normales brinde un intervalo del 94%
#de confianza para la diferencia entre los pesos promedios de los
#cerdos con la dieta tradicional y la nueva, averiguando
#previamente si las varianzas poblacionales pueden asumirse
#iguales o no. Concluya si la dieta es efectiva o no. 

#X1 v.a.c. / X1: "Representa el peso en kg de la dieta tradicional"
#X2 v.a.c. / X2: "Representa el peso en kg de la dieta nueva"

n = 12
muestra_a = c(16,24,18,19,22,12,15,16,11,14,25,31)
muestra_b = c(31,34,29,25,38,34,29,31,32,29,32,28)

#Como los n son pequeños y la varianza poblacional es desconocida usamos t.test
#pero antes debemos observar si hay diferencia significativa entre las medias

var.test(muestra_a, muestra_b, conf.level = 0.95)
#Como el intervalo 0.8794355 10.6117830 contiene al 1, entonces decimos
#que no existe diferencia significativa entre las varianzas poblacionales

t.test(muestra_a, muestra_b, var.equal = TRUE, conf.level=0.95)$conf.int
#-16.50 < 𝜇1 − 𝜇2 < -8.33 Con un 95% de confianza podemos concluir que existe
#diferencia significativa entre las medias ya que el 0 no pertenece al IC del 
#peso en kg de los cerdos alimentados con las distintas medias

#Como ambos intervalos son negativos, ensto quiere decir que la media
#poblacional de la nueva dieta es mayor, por ende es efectiva

#EJER 15
#Se afirma que la resistencia del alambre A es mayor que la
#del alambre B. Un experimento sobre los alambres muestra los
#siguientes resultados (en ohms):
#- Alambre A: 0.140, 0.138, 0.143, 0.142, 0.144, 0.137.
#- Alambre B: 0.135, 0.140, 0.136, 0.142, 0.138, 0.140.
#¿Qué conclusiones extrae? Justifique su respuesta obteniendo
#un intervalo del 95% confianza adecuado para la diferencia de
#resistencias promedios reales de los dos tipos de alambre,
#averiguando previamente si las varianzas poblacionales pueden
#asumirse iguales o no. 

#X1 v.a.c.: Resistencia del alambre A (ohms)
#X2 v.a.c.: Resistencia del alambre B (ohms)

n = 6
muestra_a = c(0.140, 0.138, 0.143, 0.142, 0.144, 0.137)
muestra_b = c(0.135, 0.140, 0.136, 0.142, 0.138, 0.140)

#como el n es chico, y las varianzas poblacionales desconocidos susamos t.tes y var.test

var.test(muestra_a, muestra_b, conf.level = 0.95)
# Como el 1 esta en el intervalo 0.1550409 < µ1 - µ2 < 7.9180569 , entonces decimos
#que no existe diferencia significativa entre las varianzas poblacionales

t.test(muestra_a, muestra_b, var.equal = TRUE, conf.level = 0.95)$conf.int
#com el 0 esta en el intervalo -0.001352414 < µ1 - µ2 <  0.005685747 entonces decimos que no hay diferencia significativa
#entre las medias

#EJER16
#Construya un intervalo de confianza del 90% para el
#cociente de varianzas de los tiempos de duración de las
#películas de los sitios web A y B del ejercicio 13. ¿Es cierto que
#las varianzas poblacionales deben asumirse diferentes?
#Justifique.

#X1 v.a.c / X1:"Representa el tiempo de duracion de peliculas en el sitio B"
#X2 v.a.c / X2:"Representa el tiempo de duracion de peliculas en el sitio A"

n_a = 7
n_b = 5
muestra_b = c(97,82,123,92,175,88,118)
muestra_a = c(103,94,110,87,98)

#como el n es pequeño y las variables poblaicones son desconocidas
#se utilizara t de student

var.test(muestra_a, muestra_b, conf.leve=0.90)$conf.int
#Como el intervalo no contiene al 1 0.01624629 0.45394809 entonces decimos hay diferencia 
#significativa entre las medias


v
