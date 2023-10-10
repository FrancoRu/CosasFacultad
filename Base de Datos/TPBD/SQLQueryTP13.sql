
CREATE TABLE EstadisticaPartido (
    estadistica_partido_partido_id INT REFERENCES Partido(partido_id),
    estadistica_partido_jugador_id INT REFERENCES Jugador(jugador_id),
    estadistica_partido_estadistica_id INT REFERENCES Estadistica(estadistica_id),
    estadistica_partido_valor INT,
	PRIMARY KEY(estadistica_partido_partido_id, 
	estadistica_partido_jugador_id,
	estadistica_partido_estadistica_id
	)
);

DROP TABLE EstadisticaPartido
DELETE FROM EstadisticaPartido
INSERT INTO EstadisticaPartido 
SELECT
	partido_id,
	jugador_id,
	stat_asistencias_id ,
    stat_asistencias_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_bloqueos_id ,
    stat_bloqueos_valor    
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
	stat_rebotes_defensivos_id,
    stat_rebotes_defensivos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
	stat_tiros_intentos_id ,
    stat_tiros_intentos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_convertidos_id ,
    stat_tiros_convertidos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_faltas_id ,
    stat_faltas_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_libres_intentos_id ,
    stat_tiros_libres_intentos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_libres_convertidos_id ,
    stat_tiros_libres_convertidos_valor     
	FROM datos_staging
INSERT INTO EstadisticaPartido

SELECT
	partido_id,
	jugador_id,
    stat_minutos_id ,
    stat_minutos_valor     FROM datos_staging
INSERT INTO EstadisticaPartido

SELECT
	partido_id,
	jugador_id,
    stat_rebotes_ofensivos_id ,
    stat_rebotes_ofensivos_valor     FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_puntos_id ,
    stat_puntos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_segundos_id ,
    stat_segundos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_robos_id ,
    stat_robos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_triples_intentos_id ,
    stat_tiros_triples_intentos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
	partido_id,
	jugador_id,
    stat_tiros_triples_convertidos_id ,
    stat_tiros_triples_convertidos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
partido_id,
	jugador_id,
    stat_tiros_triples_intentos_id ,
    stat_tiros_triples_intentos_valor     
	FROM datos_staging

INSERT INTO EstadisticaPartido
SELECT
    partido_id,
    jugador_id,
    stat_tiros_triples_convertidos_id,
    stat_tiros_triples_convertidos_valor
	FROM datos_staging
