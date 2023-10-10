USE CLUB_NAU_GUIA10

CREATE TABLE SOCIO(
 DNI INT NOT NULL PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 dirección VARCHAR(100) NOT NULL, 
 fecha_desde DATE NOT NULL
);

CREATE TABLE EMPLEADO(
 codigo INT NOT NULL PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 telefono INT,
);

CREATE TABLE TIPO_EMBARCACION(
 codigo INT NOT NULL PRIMARY KEY,
 descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE ZONA(
 letra CHAR NOT NULL PRIMARY KEY,
 profundidad DECIMAL(3,2) NOT NULL,
 ancho_amarres DECIMAL(3,2) NOT NULL
);

CREATE TABLE AMARRE(
 numero INT NOT NULL PRIMARY KEY,
 id_socio INT NOT NULL,
 id_zona CHAR NOT NULL,
 fecha_desde DATE NOT NULL,
 medidor_de_agua DECIMAL(3,2) NOT NULL,
 medidor_de_luz DECIMAL(3,2) NOT NULL,
 mantenimiento BIT NOT NULL,
 CONSTRAINT FK_SOCIO FOREIGN KEY(id_socio) REFERENCES SOCIO(DNI),
 CONSTRAINT FK_ZONA FOREIGN KEY(id_zona) REFERENCES ZONA(letra)
);

ALTER TABLE AMARRE
ALTER COLUMN medidor_de_agua DECIMAL(5,2) NOT NULL;


ALTER TABLE AMARRE
ALTER COLUMN medidor_de_luz DECIMAL(5,2) NOT NULL;

CREATE TABLE EMBARCACION(
 matricula INT NOT NULL PRIMARY KEY,
 id_tipo INT NOT NULL,
 id_socio INT NOT NULL,
 id_amarre INT NOT NULL,
 fecha_desde DATE NOT NULL,
 nombre VARCHAR(100) NOT NULL,
 dimension DECIMAL(3,2) NOT NULL,
 CONSTRAINT FK_TIPO FOREIGN KEY(id_tipo) REFERENCES TIPO_EMBARCACION(codigo),
 CONSTRAINT FK_SOCIO_EMB FOREIGN KEY(id_socio) REFERENCES SOCIO(DNI),
 CONSTRAINT FK_AMARRE FOREIGN KEY(id_socio) REFERENCES AMARRE(numero)
);

ALTER TABLE EMBARCACION
ALTER COLUMN dimension DECIMAL(5,2) NOT NULL;

CREATE TABLE EMPLEADO_ZONA(
 id_empleado INT NOT NULL,
 id_zona CHAR NOT NULL,
 PRIMARY KEY(id_empleado, id_zona),
 CONSTRAINT FK_EMPLEADO FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(codigo),
 CONSTRAINT FK_ZONA_EMP FOREIGN KEY(id_zona) REFERENCES ZONA(letra)
);

CREATE TABLE EMPLEADO_AMARRE(
 id_empleado INT NOT NULL,
 id_amarre INT NOT NULL,
 PRIMARY KEY(id_empleado, id_amarre),
 CONSTRAINT FK_EMPLEADO_AMA FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(codigo),
 CONSTRAINT FK_AMARRE_EMP FOREIGN KEY(id_amarre) REFERENCES AMARRE(numero)
);

-- 1. Listado completo de socios.

SELECT DNI , nombre, dirección , fecha_desde AS 'SOCIO DESDE' FROM SOCIO

-- 2. Seleccionar todos los socios que ingresaron este año.

SELECT DNI , nombre, dirección , fecha_desde AS 'SOCIO DESDE' FROM SOCIO WHERE YEAR(fecha_desde) = YEAR(GETDATE())

-- 3. Seleccionar un listado de las embarcaciones ordenadas por matrícula.

SELECT matricula, id_tipo, id_socio, id_amarre, fecha_desde, nombre, dimension FROM EMBARCACION ORDER BY(matricula)

-- 4. Listado de nombre de socio, dni, y cantidad de embarcaciones que posee.



-- 5. Identificar a qué zona pertenece un amarre dado.



-- 6. Listado de amarres disponibles, indicando la zona a la que pertenece.



-- 7. Indicar el nombre y teléfono del propietario de una embarcación conocida su matrícula.



-- 8. Seleccionar los 10 socios con mayor antigüedad.



-- 9. Listado de amarres ocupados por embarcaciones de terceros.



-- 10. Calcular cantidad promedio de amarres por socio.



-- 11. Nombre de los socios cuyos amarres tengan un consumo de luz superior al dado.



-- 12. Calcular la cantidad total de amarres.



-- 13. Calcular la cantidad de amarres por zona.



-- 14. Indicar la zona con más cantidad de amarres.



-- 15. Indicar los empleados asignados a la zona del punto anterior.



-- 16. Listado de socios que no son propietarios de amarres.



-- 17. Listado de socios que no son propietarios de embarcaciones.



-- 18. Cantidad de amarres con servicio de mantenimiento contratado.



-- 19. Listado de amarres a cargo de un empleado dado.



-- 20. Listado de empleados que no tienen amarres asignados.



-- 21. Listado de embarcaciones (matrícula, nombre, nombre del dueño, nombre del dueño 
-- del amarre) que se encuentran en amarres asignados a un empleado indicado.



-- 22. Listado de empleados, indicando la cantidad de amarres que tiene a cargo cada uno, 
-- ordenando por este criterio de mayor a menor.


--DATOS

-- Insertar datos en la tabla SOCIO
INSERT INTO SOCIO (DNI, nombre, dirección, fecha_desde)
VALUES
    (11111111, 'Socio 1', 'Dirección 1', '2022-01-15'),
    (22222222, 'Socio 2', 'Dirección 2', '2021-05-20'),
    (33333333, 'Socio 3', 'Dirección 3', '2023-03-10');

-- Insertar datos en la tabla EMPLEADO
INSERT INTO EMPLEADO (codigo, nombre, telefono)
VALUES
    (1, 'Empleado 1', 123456789),
    (2, 'Empleado 2', 987654321);

-- Insertar datos en la tabla TIPO_EMBARCACION
INSERT INTO TIPO_EMBARCACION (codigo, descripcion)
VALUES
    (101, 'Velero'),
    (102, 'Yate'),
    (103, 'Lancha');

-- Insertar datos en la tabla ZONA
INSERT INTO ZONA (letra, profundidad, ancho_amarres)
VALUES
    ('A', 3.5, 5.0),
    ('B', 4.0, 6.0),
    ('C', 4.2, 6.5);

-- Insertar datos en la tabla AMARRE
INSERT INTO AMARRE (numero, id_socio, id_zona, fecha_desde, medidor_de_agua, medidor_de_luz, mantenimiento)
VALUES
    (1, 11111111, 'A', '2022-02-01', 10.5, 15.0, 1),
    (2, 22222222, 'B', '2021-06-15', 12.0, 18.5, 0),
    (3, 33333333, 'C', '2023-04-20', 9.0, 13.5, 1);

	SELECT * FROM AMARRE

-- Insertar datos en la tabla EMBARCACION
INSERT INTO EMBARCACION (matricula, id_tipo, id_socio, id_amarre, fecha_desde, nombre, dimension)
VALUES
    (1001, 101, 11111111, 1, '2022-02-01', 'Velero A', 10.0),
    (1002, 102, 22222222, 2, '2021-06-15', 'Yate B', 15.5),
    (1003, 103, 33333333, 3, '2023-04-20', 'Lancha C', 8.2);

-- Insertar datos en la tabla EMPLEADO_ZONA
INSERT INTO EMPLEADO_ZONA (id_empleado, id_zona)
VALUES
    (1, 'A'),
    (1, 'B'),
    (2, 'C');

-- Insertar datos en la tabla EMPLEADO_AMARRE
INSERT INTO EMPLEADO_AMARRE (id_empleado, id_amarre)
VALUES
    (1, 1),
    (2, 2),
    (2, 3);
