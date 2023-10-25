#X vac cantidad de litros que hay en una lata de barniz

#n es grande porque n > 30
n<-64

#media de  barniz por latas es 5.23 litros
media_barniz <- 5.23

#dewsviacion estandar de la muestra
des_est <- 0.24

#significancia 1 - alpha
significancia <- 0.05

#h0 decimos que mu = 5.5

#h1 decimos que mu <= 5.5


#EJER 3
#Pasos
#1) Extraemos la variable a analizar:
#X vac / X:"peso de cereal en la bolsa"
#2)Extraemos los datos que tenemos en el ejercicio

#tamaño muestral
n<-100
#el tamaño es gerande porque n >= 30
#media muestral
media_bolsa<-297
#mu sub 0
mu_0 <- 300
#3)Nos preguntamos si la muestra es muestral o poblacional
#si es poblacional usamos sigma al cuadrado
#si es muestral usamos s al cuadrado
varianza_bolsa <- 16
sd_bolsa <- sqrt(varianza_bolsa)
#significancia 1 - (1 - alpha) 
alpha_bolsa<-0.05
#4) Hacemos los planteos de hipotesis
#media(mu)
#Diferencia de medias(mu1-mu2)
#varianza(sigma al cuadrado)
#Como la hipotesis es para probar la media de llenado si la maquina funciona
#bien o no

#h0
#mu=300 (maquina funciona bien)
#h1
#mu<>300 (maquina no funciona bien)
#como la varianza es conocida usamos la siguiente formula
Zcalc = (media_bolsa-mu_0)/(sd_bolsa/sqrt(n))

#Calculo el p-value dependiendo de mi hipotesis alternativa
p_value_bolsa <- 2*pnorm(abs(Zcalc), lower.tail = FALSE)
p_value_bolsa

# con este valor debemos decidir y luego concluir, comprobar
# p value con alpha
# p_value < alpha -> 0,05 < 6,38 * 10^-4
# por lo tanto RECHAZO la hipotesis NULA
# ENTONCES HAY EVIDENCIA MUESTRA SUFICIENTE PARA AFIRMAR QUE
# EL PESO PROMEDIO ES DISTINTO DE 300gr- (PONEMOS EN PALABRAS LA HIPOTESIS ALTERNATIVA
# POR LO TANTO LA MAQUINA NO FUNCIONA DE FORMA ACEPTALBE

# x v.a.c. representa la cantidad de sodio en porciones individuales
# de un cereal en miligramos
# 1 DATOS
n <- 20
# n es pequeño
media <- 244
var <- 24.5
alpha <- 0.05
t_calc <- (media-220)/(var/sqrt(n))
t_calc

p_value <- pt(t_calc, df=n-1, lower.tail = FALSE)
p_value


#EJER5 PERONISMO
n_autos <- c(2905, 2725, 2835, 3065, 2895, 3005, 2835, 2605)
n_muestra <- 8
s <- sd(n_autos)
media_auto <- mean(n_autos)
tcalc <- (media_auto-3000)/(s/sqrt(n_muestra))
pvalueat <- pt(tcalc, df=7, lower.tail = TRUE)
t.test(n_autos, alternative = "less", mu=3000)

#EJER 6
#X vac / X:"Es el peso del diamante producido sinteticamente en kilates"

m_diamante <-c(0.46,0.61,0.52,0.48,0.54)
n= 6 #n es chico por que es menor a 6
alpha = 0.10
#muestra poblacional desconocida
des_est_diamante <- sd(m_diamante)
#media
media_diamante <- mean(m_diamante)

#planteo
#H0) mu = 0.5
#h1) mu > 0.5
#Estadistica
#Como n es chico  y la poblacion es desconocida utilizamos Tcalc

Tcalc_diamante <- (media_diamante-0.5)/(des_est_diamante/sqrt(n))

#p-value
#Como tenemos un vector y usamos Tcalc, vamos a usar
#t.test

t.test(m_diamante, alternative = "greater", mu=0.5)

#verificamos p-value < alpha
#Como 0.2238 > 0.1 no rechazamos la hipotesis nula
#No hay evidencia muestral suficiente para demostrar que el peso del diamante producido
#sinteticamente sea mayor a 0.5 kilates

#por lo tanto el proceso no funciogsna de manera rentable
