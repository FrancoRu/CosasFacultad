SELECT
    ROW_NUMBER() OVER (ORDER BY partido_id, jugador_id) as ID,
    partido_id,
    jugador_id,
    stat_tiros_triples_convertidos_id,
    stat_tiros_triples_convertidos_valor
FROM datos_staging
ORDER BY partido_id, jugador_id;
