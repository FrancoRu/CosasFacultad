#EJER 1
#Una muestra aleatoria de 64 latas de barniz muestran un
#contenido promedio de 5.23 litros con una desviación estándar
#de 0.24 litros. ¿Los datos recabados permiten afirmar que las
#latas contienen menos del contenido publicitado de 5.5 litros?
#Emplee una significancia del 5%.

#X v.a.c / X:"Representa el  contenido de barniz de una lata"

n = 64
media = 5.23
sd = 0.24
alpha = 5
mu0 = 5.5

#Plante
#H0 µ = 5.5
#H1 µ < 5.5

#La varianza poblacional es descnocida usamos Zcalc
#Calculo estadistico
Zcalc = (5.23-5.5)/(0.24/sqrt(n))

#p-value
#Como la hipotesis que queremos probar es saber si µ<µ0 entonces usamos
#pnorm

pnorm(Zcalc, lower.tail = TRUE)

#p-value = 1.128588 * 10^-19

#Desicion
#Como p-value es < alpha entonces rechazamos la hipotesis nula
#Conclusion
#Concluimos que esxiste evidencia muestral sufieciente para demostrar que el contenido de 
#barniz en la lata es menoir a 5.5 litros

#
#EJER 2
#En un informe de investigación de la Universidad de
#Medicina, se afirma que los ratones con una vida promedio de
#32 meses vivirían más de 40 meses de edad con una dieta en
#la que el 40% de las calorías se reemplazan con vitaminas y
#proteínas. ¿Hay alguna razón para creer que lo afirmado es
#cierto, si 64 ratones sometidos a esa dieta tuvieron una vida
#promedio de 38 meses con una desviación estándar de 5.8
#meses? ¿Qué tipo de error podría cometer en su conclusión?

#X v.a.c / X: "Representa la videa en meses de un raton que obtuvo 
#una dieta con proteinas y vitaminas"
#DATOS
n= 64
media = 38
sd = 5.8
alpha = 0.05
µ0 = 40
#PLANTEO
#H0: µ = µ0 = µ = 40
#H1: µ > µ0 = µ > 40

#Calculo estadisctico
Zcalc = (media-µ0)/(sd/sqrt(n))

#p-value

pnorm(Zcalc, lower.tail = FALSE)

#Como p-value: 0.9970977

#Desicion

#Como el p-value > alpha , no rechazamos la Hipotesis nula y podriamos cometer
#un error de tipo II

#conclusion

#No hay evidencia muestral sufieciente para afirmar que la la vida en meses de un raton que
#obtuvo una dieta rica en vitaminas y proteinas sea mayor a 40 meses

#EJER 3
#Una máquina de llenado está diseñada para llenar bolsas
#con 300 g de cereales. Con el objeto de comprobar el buen
#funcionamiento de la misma se eligen al azar 100 bolsas
#llenadas en un día y se pesa su contenido. El valor de la
#media muestral es de 297 gramos.
#Suponiendo que la variable peso tiene una distribución normal
#con varianza 16, ¿es aceptable el funcionamiento de la
#máquina al nivel 0,05 de significancia?

#X v.a.c / X:"El peso de una bolsa de cereal en gramos"
#DATOS

n=100
µ0 = 300
media = 297
var = 16
alpha = 0.05
#La varianza y la media pobalcional desconocida

#Planteo
#H0: µ = µ0 -> µ = 300
#H1: µ <> µ0 -> µ <> 300

#Estadisitco de prueba

Zcalc = (media - µ0)/(sqrt(var)/sqrt(n))

#p-value
#Como la hipotesis a probar es que µ es distinto a µ0 entonces usamos:
2*pnorm(abs(Zcalc), lower.tail = FALSE)
#P-VALUES = 6.381783*10^-14

#Desicion:
#Como p-value < alpha entonces rechazamos la hipotesis nula 
#y podemos tener un error de tipo I

#COnclusion:
#Hay evidencia muestral suficiente para afirmar que el peso de las bolsas
#es distinto a 300 gramos
 
#Por lo tanto la maquina funciona mal


#EJER8
#Los siguientes datos representan los tiempos de duración de
#muestras de distintas películas disponibles en dos sitios web.
# A-> 103,94,110,87,98
# B-> 97,82,123,92,175,88,118
#Pruebe la hipótesis de que el tiempo de duración promedio de las
#películas disponibles en el sitio web B excede el tiempo promedio
#de duración de las películas disponibles en el sitio web A en
#menos de 10 minutos. ¿Qué tipo de error podría cometer en su
#conclusión?

#X1 v.a.c / X1: Representa la duracion en minutos de las peliculas en el sitio B
#X2 v.a.c / X2: Representa la duracion en minutos de las peliculas en el sitio A

sitio_a = c(103,94,110,87,98)
sitio_b = c(97,82,123,92,175,88,118)
µ0 = 10

#Planteo
#H0 : µ1 - µ2 = 10
#H1 : µ1 - µ2 < 10

#Resolvemos directamente con t.test

var.test(sitio_b, sitio_a, conf.level = 0.95)$conf.int
#las varianzas son diferentes ya que el intervalo no contiene al 1

t.test(sitio_b, sitio_a, var.equal = FALSE, alternative = "less", µ0)

#Como el p-value = 0.5694 y el alpha es : 0.05
# y p-value > alpha entonces no rechazamos la hipotesis nula


#Conclusion
#No existe evidencia muesttral sufieciente para afirmar que el tiempo promedio en minutos
#de las peliculas en el sitio B sea mayor en menos de 10 que el sitio A
#podriamos cometer un error de tiop II


#9
# Para indagar si un nuevo suero frena el desarrollo de la leucemia,
#se seleccionan 9 ratones, todos con una etapa avanzada de la
#enfermedad de los cuales 5 reciben el tratamiento y los demás no.
#Los tiempos de supervivencia, en años, a partir del momento en
#comienza la experiencia son los siguientes:
#  Con tratamiento: 2.1, 5.3, 1.4, 4.6, 0.9
#  Sin tratamiento: 1.9, 0.5, 2.8, 3,1
#  ¿Se puede afirmar con un nivel de significancia de 0.05 que el suero
#es efectivo? ¿Qué tipo de error podría estar cometiendo con su
#afirmación? Asuma poblaciones normales con variancias iguales.


#X1: v.a.c / X1:"Representa el tiempo en vida en años de un raton que recibio un tratamiento"
#X2: v.a.c / X2:"Representa el tiempo en vida en años de un raton sin tratamiento"

muestra_a = c(2.1, 5.3, 1.4, 4.6, 0.9)
muestra_b = c(1.9, 0.5, 2.8, 3.1)
#planteo
#H0: µ1-µ2 = 0
#H1: µ1-µ2 > 0

#Como el n es pequeño y la varianza es desconocido usamos t de student

t.test(muestra_a, 
       muestra_b, 
       var.equal = TRUE, 
       alternative = "greater", 
       mu=0)

#Como el p-value es mayor que el alpha entonces no rechazamos la hipotesis
#nula y podemos cometer un error de tipo II

#Conclusion
#No existe evidencia muestral suficiente para afirmar que el tiempo de vida en años de los
#ratones que recibieron el tratamiento, sea mayor que el tiempo de vida en años
#de los ratones que no lo recibieron

#10
#En un estudio realizado por la Universidad de Cambridge se
#solicitó a un grupo de sujetos realizar cierta tarea en la computadora.
#La respuesta que se midió fue el tiempo requerido para realizar la
#tarea. El propósito del experimento fue probar un grupo de
#herramientas de ayuda desarolladas por el Departamento de
#Ciencias Computacionales de la universidad. En el estudio
#participaron un grupo de 10 sujetos. Con una asignación al azar, a la
#mitad de ellos se les dio un procedimiento estándar usando lenguaje
#Fortran para realizar la tarea. A los demás se les pidió realizar la
#tarea usando las herramientas de ayuda. A continuación, se
#presentan los datos del tiempo requerido para completar la tarea
#Grupo1-> 161,169,174,158,163
#Grupo2->132,162,134,138,133
#Suponga que las distribuciones de la población son normales y las
#varianzas son las mismas para los dos grupos, y apoye o refute la
#conjetura de que las herramientas de ayuda aumentan la velocidad
#n que se realiza la tarea, utilizando una significancia del 2%. ¿Qué
#tipo de error podría cometer en su conclusión?


#X1 v.a.c / X1: "Representa el tiempo utilizado para realizar la tarea usando foltran"
#X2 v.a.c / X2: "Representa el tiempo utilizado para realizar la tarea usando las herramientas de ayuda"
grupo1 = c(161,169,174,158,163)
grupo2 = c(132,162,134,138,133)

#Planteo
#H0: µ1-µ2 = 0
#H1: µ1-µ2 > 0 
#Como el n es chico y la varianza poblacional es desconocida usaremos t de student
var.test(grupo1, grupo2, conf.level= 0.98)$conf.int
#como el 1 esta incluido en el intervalo, entonces las varianzas son iguales

t.test(grupo1,
       grupo2,
       var.equal = TRUE,
       alternative = "greater",
       mu=0)

#Como p-value es menor a alpha entonces rechazamos la hipotesis nula
#y podriamos incurrir en un error de tipo 

#Conclusion:
#Hay evidencia muestral suficiente para afirmar que el tiempo utilizado para
#completar las tareas dadas usando las herramientas de ayuda, es menor al tiempo
#utilizado , para resolver las mismas usando foltran
