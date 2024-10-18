.mode columns
.headers on
.nullvalue NULL

SELECT Jogador.nome, AVG(Golo.idEvento) AS avg_golos
FROM MarcaGolo
INNER JOIN Golo ON MarcaGolo.idGolo = Golo.idEvento
INNER JOIN Evento ON Golo.idEvento = Evento.idEvento
INNER JOIN Jogo ON Evento.idJogo = Jogo.idJogo
INNER JOIN PavilhaoJogo ON Jogo.idJogo = PavilhaoJogo.idJogo
INNER JOIN Pavilhao ON PavilhaoJogo.idPavilhao = Pavilhao.idPavilhao
INNER JOIN Jogador ON MarcaGolo.idJogador = Jogador.idPessoa
WHERE Pavilhao.nome = 'Dragão Arena'
GROUP BY Jogador.nome
ORDER BY avg_golos DESC
LIMIT 10;
