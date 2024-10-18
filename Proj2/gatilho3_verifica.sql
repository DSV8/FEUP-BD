.mode columns
.headers on
.nullvalue NULL


SELECT nomeClube, numJogos, vitorias, empates, derrotas, pontos FROM Classificacao ORDER BY pontos DESC;
INSERT INTO Jogo(idJogo, data, horaInicio, vencedor, derrotado, idEquipaVisitada, idEquipaVisitante) VALUES (195,  2021-09-12, '20:00:00', 'FC Porto', 'Sporting', 1, 6);
SELECT nomeClube, numJogos, vitorias, empates, derrotas, pontos FROM Classificacao ORDER BY pontos DESC;