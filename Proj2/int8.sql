.mode columns
.headers on
.nullvalue NULL

WITH t1 AS
(SELECT j.idPessoa AS idJog, j.nome AS nome, j.idEquipa AS idEq
FROM Equipa e
JOIN Jogador j ON e.idEquipa = j.idEquipa
WHERE e.nomeClube = 'FC Porto')

SELECT DISTINCT t1.nome
FROM t1
JOIN MarcaGolo mg ON t1.idJog = mg.idJogador AND t1.idEq = mg.idEquipa
JOIN Golo g ON mg.idGolo = g.idEvento
JOIN Jogo j ON g.idJogo = j.idJogo
JOIN JornadaJogo jj ON j.idJogo = jj.idJogo
WHERE jj.numJornada = 1
ORDER BY t1.nome ASC;