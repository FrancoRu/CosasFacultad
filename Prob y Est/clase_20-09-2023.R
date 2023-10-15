#1
#X v.a.c / X: "duracion de los focos (hr)"
#Estimacion de la media poblacional µ (mu) no se va a conocer nunca
#trabajamos con una muestra n(n minuscula)

#Datos
#muestra al azar
#n <- 30

#media muestral x con complemento
#x <- 780

#Desviancion estadar es poblacion es σ
#σ <- 40

#Intervalo de ocnfianza al 96% para µ
#Estiacion del intervalo de confianza para la media al nivel de confianza de 1-alpha
#Formula media + - Z de alpha/2 * σ / raiz cuadrada de n

#  1-alpha = 0,96 => alpha => 0,04

#Resolucion
media = 780
n = 30
sd = 40
alpha = 0.04

int_inf = media - qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
int_sup = media + qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)

#--------------------------------------------------------------------------------
#2
#X v.a.c / X:"Estatura de estudiantes medida en centrimetros"
#tamaño de muestra
n = 50
#media muestral
media = 174.5
#Desviacion estandar muestral
sd = 6.9
#alpha
alpha = 1-0.98
#Intervalo de frecuencia
#Punto a
int_inf = media - qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
int_sup = media + qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#Intervalo decimos que esta entre 172.22 <= mu <= 176.77
#punto b

err_max_est = qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#error maximo de estimacion es 2.27

#Si solo poseo el intervalo de frecuencia hacemos (Ls - Li)/2
err_max_est2 = (int_sup - int_inf) / 2
#error maximo de estimacion es 2.27

#Si tengo el limite superior y la media hacemos Ls - media
err_max_est3 = int_sup - media

#Si tengo el error y la media hago media+error = Ls y media - error = Li

#punto c
#alpha
alpha = 1-0.90
#Intervalo de frecuencia
int_inf = media - qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
int_sup = media + qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#Intervalo decimos que esta entre 172.89 <= mu <= 176.1

#error maximo de estimacion
err_max_est = qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#error maximo de estimacion es 1.6

#Si solo poseo el intervalo de frecuencia hacemos (Ls - Li)/2
err_max_est2 = (int_sup - int_inf) / 2
#error maximo de estimacion es 1.6

#Si tengo el limite superior y la media hacemos Ls - media
err_max_est3 = int_sup - media
#error maximo de estimacion es 1.6

#alpha al 95
alpha = 1-0.95
#Intervalo de frecuencia
int_inf = media - qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
int_sup = media + qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#Intervalo decimos que esta entre 172.58 <= mu <= 176.41

err_max_est = qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#error maximo de estimacion es 1.91

#Si solo poseo el intervalo de frecuencia hacemos (Ls - Li)/2
err_max_est2 = (int_sup - int_inf) / 2
#error maximo de estimacion es 1.91

#Si tengo el limite superior y la media hacemos Ls - media
err_max_est3 = int_sup - media
#error maximo de estimacion es 1.91

#alpha
alpha = 1-0.99
#Intervalo de frecuencia
int_inf = media - qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
int_sup = media + qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#Intervalo decimos que esta entre 171.98 <= mu <= 177.01

err_max_est = qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#error maximo de estimacion es 2.51

#Si solo poseo el intervalo de frecuencia hacemos (Ls - Li)/2
err_max_est2 = (int_sup - int_inf) / 2
#error maximo de estimacion es 2.51

#Si tengo el limite superior y la media hacemos Ls - media
err_max_est3 = int_sup - media
#error maximo de estimacion es 2.51

#punto d
#Se concluye que, cuando mayor sea el nivel de confianza de las muestras,
#alto es el error, ya que cuanto mas confio, mas errores excluyo, por lo
#tanto es mayor la probabilidad del error

#3
#X v.a.d / X: "cantidad de kilometros al año"

#Tamaño de la muestra
n = 100
#media
media = 23500
#Desviacion estandar
sd = 3900
#alpha
alpha = 1-0.99

#Intervalo de frecuencia
int_sup = media + qnorm(alpha/2, lower.tail = FALSE)*sd/sqrt(n)
int_inf = media - qnorm(alpha/2, lower.tail = FALSE)*sd/sqrt(n)
#intervalo de frecuencia decimos que 22495.42< mu < 24504.57

#Error de estimacion
err_max_est = qnorm(alpha/2, lower.tail=FALSE)*sd/sqrt(n)
#error maximo de estimacion es 1004.57

#Si solo poseo el intervalo de frecuencia hacemos (Ls - Li)/2
err_max_est2 = (int_sup - int_inf) / 2
#error maximo de estimacion es 1004.57

#Si tengo el limite superior y la media hacemos Ls - media
err_max_est3 = int_sup - media
#error maximo de estimacion es 1004.57
