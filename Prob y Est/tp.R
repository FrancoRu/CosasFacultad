#Ejer 1

muestra_a <- c(3, 0, 6, 4, 1, 5, 4, 1)

#media
media <- mean(muestra_a)

#varianza
varianza <- var(muestra_a)

#desvio estandar
des_est <- sd(muestra_a)

media
varianza
des_est

#2

vendedor_1 <- c(3,5,0,-2,3,2)
vendedor_2 <- c(-7,-5,4,0,-4,3)

#media
media_vendedor_1 <- mean(vendedor_1)
media_vendedor_2 <- mean(vendedor_2)
#mediana
mediana_vendedor_1 <- median(vendedor_1)
mediana_vendedor_2 <- median(vendedor_2)

#desvio estandar
des_est_vendedor_1 <- sd(vendedor_1)
des_est_vendedor_2 <- sd(vendedor_2)

#coeficiente de variacion
coef_var_vendedor_1 <- des_est_vendedor_1/media_vendedor_1
coef_var_vendedor_2 <-des_est_vendedor_2/media_vendedor_2

#rango de datos
rango_vendedor_1 <- max(vendedor_1)-min(vendedor_1)
rango_vendedor_2 <- max(vendedor_2)-min(vendedor_2)

print("Datos vendedor 1: ")
media_vendedor_1
mediana_vendedor_1
des_est_vendedor_1
coef_var_vendedor_1
rango_vendedor_1
print("Datos vendedor 2: ")
media_vendedor_2
mediana_vendedor_2
des_est_vendedor_2
coef_var_vendedor_2
rango_vendedor_2

print("El vendedor que tiene un desempeño mas consistente es el vendedor 1 porque el coeficiente de variacion es inferior")

#Ejer 3
#a
muestra_a <- c(47, 43, 42, 40, 38, 36, 33, 33, 33, 32, 32, 32, 27, 27, 26, 22)

#media
media_a <- mean(muestra_a)

#mediana
mediana_a <- median(muestra_a)

#desvio estandar
desv_est_a <- sd(muestra_a)

#coeficiente de variacion
coe_var_a <- desv_est_a/media_a

#Rango
rango_a <- max(muestra_a)-min(muestra_a)

muestra_a
media_a
mediana_a
desv_est_a
coe_var_a
rango_a

#b
muestra_b <- c(38, 36, 33, 33, 33, 32, 32, 32, 27, 27, 26, 22)

#media
media_b <- mean(muestra_b)

#mediana
mediana_b <- median(muestra_b)

#desvio estandar
desv_est_b <- sd(muestra_b)

#coeficiente de variacion
coe_var_b <- desv_est_b/media_b

#Rango
rango_b <- max(muestra_b)-min(muestra_b)

muestra_b
media_b
mediana_b
desv_est_b
coe_var_b
rango_b
#Ejer 4

Almen <- c(14.6, 12.1, 13.8, 15.0, 11.3)
Nuez_Br <- c(10.2, 9.8, 11.0, 11.1, 11.8)
Nuez_In <- c(30.7, 31.4, 34.0, 31.6, 29.1)
Maní <- c(24.3, 26.1, 23.3, 22.5, 27.1)
Avell <- c(20.2, 21.0, 17.9, 19.8, 20.7)

#Calcule la media, la mediana, la variancia, el desvío estándar, el coeficiente de variación y el rango de
#cada uno de los cinco tipos de nuez. ¿Cuál conjunto de mediciones presenta mayor variabilidad?
print("Datos de Almendra")
#datos Almendra
#media
media_Al <- mean(Almen)
#mediana
mediana_Al <- median(Almen)
#varianza
var_Al <- var(Almen)
#desvio estandar
des_est_Al <- sd(Almen)
#coeficiente de variacion
coe_var_Al <- des_est_Al/media_Al
#rango
rango_Al <- max(Almen)-min(Almen)

#resultados
media_Al
mediana_Al
var_Al
des_est_Al
coe_var_Al
rango_Al

print("Datos de Nuez de Brazil")
#datos Nuez de Brazil
#media
media_Br <- mean(Nuez_Br)
#mediana
mediana_Br <- median(Nuez_Br)
#varianza
var_Br <- var(Nuez_Br)
#desvio estandar
des_est_Br <- sd(Nuez_Br)
#coeficiente de variacion
coe_var_Br <- des_est_Br/media_Br
#rango
rango_Br <- max(Nuez_Br)-min(Nuez_Br)

#resultados
media_Br
mediana_Br
var_Br
des_est_Br
coe_var_Br
rango_Br

print("Datos de Nuez de la India")
#datos Nuez de la India
#media
media_In <- mean(Nuez_In)
#mediana
mediana_In <- median(Nuez_In)
#varianza
var_In <- var(Nuez_In)
#desvio estandar
des_est_In <- sd(Nuez_In)
#coeficiente de variacion
coe_var_In <- des_est_In/media_In
#rango
rango_In <- max(Nuez_In)-min(Nuez_In)

#resultados
media_In
mediana_In
var_In
des_est_In
coe_var_In
rango_In

print("Datos de Mani")
#datos Maní
#media
media_Ma <- mean(Maní)
#mediana
mediana_Ma <- median(Maní)
#varianza
var_Ma <- var(Maní)
#desvio estandar
des_est_Ma <- sd(Maní)
#coeficiente de variacion
coe_var_Ma <- des_est_Ma/media_Ma
#rango
rango_Ma <- max(Maní)-min(Maní)

#resultados
media_Ma
mediana_Ma
var_Ma
des_est_Ma
coe_var_Ma
rango_Ma

print("Datos de Avellanas")
#datos Avellanas
#media
media_Av <- mean(Avell)
#mediana
mediana_Av <- median(Avell)
#varianza
var_Av <- var(Avell)
#desvio estandar
des_est_Av <- sd(Avell)
#coeficiente de variacion
coe_var_Av <- des_est_Av/media_Av
#rango
rango_Av <- max(Avell)-min(Avell)

#resultados
media_Av
mediana_Av
var_Av
des_est_Av
coe_var_Av
rango_Av

#La nuez de la india tiene mayor variabilidad

#Ejer 5
autos <- c(2, 2, 3, 4, 0, 3, 5, 2, 1, 0, 3, 5, 4, 0, 1, 2, 3, 1, 1, 2,
           1, 2, 4, 3, 0, 1, 3, 2, 4, 1, 2, 1, 0, 0, 1, 1, 2, 2, 3, 3)

#Determine la media, la mediana, la variancia y el desvío estándar. Interprete la mediana

#media
media <- mean(autos)

#mediana
mediana <- median(autos)

#varianza
varianza <- var(autos)

#desvio estandar
des_est <- sd(autos)

#datos punto a
print("media")
media
print("mediana")
mediana
print("varianza")
varianza
print("desvío estándar")
des_est

#datos punto b
print("distribucion de frecencia relativas")
distribucion <- table(autos)
distribucion

print("distribucion de frecencia absolutas")
distribucion_absoluta <- prop.table(distribucion)
distribucion_absoluta
print("tablas de frecuencia")
barplot(distribucion)
print("tablas de frecuencia absolutas")
barplot(distribucion_absoluta)

#ejer 6

puntuaciones <- c(23,60,79,32,57,74,52,70,82,36,80,77,81,95,41,65,92,85,55,76,52,10,64,75,78,25,80,98,81,67,41,71,83,54,64,72,88,62,74,43,60,78,89,76,84,48,84,90,15,79,34,67,17,82,69,74,63,80,85,61)