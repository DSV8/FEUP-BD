.mode columns
.headers on
.nullvalue NULL

SELECT idEvento FROM Evento
WHERE minuto >= 10 AND minuto <= 25 AND parte = 2
AND idJogo IN (SELECT idJogo FROM JornadaJogo WHERE numJornada >= 14 AND numJornada <= 26);
