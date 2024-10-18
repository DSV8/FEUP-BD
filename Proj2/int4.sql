.mode columns
.headers on
.nullvalue NULL

SELECT DISTINCT C.nome, C.ranking, P.nomeClube
FROM Classificacao C
INNER JOIN Playoffs P ON C.nomeClube = P.nomeClube
WHERE C.vitorias >= 5 AND C.golosMarcados - C.golosSofridos > 5
ORDER BY C.ranking ASC
LIMIT 3

