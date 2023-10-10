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

SELECT * FROM Partido

SELECT
	DISTINCT
	partido_id, 
	temporada_id ,
	equipoOP_nombre,
	equipo_nombre,
    esLocal ,
    fecha ,
    equipoOP_puntos ,
    resultado
	FROM datos_staging
	WHERE esLocal = 'True'
	ORDER BY partido_id

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
