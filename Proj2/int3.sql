.mode columns
.headers on
.nullvalue NULL

SELECT e.nomeClube, COUNT(mg.idGolo) AS autoGolos
FROM MarcaGolo mg
INNER JOIN Jogador j ON mg.idJogador = j.idPessoa
INNER JOIN Equipa e ON mg.idEquipa = e.idEquipa
LEFT JOIN AtribuiCartao ac ON ac.idJogador = j.idPessoa
WHERE j.numero > 10 AND ac.idCartao IS NULL AND e.idEquipa = mg.idEquipa
GROUP BY e.nomeClube
