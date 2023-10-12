DROP DATABASE IF EXISTS TPBD;

CREATE DATABASE TPBD;

DELETE FROM Ciudad;
DELETE FROM Conferencia;
DELETE FROM Division;
DELETE FROM Equipo;
DELETE FROM Equipo_Jugador;
DELETE FROM Estadistica;
DELETE FROM Jugador;
DELETE FROM EstadisticaPartido;
DELETE FROM Pais;
DELETE FROM Partido;
DELETE FROM Temporada;

USE TPBD;

CREATE TABLE datos(
equipoOP_ciudad varchar(30),
equipoOP_codigo varchar(30),
equipoOP_sigla varchar(5),
equipoOP_conferencia varchar(20),
equipoOP_division varchar(20),
equipoOP_id INT,
equipoOP_nombre varchar(30),
stat_asistencias_id INT,
stat_asistencias_nombre varchar(50),
stat_asistencias_valor INT,
stat_bloqueos_id INT,
stat_bloqueos_nombre varchar(50),
stat_bloqueos_valor INT,
equipo_ciudad varchar(30),
jugador_codigo varchar(40),
pais varchar(50),
stat_rebotes_defensivos_id INT,
stat_rebotes_defensivos_nombre varchar(50),
stat_rebotes_defensivos_valor int,
equipo_sigla varchar(5),
equipo_conferencia varchar(20),
nombre_completo varchar(40),
equipo_division varchar(20),
draft_year int,
fecha datetime,
stat_tiros_intentos_id INT,
stat_tiros_intentos_nombre varchar(50),
stat_tiros_intentos_valor int,
stat_tiros_convertidos_id INT,
stat_tiros_convertidos_nombre varchar(50),
stat_tiros_convertidos_valor int,
tiros_porcentaje decimal(5,2),
nombre varchar(30),
stat_faltas_id INT,
stat_faltas_nombre varchar(50),
stat_faltas_valor int,
stat_tiros_libres_intentos_id INT,
stat_tiros_libres_intentos_nombre varchar(50),
stat_tiros_libres_intentos_valor int,
stat_tiros_libres_convertidos_id INT,
stat_tiros_libres_convertidos_nombre varchar(50),
stat_tiros_libres_convertidos_valor int,
tiros_libres_porcentaje decimal(5,2),
partido_id int,
altura decimal(5,2),
esLocal varchar(20),
caminseta int,
apellido varchar(30),
stat_minutos_id INT,
stat_minutos_nombre varchar(50),
stat_minutos_valor int,
equipo_nombre varchar(30),
stat_rebotes_ofensivos_id INT,
stat_rebotes_ofensivos_nombre varchar(50),
stat_rebotes_ofensivos_valor int,
equipoOP_puntos int,
jugador_id int,
stat_puntos_id INT,
stat_puntos_nombre varchar(50),
stat_puntos_valor int,
posicion varchar(5),
rebotes int,
temporada_id int,
stat_segundos_id INT,
stat_segundos_nombre varchar(50),
stat_segundos_valor int,
stat_robos_id INT,
stat_robos_nombre varchar(50),
stat_robos_valor int,
equipo_codigo varchar(30),
equipo_puntos int,
equipo_id int,
stat_tiros_triples_intentos_id INT,
stat_tiros_triples_intentos_nombre varchar(50),
stat_tiros_triples_intentos_valor int,
stat_tiros_triples_convertidos_id INT,
stat_tiros_triples_convertidos_nombre varchar(50),
stat_tiros_triples_convertidos_valor int,
tiros_triples_porcentaje decimal(5,2),
stat_perdidas_id INT,
stat_perdidas_nombre varchar(50),
stat_perdidas_valor int,
peso varchar(50),
resultado varchar(10),
temporada_descripcion varchar(20),
idPais int,
equipo_idCiudad int,
equipoOP_idCiudad int
)


CREATE TABLE datos_staging (
    equipoOP_ciudad VARCHAR(MAX),
    equipoOP_codigo VARCHAR(MAX),
    equipoOP_sigla VARCHAR(MAX),
    equipoOP_conferencia VARCHAR(MAX),
    equipoOP_division VARCHAR(MAX),
    equipoOP_id INT,
    equipoOP_nombre VARCHAR(MAX),
    stat_asistencias_id INT,
    stat_asistencias_nombre VARCHAR(MAX),
    stat_asistencias_valor INT,
    stat_bloqueos_id INT,
    stat_bloqueos_nombre VARCHAR(MAX),
    stat_bloqueos_valor INT,
    equipo_ciudad VARCHAR(MAX),
    jugador_codigo VARCHAR(MAX),
    pais VARCHAR(MAX),
    stat_rebotes_defensivos_id INT,
    stat_rebotes_defensivos_nombre VARCHAR(MAX),
    stat_rebotes_defensivos_valor INT,
    equipo_sigla VARCHAR(MAX),
    equipo_conferencia VARCHAR(MAX),
    nombre_completo VARCHAR(MAX),
    equipo_division VARCHAR(MAX),
    draft_year INT,
    fecha DATETIME,
    stat_tiros_intentos_id INT,
    stat_tiros_intentos_nombre VARCHAR(MAX),
    stat_tiros_intentos_valor INT,
    stat_tiros_convertidos_id INT,
    stat_tiros_convertidos_nombre VARCHAR(MAX),
    stat_tiros_convertidos_valor INT,
    tiros_porcentaje DECIMAL(5, 2),
    nombre VARCHAR(MAX),
    stat_faltas_id INT,
    stat_faltas_nombre VARCHAR(MAX),
    stat_faltas_valor INT,
    stat_tiros_libres_intentos_id INT,
    stat_tiros_libres_intentos_nombre VARCHAR(MAX),
    stat_tiros_libres_intentos_valor INT,
    stat_tiros_libres_convertidos_id INT,
    stat_tiros_libres_convertidos_nombre VARCHAR(MAX),
    stat_tiros_libres_convertidos_valor INT,
    tiros_libres_porcentaje DECIMAL(5, 2),
    partido_id INT,
    altura VARCHAR(MAX),
    esLocal VARCHAR(MAX),
    camiseta VARCHAR(MAX),
    apellido VARCHAR(MAX),
    stat_minutos_id INT,
    stat_minutos_nombre VARCHAR(MAX),
    stat_minutos_valor INT,
    equipo_nombre VARCHAR(MAX),
    stat_rebotes_ofensivos_id INT,
    stat_rebotes_ofensivos_nombre VARCHAR(MAX),
    stat_rebotes_ofensivos_valor INT,
    equipoOP_puntos INT,
    jugador_id INT,
    stat_puntos_id INT,
    stat_puntos_nombre VARCHAR(MAX),
    stat_puntos_valor INT,
    posicion VARCHAR(MAX),
    rebotes INT,
    temporada_id INT,
    stat_segundos_id INT,
    stat_segundos_nombre VARCHAR(MAX),
    stat_segundos_valor INT,
    stat_robos_id INT,
    stat_robos_nombre VARCHAR(MAX),
    stat_robos_valor INT,
    equipo_codigo VARCHAR(MAX),
    equipo_puntos INT,
    equipo_id INT,
    stat_tiros_triples_intentos_id INT,
    stat_tiros_triples_intentos_nombre VARCHAR(MAX),
    stat_tiros_triples_intentos_valor INT,
    stat_tiros_triples_convertidos_id INT,
    stat_tiros_triples_convertidos_nombre VARCHAR(MAX),
    stat_tiros_triples_convertidos_valor INT,
    tiros_triples_porcentaje DECIMAL(5, 2),
    stat_perdidas_id INT,
    stat_perdidas_nombre VARCHAR(MAX),
    stat_perdidas_valor INT,
    peso VARCHAR(MAX),
    resultado VARCHAR(MAX),
    temporada_descripcion VARCHAR(MAX),
    idPais INT,
    equipo_idCiudad INT,
    equipoOP_idCiudad INT
);

BULK INSERT datos_staging
FROM 'C:\Users\franc\OneDrive\Escritorio\TP BD GIT BAVA\TPBD\datos2023.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
    FORMAT = 'CSV', 
    CODEPAGE = '65001'
);

CREATE TABLE Temporada (
    temporada_id INT PRIMARY KEY,
    temporada_descripcion VARCHAR(20)
);

CREATE TABLE Ciudad (
    ciudad_id INT PRIMARY KEY,
    ciudad_nombre VARCHAR(30)
);

CREATE TABLE Conferencia (
    conferencia_id INT PRIMARY KEY,
    conferencia_nombre VARCHAR(20)
);

CREATE TABLE Division (
    division_id INT PRIMARY KEY,
    division_nombre VARCHAR(20),
    division_conferencia_id INT REFERENCES Conferencia(conferencia_id)
);

CREATE TABLE Pais (
    pais_id INT PRIMARY KEY,
    pais_nombre VARCHAR(50)
);

CREATE TABLE Equipo (
    equipo_id INT PRIMARY KEY,
    equipo_codigo VARCHAR(30),
    equipo_nombre VARCHAR(30),
    equipo_sigla VARCHAR(5),
    equipo_ciudad_id INT REFERENCES Ciudad(ciudad_id),
    equipo_division_id INT REFERENCES Division(division_id)
);

CREATE TABLE Jugador (
    jugador_id INT PRIMARY KEY,
    jugador_codigo VARCHAR(40),
    jugador_nombre VARCHAR(30),
    jugador_apellido VARCHAR(30),
    jugador_altura DECIMAL(5,2),
    jugador_peso DECIMAL(5,2),
    jugador_pais_id INT REFERENCES Pais(pais_id),
    jugador_posicion VARCHAR(5),
    jugador_draft_year INT,
);

CREATE TABLE Estadistica (
    estadistica_id INT PRIMARY KEY,
    estadistica_descripcion VARCHAR(255)
);

CREATE TABLE Partido (
    partido_id INT PRIMARY KEY,
    partido_temporada_id INT REFERENCES Temporada(temporada_id),
    partido_local_equipo_id INT REFERENCES Equipo(equipo_id),
    partido_visitante_equipo_id INT REFERENCES Equipo(equipo_id),
    partido_fecha DATETIME,
    partido_puntos_local INT,
    partido_puntos_visitante INT,
    partido_ganador_equipo_id INT REFERENCES Equipo(equipo_id)
);

CREATE TABLE EstadisticaPartido (
    estadistica_partido_partido_id INT REFERENCES Partido(partido_id),
    estadistica_partido_jugador_id INT REFERENCES Jugador(jugador_id),
    estadistica_partido_estadistica_id INT REFERENCES Estadistica(estadistica_id),
    estadistica_partido_valor INT,
    CONSTRAINT FK_EstadisticaPartido PRIMARY KEY (
        estadistica_partido_partido_id,
        estadistica_partido_jugador_id,
        estadistica_partido_estadistica_id
    )
);


CREATE TABLE Equipo_Jugador (
    equipo_jugador_id INT PRIMARY KEY,
    jugador_id INT REFERENCES Jugador(jugador_id),
    equipo_id INT REFERENCES Equipo(equipo_id),
    temporada_id INT REFERENCES Temporada(temporada_id),
    numero_camiseta INT,
    CONSTRAINT UQ_EquipoJugador UNIQUE (jugador_id, equipo_id, temporada_id)
);



UPDATE datos_staging
SET 
    equipoOP_ciudad = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(equipoOP_ciudad,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    equipoOP_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(equipoOP_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    equipo_ciudad = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(equipo_ciudad,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
	equipo_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(equipo_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    nombre_completo = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(nombre_completo,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    pais = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(pais,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    peso = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(peso,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    apellido = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(apellido,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
	stat_asistencias_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_asistencias_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_bloqueos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_bloqueos_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_intentos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_intentos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_convertidos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_convertidos_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_faltas_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_faltas_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_libres_intentos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_libres_intentos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_libres_convertidos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_libres_convertidos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_puntos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_puntos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_minutos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_minutos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
	stat_rebotes_defensivos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_rebotes_ofensivos_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_rebotes_ofensivos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_rebotes_ofensivos_nombre,CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_segundos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_segundos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_robos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_robos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_triples_intentos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_triples_intentos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_tiros_triples_convertidos_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_tiros_triples_convertidos_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32)))),
    stat_perdidas_nombre = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(stat_perdidas_nombre, CHAR(32),'()'),')(',''),'()',CHAR(32))))
WHERE
    equipoOP_ciudad IS NOT NULL AND
    equipoOP_nombre IS NOT NULL AND
    equipo_ciudad IS NOT NULL AND
	equipo_nombre IS NOT NULL AND
    nombre_completo IS NOT NULL AND
    pais IS NOT NULL AND
    peso IS NOT NULL AND
    nombre IS NOT NULL AND
    apellido IS NOT NULL AND
	stat_asistencias_nombre IS NOT NULL AND
    stat_bloqueos_nombre IS NOT NULL AND
    stat_tiros_intentos_nombre IS NOT NULL AND
    stat_tiros_convertidos_nombre IS NOT NULL AND
    stat_faltas_nombre IS NOT NULL AND
    stat_tiros_libres_intentos_nombre IS NOT NULL AND
    stat_tiros_libres_convertidos_nombre IS NOT NULL AND
    stat_puntos_nombre IS NOT NULL AND
    stat_minutos_nombre IS NOT NULL AND
    stat_rebotes_ofensivos_nombre IS NOT NULL AND
    stat_segundos_nombre IS NOT NULL AND
    stat_robos_nombre IS NOT NULL AND
    stat_tiros_triples_intentos_nombre IS NOT NULL AND
    stat_tiros_triples_convertidos_nombre IS NOT NULL AND
    stat_perdidas_nombre IS NOT NULL;

UPDATE datos_staging
SET 
    equipoOP_idCiudad = 22,
    equipoOP_ciudad = 'Los Angeles'
WHERE
    equipoOP_ciudad = 'LA';

UPDATE datos_staging
SET 
    equipo_idCiudad = 22,
    equipo_ciudad = 'Los Angeles'
WHERE
    equipo_ciudad = 'LA';

UPDATE datos_staging
SET
    peso = 
        CASE
            WHEN peso LIKE '% libras%' THEN 
                CAST(SUBSTRING(peso, 1, CHARINDEX(' ', peso) - 1) AS DECIMAL(10, 2)) / 2.20462
            WHEN peso LIKE '% kilogramos%' THEN 
                CAST(SUBSTRING(peso, 1, CHARINDEX(' ', peso) - 1) AS DECIMAL(10, 2))
        END
WHERE
    peso IS NOT NULL;

UPDATE datos_staging
SET
	peso = ROUND(CAST(REPLACE(peso, ',', '') AS DECIMAL), 0)
WHERE
	peso IS NOT NULL;

UPDATE datos_staging
SET
    altura = 
        CASE
            WHEN CHARINDEX('-', altura) > 0 THEN
                CAST(PARSENAME(REPLACE(altura, '-', '.'), 2) AS DECIMAL(5, 2)) * 0.3048 + 
                CAST(PARSENAME(REPLACE(altura, '-', '.'), 1) AS DECIMAL(5, 2)) * 0.0254
            ELSE
                CAST(altura AS DECIMAL(5, 2))
        END
WHERE
    altura IS NOT NULL;

UPDATE datos_staging
SET altura = CAST(ROUND(CAST(altura AS DECIMAL(18,2)), 2) AS VARCHAR(10))
WHERE altura IS NOT NULL;

CREATE TABLE #TempPais (pais VARCHAR(MAX));

INSERT INTO #TempPais (pais)
SELECT DISTINCT pais
FROM datos_staging
WHERE idPais = 0;

UPDATE ds
SET ds.idPais = MaxIdPais.MaxIdPais + RowNumber
FROM datos_staging ds
JOIN (
    SELECT pais, ROW_NUMBER() OVER (ORDER BY pais) AS RowNumber
    FROM (
        SELECT DISTINCT pais
        FROM datos_staging
        WHERE idPais = 0
    ) AS TempPais
) AS TempPaisWithRowNumber ON ds.pais = TempPaisWithRowNumber.pais
CROSS JOIN (
    SELECT ISNULL(MAX(idPais), 0) AS MaxIdPais
    FROM datos_staging
    WHERE idPais > 0
) AS MaxIdPais;

DROP TABLE #TempPais;

UPDATE datos_staging
SET CAMISETA = 
    CASE 
        WHEN CHARINDEX('.', CAMISETA) > 0 
        THEN LEFT(CAMISETA, CHARINDEX('.', CAMISETA) - 1)
        ELSE CAMISETA
    END
WHERE CAMISETA IS NOT NULL;

ALTER TABLE datos_staging
ADD division_id INT,
    conference_id INT;

UPDATE datos_staging
SET division_id = 
CASE
    WHEN equipo_division = 'Noroeste' THEN 1
    WHEN equipo_division = 'Sudoeste' THEN 2
	WHEN equipo_division = 'Pacífico' THEN 3
    WHEN equipo_division = 'Atlántico' THEN 4
    WHEN equipo_division = 'Central' THEN 5
    WHEN equipo_division = 'Sudeste' THEN 6
    ELSE NULL
END;

UPDATE datos_staging
SET conference_id = 
CASE
    WHEN equipo_conferencia = 'Oeste' THEN 1
    WHEN equipo_conferencia = 'Este' THEN 2
    ELSE NULL
END;

INSERT INTO Conferencia (conferencia_id, conferencia_nombre)
SELECT DISTINCT conference_id, equipo_conferencia
FROM datos_staging
WHERE equipo_conferencia IS NOT NULL;

INSERT INTO Division (division_id, division_nombre, division_conferencia_id)
SELECT DISTINCT division_id, equipo_division, conference_id
FROM datos_staging
WHERE equipo_division IS NOT NULL;

INSERT INTO Pais (pais_id, pais_nombre)
SELECT DISTINCT idPais, pais
FROM datos_staging
WHERE idPais IS NOT NULL;

INSERT INTO Ciudad(ciudad_id, ciudad_nombre)
SELECT DISTINCT equipo_idCiudad, equipo_ciudad
FROM datos_staging
WHERE equipo_idCiudad IS NOT NULL;

INSERT INTO Temporada(temporada_id, temporada_descripcion)
SELECT DISTINCT temporada_id, temporada_descripcion from datos_staging
WHERE temporada_id IS NOT NULL;

INSERT INTO Estadistica(estadistica_id, estadistica_descripcion)
SELECT DISTINCT stat_asistencias_id, stat_asistencias_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_bloqueos_id, stat_bloqueos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_intentos_id, stat_tiros_intentos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_convertidos_id, stat_tiros_convertidos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_faltas_id, stat_faltas_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_libres_intentos_id, stat_tiros_libres_intentos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_libres_convertidos_id, stat_tiros_libres_convertidos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_puntos_id, stat_puntos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_minutos_id, stat_minutos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_rebotes_defensivos_id, stat_rebotes_defensivos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_rebotes_ofensivos_id, stat_rebotes_ofensivos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_segundos_id, stat_segundos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_robos_id, stat_robos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_triples_intentos_id, stat_tiros_triples_intentos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_tiros_triples_convertidos_id, stat_tiros_triples_convertidos_nombre FROM datos_staging
UNION
SELECT DISTINCT stat_perdidas_id, stat_perdidas_nombre FROM datos_staging;

UPDATE Estadistica
SET estadistica_descripcion = 'Rebotes defensivos' 
WHERE estadistica_id = 3

INSERT INTO Equipo(equipo_id, equipo_sigla, equipo_nombre, equipo_codigo, equipo_ciudad_id, equipo_division_id)
SELECT DISTINCT
    equipo_id,
	equipo_sigla,
	equipo_nombre,
    equipo_codigo,
    equipo_idCiudad,
    division_id
FROM datos_staging;

INSERT INTO Jugador (
    jugador_id,
    jugador_codigo,
    jugador_nombre,
    jugador_apellido,
    jugador_altura,
    jugador_peso,
    jugador_pais_id,
    jugador_posicion,
    jugador_draft_year
)
SELECT DISTINCT
    jugador_id,
    jugador_codigo,
    nombre,
    apellido,
    altura,
    peso,
    idPais,
    posicion,
    draft_year
FROM datos_staging;

INSERT INTO Equipo_Jugador (equipo_jugador_id, jugador_id, equipo_id, temporada_id, numero_camiseta)
SELECT 
    ROW_NUMBER() OVER (ORDER BY jugador_id, equipo_id, temporada_id) AS equipo_jugador_id,
    jugador_id,
    equipo_id,
    temporada_id,
    ISNULL(MIN(camiseta), 0) AS numero_camiseta
FROM datos_staging
GROUP BY jugador_id, equipo_id, temporada_id

INSERT INTO Partido (
	partido_id, 
	partido_temporada_id ,
    partido_local_equipo_id ,
    partido_visitante_equipo_id ,
    partido_fecha ,
    partido_puntos_local ,
    partido_puntos_visitante ,
    partido_ganador_equipo_id 
)
	SELECT
    DISTINCT partido_id, 
    temporada_id,
    equipo_id,
    equipoOP_id,
    fecha,
    equipo_puntos,
    equipoOP_puntos,
    CASE
        WHEN resultado = 'Won' THEN equipo_id
        ELSE equipoOP_id
    END AS partido_ganador_equipo_id FROM datos_staging
WHERE esLocal = 'True';

INSERT INTO EstadisticaPartido 
SELECT
	partido_id,
	jugador_id,
	stat_asistencias_id ,
    stat_asistencias_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_bloqueos_id ,
    stat_bloqueos_valor    
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
	stat_rebotes_defensivos_id,
    stat_rebotes_defensivos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
	stat_tiros_intentos_id ,
    stat_tiros_intentos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_convertidos_id ,
    stat_tiros_convertidos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_faltas_id ,
    stat_faltas_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_libres_intentos_id ,
    stat_tiros_libres_intentos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_libres_convertidos_id ,
    stat_tiros_libres_convertidos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_minutos_id ,
    stat_minutos_valor    
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_rebotes_ofensivos_id ,
    stat_rebotes_ofensivos_valor
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_puntos_id ,
    stat_puntos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_segundos_id ,
    stat_segundos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_robos_id ,
    stat_robos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_triples_intentos_id ,
    stat_tiros_triples_intentos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_triples_convertidos_id ,
    stat_tiros_triples_convertidos_valor     
	FROM datos_staging;

INSERT INTO EstadisticaPartido
	SELECT
	partido_id,
	jugador_id,
	stat_perdidas_id,
	stat_perdidas_valor
	FROM datos_staging;

--Borrar Tabla de datos
DROP TABLE datos_staging;

--ACTIVIDADES 

--1

SELECT COUNT(DISTINCT e.equipo_nombre) AS cantidad_equipos
FROM Partido p
INNER JOIN Equipo e ON p.partido_local_equipo_id = e.equipo_id OR p.partido_visitante_equipo_id = e.equipo_id
WHERE p.partido_fecha = '2022-12-01';

--2

SELECT 
	COUNT(partido_id) AS Partidos_jugados_Marzo
FROM Partido p
WHERE MONTH(partido_fecha) = 3;

--3

SELECT	COUNT(DISTINCT ej.jugador_id) AS Total_Jugadores
FROM Partido p
INNER JOIN Equipo_Jugador ej ON (ej.equipo_id = p.partido_local_equipo_id OR ej.equipo_id = p.partido_visitante_equipo_id)
WHERE YEAR(partido_fecha) = 2022 AND MONTH(partido_fecha) = 12;

--4

SELECT partido_fecha AS 'FECHA',
EL.equipo_nombre AS 'EQUIPO LOCAL',
P.partido_puntos_local AS 'PUNTOS LOCAL',
EV.equipo_nombre AS 'EQUIPO VISITANTE',
P.partido_puntos_visitante AS 'PUNTOS VISITANTE'
FROM Partido P
JOIN Equipo EL
ON EL.equipo_id = p.partido_local_equipo_id
JOIN Equipo EV
ON EV.equipo_id = p.partido_visitante_equipo_id
WHERE MONTH(P.partido_fecha) = 12

--5

SELECT DISTINCT partido_id FROM Partido P
INNER JOIN Equipo E
ON E.equipo_id = P.partido_local_equipo_id OR E.equipo_id = P.partido_visitante_equipo_id 
WHERE E.equipo_nombre = 'Bucks' AND P.partido_ganador_equipo_id <> E.equipo_id

--6

SELECT TOP 1 J.jugador_nombre, J.jugador_apellido, EJ.numero_camiseta, E.equipo_nombre,
  ROUND(AVG(CAST(EP.estadistica_partido_valor AS FLOAT)), 2) AS 'PROMEDIO'
FROM Jugador J
INNER JOIN Equipo_Jugador EJ ON J.jugador_id = EJ.jugador_id
INNER JOIN Equipo E ON EJ.equipo_id = E.equipo_id
INNER JOIN EstadisticaPartido EP ON J.jugador_id = EP.estadistica_partido_jugador_id
INNER JOIN Estadistica ES ON EP.estadistica_partido_estadistica_id = ES.estadistica_id
WHERE ES.estadistica_descripcion = 'Robos'
GROUP BY J.jugador_id, J.jugador_nombre, J.jugador_apellido, EJ.numero_camiseta, E.equipo_nombre
ORDER BY AVG(CAST(EP.estadistica_partido_valor AS DECIMAL(5,2))) DESC;

--7

SELECT TOP 5 E.equipo_nombre, 
       AVG(PuntosPorPartido) AS PromedioPuntosPorPartido
FROM Equipo E
INNER JOIN (
    SELECT partido_local_equipo_id AS equipo_id, partido_puntos_local AS PuntosPorPartido
    FROM Partido
    UNION ALL
    SELECT partido_visitante_equipo_id AS equipo_id, partido_puntos_visitante AS PuntosPorPartido
    FROM Partido
) AS Puntos	
ON E.equipo_id = Puntos.equipo_id
GROUP BY E.equipo_nombre
ORDER BY PromedioPuntosPorPartido DESC;

--8

SELECT COUNT(DISTINCT partido_id) AS 'PARTIDOS PERDIDOS' FROM Partido P
INNER JOIN Equipo E
ON E.equipo_id = P.partido_local_equipo_id OR E.equipo_id = P.partido_visitante_equipo_id
INNER JOIN Ciudad C
ON C.ciudad_id = E.equipo_ciudad_id
WHERE C.ciudad_nombre = 'Boston' AND P.partido_ganador_equipo_id <> E.equipo_id AND 
(P.partido_puntos_local > 100 AND P.partido_puntos_visitante > 100)

--8 BIS

SELECT COUNT(*) AS CantidadPartidosPerdidos
FROM Partido P
INNER JOIN Equipo E ON P.partido_local_equipo_id = E.equipo_id OR P.partido_visitante_equipo_id = E.equipo_id
INNER JOIN Ciudad C ON E.equipo_ciudad_id = C.ciudad_id
WHERE C.ciudad_nombre = 'Boston'
  AND ((P.partido_local_equipo_id = E.equipo_id AND P.partido_puntos_local > 100)
    OR (P.partido_visitante_equipo_id = E.equipo_id AND P.partido_puntos_visitante > 100))
  AND P.partido_ganador_equipo_id != E.equipo_id;

--9

SELECT D.division_nombre, 
    AVG(P.partido_puntos_local + P.partido_puntos_visitante) AS 'Promedio puntos por partido'
FROM Division D
INNER JOIN Equipo E 
ON D.division_id = E.equipo_division_id
LEFT JOIN Partido P 
ON (E.equipo_id = P.partido_local_equipo_id OR E.equipo_id = P.partido_visitante_equipo_id)
GROUP BY D.division_nombre

--10

SELECT TOP(1) p.pais_nombre, COUNT(j.jugador_id) AS cantidad_jugadores
FROM Jugador j
JOIN Pais p ON j.jugador_pais_id = p.pais_id
GROUP BY p.pais_nombre
ORDER BY cantidad_jugadores DESC

--11

SELECT
    J.jugador_nombre AS Nombre,
    J.jugador_apellido AS Apellido,
    SUM(CASE WHEN ES.estadistica_descripcion IN ('Rebotes ofensivos', 'Rebotes defensivos') THEN EP.estadistica_partido_valor ELSE 0 END) AS Rebotes,
    SUM(CASE WHEN ES.estadistica_descripcion = 'Asistencias' THEN EP.estadistica_partido_valor ELSE 0 END) AS Asistencias,
    SUM(CASE WHEN ES.estadistica_descripcion = 'Puntos' THEN EP.estadistica_partido_valor ELSE 0 END) AS Puntos
FROM Partido P
JOIN Equipo_Jugador EJ ON EJ.equipo_id = P.partido_local_equipo_id OR EJ.equipo_id = P.partido_visitante_equipo_id
JOIN Equipo E ON E.equipo_id = EJ.equipo_id
JOIN Jugador J ON J.jugador_id = EJ.jugador_id
JOIN Division D ON D.division_id = E.equipo_division_id
JOIN Equipo ER ON ER.equipo_id = P.partido_local_equipo_id OR ER.equipo_id = P.partido_visitante_equipo_id
JOIN Division DR ON DR.division_id = ER.equipo_division_id
JOIN EstadisticaPartido EP ON EP.estadistica_partido_partido_id = P.partido_id AND EP.estadistica_partido_jugador_id = J.jugador_id
JOIN Estadistica ES ON ES.estadistica_id = EP.estadistica_partido_estadistica_id
WHERE (J.jugador_nombre = 'Kawhi' AND J.jugador_apellido = 'Leonard') 
    AND (D.division_conferencia_id <> DR.division_conferencia_id)
    AND (ES.estadistica_descripcion IN ('Rebotes ofensivos', 'Rebotes defensivos', 'Asistencias', 'Puntos'))
GROUP BY J.jugador_nombre, J.jugador_apellido;

--12

SELECT COUNT(j.jugador_id) AS cantidad_jugadores
FROM Jugador j
WHERE YEAR(GETDATE()) - j.jugador_draft_year > 15;

--13

SELECT DISTINCT J.jugador_nombre, J.jugador_apellido
FROM Jugador J
INNER JOIN Equipo_Jugador EJ ON J.jugador_id = EJ.jugador_id
WHERE EJ.temporada_id = (SELECT temporada_id FROM Temporada WHERE temporada_descripcion = '2022-2023')
GROUP BY J.jugador_nombre, J.jugador_apellido
HAVING COUNT(DISTINCT EJ.equipo_id) > 1
ORDER BY J.jugador_apellido, J.jugador_nombre;

--14

SELECT COUNT(estadistica_partido_partido_id) AS 'CANTIDAD' FROM EstadisticaPartido EP 
JOIN Equipo_Jugador EJ
ON EJ.jugador_id = EP.estadistica_partido_jugador_id
JOIN Equipo E
ON E.equipo_id = EJ.equipo_id
WHERE E.equipo_nombre = 'Celtics' 
AND EP.estadistica_partido_estadistica_id = 11 
AND EP.estadistica_partido_valor >= 15

--15

SELECT TOP 1
	   P.partido_id AS 'CODIGO',
       P.partido_fecha AS 'FECHA',
       PL.equipo_sigla AS 'SIGLAS LOCAL',
       PV.equipo_sigla AS 'SIGLAS VISITANTE',
       P.partido_puntos_local AS 'PUNTOS LOCAL',
       P.partido_puntos_visitante AS 'PUNTOS VISITANTE',
	   ABS(P.partido_puntos_local - P.partido_puntos_visitante) AS 'DIFERENCIA'
FROM Partido P
JOIN Equipo PL
ON PL.equipo_id = P.partido_local_equipo_id
JOIN Equipo PV
ON PV.equipo_id = P.partido_visitante_equipo_id
JOIN Equipo_Jugador EJ
ON PL.equipo_id = EJ.equipo_id OR PV.equipo_id = EJ.equipo_id
JOIN Jugador J 
ON EJ.jugador_id = J.jugador_id
WHERE J.jugador_nombre = 'Kawhi' AND J.jugador_apellido = 'Leonard'
ORDER BY (ABS(P.partido_puntos_visitante - P.partido_puntos_local )) DESC

--COMPROBACION DE EQUIPO DE JUGADOR
SELECT E.equipo_sigla, E.equipo_id
FROM Equipo E
JOIN Equipo_Jugador EJ ON EJ.equipo_id = E.equipo_id
JOIN Jugador J ON J.jugador_id = EJ.jugador_id
WHERE J.jugador_nombre = 'Kawhi' AND J.jugador_apellido = 'Leonard';

--COMPROBACION DE RESULTADOS
SELECT *, ABS(partido_puntos_visitante - partido_puntos_local) AS 'DIFERENCIA' FROM Partido WHERE partido_ganador_equipo_id = 1610612746
ORDER BY (ABS(partido_puntos_visitante - partido_puntos_local)) DESC

