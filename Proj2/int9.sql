.mode columns
.headers on
.nullvalue NULL

SELECT DISTINCT e.nomeClube
FROM Equipa e
JOIN Jogo j ON j.idEquipaVisitante = e.idEquipa
JOIN PavilhaoJogo pj ON j.idJogo = pj.idJogo
JOIN Pavilhao p ON pj.idPavilhao = p.idPavilhao
WHERE p.nomeClube = 'Benfica';