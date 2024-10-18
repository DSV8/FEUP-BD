SELECT * FROM Playoffs;
SELECT * FROM Desqualificadas;

INSERT INTO Classificacao (nomeClube, ranking, pontos, numJogos, vitorias, empates, derrotas, golosMarcados, golosSofridos, diferencaGolos)
VALUES ('Club A', 6, 15, 5, 5, 0, 0, 15, 5, 10);

SELECT * FROM Playoffs;

INSERT INTO Classificacao (nomeClube, ranking, pontos, numJogos, vitorias, empates, derrotas, golosMarcados, golosSofridos, diferencaGolos)
VALUES ('Club B', 12, 10, 5, 2, 4, 0, 10, 10, 0);

SELECT * FROM Desqualificadas;


-- Testes que devem falhar:
INSERT INTO Classificacao (nomeClube, ranking, pontos, numJogos, vitorias, empates, derrotas, golosMarcados, golosSofridos, diferencaGolos)
VALUES ('Club C', 9, 15, 5, 5, 0, 0, 15, 5, 10);

SELECT * FROM Playoffs;

INSERT INTO Classificacao (nomeClube, ranking, pontos, numJogos, vitorias, empates, derrotas, golosMarcados, golosSofridos, diferencaGolos)
VALUES ('Club D', 11, 10, 5, 2, 4, 0, 10, 10, 0);

SELECT * FROM Desqualificadas;
