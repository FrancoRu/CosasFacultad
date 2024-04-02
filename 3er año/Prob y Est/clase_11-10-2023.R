#Ejer 16
#Construya un intervalo de confianza del 90% para el
#cociente de varianzas de los tiempos de duración de las
#películas de los sitios web A y B del ejercicio 13. ¿Es cierto que
#las varianzas poblacionales deben asumirse diferentes?
#Justifique.


#tiempos
dur_A <- c(103,94,110,87,98)
dur_B <- c(97,82,123,92,175,88,118)
coc_var <- var.test(dur_A, dur_B, conf.level = 0.90)$conf.int
coc_var

#como el 1 no pertenece al IC (Intervalo de confianza)
#podemos afirmar con 90% de confianza
#que las VARIANZAS POBLACIONALES son DIFERENTES

#Ejer 14

#x1 v.a.c/x1:  "Ganancia en peso con dieta TRADICIONAL"
#x2 v.a.c/x2:  "Ganancia en peso con dieta NUEVA"

dieta_t <- c(16,24,18,19,22,12,15,16,11,14,25,31)
dieta_n <- c(31,34,29,25,38,34,29,31,32,29,32,28)
#Paso 1:
IC <- var.test(dieta_n, dieta_t, conf.level = 0.94)$conf.int
IC

#Paso 2: mu1 - mu2 
IC2 <- t.test(dieta_n, dieta_t, var.equal = TRUE, conf.level = 0.94)$conf.int
IC2

#Hay diferencia significativas entre las medias ya que el rango
#del intervalo de confianza de las medias es de -16.317804 <= mu1-mu2 <= -8.515529 
#y como el 0 no esta en el intervalo llegamos a la conclusion

#Por lo tanto con un 94% de confianza, podemos afimrar que existe
#diferencia significativa entre las ganancias medias de peso con dieta
#tradicional y nueva, siendo mayor en la dieta nueva, entonces decimos
#que la dieta nueva es mas efectiva

#Ejer 21

#Estimacion de proporcion, no se conoce la real proporcion p
#proporcion muestral = numero de exito / total muestra


#X v.a.d / X = "Cantidad de casas que utilizan el petroleo para calefaccionarse"
#(exito)
x = 228 
#(total)
n = 1000 
#estimacion puntual
proporcion = x/n

#IC para P
IC <- prop.test(x,n, conf.level = 0.99)
IC

#estimacion de proporcion real por IC
#p: 0.1952 <= p <= 0.2644