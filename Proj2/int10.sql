.mode columns
.headers on
.nullvalue NULL

SELECT e.nomeClube AS 'CLUBE', COUNT(*) AS 'CARTÕES'
FROM Cartao c
JOIN Jogo j ON c.idJogo = j.idJogo
JOIN Equipa e ON (j.idEquipaVisitada = e.idEquipa OR j.idEquipaVisitante = e.idEquipa)
WHERE  e.nomeClube = 'Sporting' AND c.cor = 'Azul'
GROUP BY e.nomeClube
HAVING COUNT(*) > 0;