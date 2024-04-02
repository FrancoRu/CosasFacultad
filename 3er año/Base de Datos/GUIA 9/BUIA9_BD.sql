USE ZOO_GUIA9

CREATE TABLE EMPLEADO(
	legajo INT NOT NULL,
	nombre VARCHAR (50) NOT NULL,
	direccion VARCHAR(250) NOT NULL,
	telefono INT,
	fecha_ingreso DATE NOT NULL,
	CONSTRAINT PK_ID PRIMARY KEY(legajo),
);

CREATE TABLE GUIA(
	id_legajo INT NOT NULL,
	CONSTRAINT PK_GUIA_ID PRIMARY KEY(id_legajo),
	CONSTRAINT FK_GUIA_ID FOREIGN KEY (id_legajo) REFERENCES EMPLEADO(legajo)
);

CREATE TABLE CUIDADOR(
	id_legajo INT NOT NULL,
	CONSTRAINT PK_CUI_ID PRIMARY KEY(id_legajo),
	CONSTRAINT FK_CUI_ID FOREIGN KEY (id_legajo) REFERENCES EMPLEADO(legajo)
);

CREATE TABLE ITINERARIO(
	codigo INT NOT NULL,
	duracion INT NOT NULL,
	longitud INT,
	cant_visitantes INT NOT NULL DEFAULT 0,
	CONSTRAINT PK_ITI_ID PRIMARY KEY(codigo)
);

CREATE TABLE ZONA(
	codigo INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	extension INT NOT NULL DEFAULT 0,
	CONSTRAINT PK_ZON_ID PRIMARY KEY(codigo)
);

CREATE TABLE ESPECIE(
	codigo INT NOT NULL,
	id_zona INT NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	nombre_cientifico VARCHAR(100) NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	CONSTRAINT PK_ESP_ID PRIMARY KEY(codigo),
	CONSTRAINT FK_ESP_ID FOREIGN KEY(id_zona) REFERENCES ZONA(codigo)
);

CREATE TABLE CUIDADOR_ESPECIE(
	id_legajo INT NOT NULL,
	id_especie INT NOT NULL,
	fecha_desde DATE NOT NULL DEFAULT GETDATE(),
	PRIMARY KEY(id_legajo, id_especie),
	CONSTRAINT FK_ID_leg FOREIGN KEY (id_legajo) REFERENCES EMPLEADO(legajo),
	CONSTRAINT FK_ID_esp FOREIGN KEY (id_especie) REFERENCES ESPECIE(codigo)
);

CREATE TABLE ITINERARIO_ZONA(
    id_itinerario INT NOT NULL,
    id_zona INT NOT NULL,
	PRIMARY KEY(id_itinerario, id_zona),
    CONSTRAINT FK_ITINERARIO FOREIGN KEY (id_itinerario) REFERENCES ITINERARIO(codigo),
    CONSTRAINT FK_ZONA FOREIGN KEY (id_zona) REFERENCES ZONA(codigo)
);

CREATE TABLE GUIA_ITINERARIO(
	id_legajo INT NOT NULL,
	id_itinerario INT NOT NULL,
	hora TIME NOT NULL DEFAULT('00:00:00'),
	PRIMARY KEY(id_itinerario, id_legajo),
    CONSTRAINT FK_ITINERARIO_ID FOREIGN KEY (id_itinerario) REFERENCES ITINERARIO(codigo),
    CONSTRAINT FK_ZONA_ID FOREIGN KEY (id_legajo) REFERENCES GUIA(id_legajo)
);
--Actividades

--1. Listado completo de especies.

SELECT ZO.nombre AS ZONA, ESPECIE.nombre, nombre_cientifico FROM ESPECIE 
JOIN ZONA ZO
ON ZO.codigo = ESPECIE.id_zona;

--2. Listado de especies ubicadas en una zona dada.

SELECT ES.nombre, ES.nombre_cientifico FROM ESPECIE ES
JOIN ZONA ZO
ON ES.id_zona = (SELECT codigo FROM ZONA WHERE nombre = 'Zona A');

--3. Nombre y teléfono de los cuidadores a cargo de una especie dada.

SELECT E.nombre, E.telefono
FROM EMPLEADO E
JOIN CUIDADOR C ON E.legajo = C.id_legajo
JOIN CUIDADOR_ESPECIE CE ON C.id_legajo = CE.id_legajo
JOIN ESPECIE ES ON CE.id_especie = ES.codigo
WHERE ES.nombre = 'Tigre';

--4. Listado de todos los empleados del parque indicando quienes son guías y quienes
--cuidadores.

SELECT E.nombre, E.legajo, 'GUIA' AS TIPO FROM EMPLEADO E JOIN GUIA G ON G.id_legajo = E.legajo
UNION
SELECT E.nombre , E.legajo , 'CUIDADOR' AS TIPO FROM EMPLEADO E JOIN CUIDADOR C ON C.id_legajo = E.legajo; 

--5. Listado de guías definidos para un itinerario ordenados por hora. 

SELECT E.nombre, GI.hora FROM EMPLEADO E 
JOIN GUIA G
ON G.id_legajo = E.legajo
JOIN GUIA_ITINERARIO GI
ON G.id_legajo = (SELECT id_legajo 
FROM GUIA_ITINERARIO 
WHERE id_itinerario = 301)
ORDER BY GI.hora ASC

--6. Detalle de cada zona, extensión y cantidad de especies que aloja.

SELECT Z.extension, Z.nombre, COUNT(E.codigo) AS ESPECIES
FROM ZONA Z
LEFT JOIN ESPECIE E ON E.id_zona = Z.codigo
GROUP BY Z.codigo, Z.extension, Z.nombre;

--7. Guías que entraron a trabajar en el último mes.

SELECT E.nombre FROM EMPLEADO E
JOIN GUIA G
ON G.id_legajo = E.legajo
WHERE E.fecha_ingreso > GETDATE()-30;

--8. Empleados con más de 10 años de antigüedad.

SELECT E.nombre FROM EMPLEADO E
WHERE E.fecha_ingreso <= GETDATE()-3650;

--9. Nombre de la especie y fecha en la que se hizo cargo de la misma cada cuidador.

SELECT E.nombre, CE.fecha_desde ,ES.nombre FROM ESPECIE ES
JOIN CUIDADOR_ESPECIE CE
ON CE.id_especie = ES.codigo
JOIN CUIDADOR C
ON C.id_legajo = CE.id_legajo
JOIN EMPLEADO E
ON E.legajo = C.id_legajo;

--10. Promedio de duración de todos los itinerarios.

SELECT AVG(duracion) AS PROMEDIO FROM ITINERARIO

--11. Nombre de la zona de mayor extensión.

SELECT TOP 1 nombre FROM ZONA
ORDER BY ZONA.extension DESC

--12. Listado de itinerarios que recorren una zona dada.

SELECT IT.codigo 
FROM ITINERARIO IT
JOIN ITINERARIO_ZONA IT_ZO ON IT_ZO.id_itinerario = IT.codigo
JOIN (
    SELECT codigo
    FROM ZONA
    WHERE nombre = 'ZONA A'
) AS Z ON IT_ZO.id_zona = Z.codigo;

--13. Cantidad de itinerarios que visitan cada zona.

SELECT id_itinerario, COUNT(id_zona) AS Zonas 
FROM ITINERARIO_ZONA
GROUP BY(id_itinerario)

--14. Indicar por cada itinerario la relación longitud sobre duración, ordenados de mayor
--a menor siendo los mayores los más exigentes.

SELECT  codigo, duracion, longitud, cant_visitantes
FROM ITINERARIO
ORDER BY(longitud/duracion) DESC

--15. Indicar los itinerarios cuya duración este por encima del promedio.

SELECT codigo, duracion, longitud, cant_visitantes
FROM ITINERARIO
WHERE duracion > (SELECT AVG(duracion) FROM ITINERARIO);

--16. Listado de itinerarios que pueden visitar determinada especie.

SELECT I.codigo , I.duracion , I.longitud , I.cant_visitantes
FROM ITINERARIO I JOIN ITINERARIO_ZONA IZ
ON IZ.id_itinerario = I.codigo
JOIN ZONA Z
ON Z.codigo = IZ.id_zona
JOIN ESPECIE E
ON E.id_zona = Z.codigo
WHERE E.nombre = 'Tigre'

--17. Listado de empleados que no tengan especies a cargo ni lleven ningún itinerario.

SELECT legajo, nombre, direccion, telefono, fecha_ingreso
FROM EMPLEADO
WHERE legajo 
NOT IN 
(SELECT C.id_legajo FROM CUIDADOR C 
JOIN CUIDADOR_ESPECIE CE 
ON CE.id_legajo = C.id_legajo 
JOIN ESPECIE E 
ON CE.id_especie = E.codigo)
AND legajo 
NOT IN 
(SELECT G.id_legajo FROM GUIA G 
JOIN GUIA_ITINERARIO GI 
ON GI.id_legajo = G.id_legajo 
JOIN ITINERARIO I 
ON I.codigo = GI.id_itinerario);

--18. Listado de cuidadores y la cantidad de especies a cargo tiene cada uno.

SELECT E.legajo, E.nombre, E.direccion, E.telefono, E.fecha_ingreso, COUNT(CE.id_especie) AS CANTIDAD
FROM EMPLEADO E
JOIN CUIDADOR C ON C.id_legajo = E.legajo
JOIN CUIDADOR_ESPECIE CE ON CE.id_legajo = C.id_legajo
GROUP BY E.legajo, E.nombre, E.direccion, E.telefono, E.fecha_ingreso;

--19. Cuidadores con más de 5 especies a cargo.

SELECT E.legajo, E.nombre, E.direccion, E.telefono, E.fecha_ingreso, COUNT(CE.id_especie) AS CANTIDAD
FROM EMPLEADO E
JOIN CUIDADOR C ON C.id_legajo = E.legajo
JOIN CUIDADOR_ESPECIE CE ON CE.id_legajo = C.id_legajo
GROUP BY E.legajo, E.nombre, E.direccion, E.telefono, E.fecha_ingreso
HAVING COUNT(CE.id_especie) > 0;

--20. Nombre de la especie con mayor número de cuidadores

SELECT TOP 1 nombre,	nombre_cientifico, descripcion , COUNT(CE.id_legajo) AS 'CUIDADORES'
FROM ESPECIE E
JOIN CUIDADOR_ESPECIE CE
ON E.codigo = CE.id_especie
GROUP BY E.nombre, E.nombre_cientifico, E.descripcion
ORDER BY (COUNT(CE.id_legajo)) DESC 

--CARGA DE DATOS

-- Empleados
INSERT INTO EMPLEADO (legajo, nombre, direccion, telefono, fecha_ingreso)
VALUES (1, 'Juan Pérez', 'Calle 123, Ciudad', 123456789, '2023-10-01');

INSERT INTO EMPLEADO (legajo, nombre, direccion, telefono, fecha_ingreso)
VALUES (2, 'María López', 'Avenida 456, Ciudad', 987654321, '2023-09-15');

INSERT INTO EMPLEADO (legajo, nombre, direccion, telefono, fecha_ingreso)
VALUES (3, 'Carlos Rodríguez', 'Calle 789, Pueblo', 555555555, '2023-08-20');

INSERT INTO EMPLEADO (legajo, nombre, direccion, telefono, fecha_ingreso)
VALUES (4, 'Ana Martínez', 'Avenida 101, Pueblo', 333333333, '2023-07-05');

INSERT INTO EMPLEADO (legajo, nombre, direccion, telefono, fecha_ingreso)
VALUES (5, 'Luis González', 'Calle 555, Ciudad', 666666666, '2023-06-10');

-- Especies
INSERT INTO ESPECIE (codigo, id_zona, nombre, nombre_cientifico, descripcion)
VALUES (101, 201, 'León', 'Panthera leo', 'Especie de mamífero carnívoro');

INSERT INTO ESPECIE (codigo, id_zona, nombre, nombre_cientifico, descripcion)
VALUES (102, 202, 'Tigre', 'Panthera tigris', 'Especie de mamífero carnívoro');

INSERT INTO ESPECIE (codigo, id_zona, nombre, nombre_cientifico, descripcion)
VALUES (103, 201, 'Elefante', 'Loxodonta africana', 'Especie de mamífero herbívoro');

INSERT INTO ESPECIE (codigo, id_zona, nombre, nombre_cientifico, descripcion)
VALUES (104, 202, 'Cebra', 'Equus zebra', 'Especie de mamífero herbívoro');

-- Zonas
INSERT INTO ZONA (codigo, nombre, extension)
VALUES (201, 'Zona A', 5000);

INSERT INTO ZONA (codigo, nombre, extension)
VALUES (202, 'Zona B', 7000);

INSERT INTO ZONA (codigo, nombre, extension)
VALUES (203, 'Zona C', 7700);

-- Itinerarios
INSERT INTO ITINERARIO (codigo, duracion, longitud, cant_visitantes)
VALUES (301, 120, 2000, 50);

INSERT INTO ITINERARIO (codigo, duracion, longitud, cant_visitantes)
VALUES (302, 90, 1500, 40);

INSERT INTO ITINERARIO (codigo, duracion, longitud, cant_visitantes)
VALUES (303, 60, 1500, 40);

-- Guías
INSERT INTO GUIA (id_legajo)
VALUES (1);

INSERT INTO GUIA (id_legajo)
VALUES (2), (5);

-- Cuidadores
INSERT INTO CUIDADOR (id_legajo)
VALUES (3);

INSERT INTO CUIDADOR (id_legajo)
VALUES (4), (5);

-- CUIDADOR_ESPECIE
INSERT INTO CUIDADOR_ESPECIE (id_legajo, id_especie, fecha_desde)
VALUES (3, 101, '2023-10-01');


INSERT INTO CUIDADOR_ESPECIE (id_legajo, id_especie, fecha_desde)
VALUES (3, 102, '2023-10-01');

INSERT INTO CUIDADOR_ESPECIE (id_legajo, id_especie, fecha_desde)
VALUES (4, 102, '2023-09-15');

-- ITINERARIO_ZONA
INSERT INTO ITINERARIO_ZONA (id_itinerario, id_zona)
VALUES (301, 201);

INSERT INTO ITINERARIO_ZONA (id_itinerario, id_zona)
VALUES (302, 202);

INSERT INTO ITINERARIO_ZONA (id_itinerario, id_zona)
VALUES (302, 203);

-- GUIA_ITINERARIO
INSERT INTO GUIA_ITINERARIO (id_legajo, id_itinerario, hora)
VALUES (1, 301, '10:00:00');

INSERT INTO GUIA_ITINERARIO (id_legajo, id_itinerario, hora)
VALUES (2, 302, '11:30:00');

