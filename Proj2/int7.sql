.mode columns
.headers on
.nullvalue NULL

SELECT s.nome, COUNT(g.idJogo) AS Jogos
FROM Pavilhao s
JOIN PavilhaoJogo g ON s.idPavilhao = g.idPavilhao
GROUP BY s.idPavilhao
ORDER BY Jogos DESC;