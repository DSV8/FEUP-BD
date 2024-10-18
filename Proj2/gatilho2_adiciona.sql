CREATE TRIGGER update_playoffs_desqualificadas
AFTER INSERT ON Classificacao
FOR EACH ROW
BEGIN
    INSERT INTO Playoffs (idEquipa, nomeClube, ranking)
    SELECT idEquipa, nomeClube, ranking
    FROM Equipa
    WHERE nomeClube = NEW.nomeClube AND ranking <= 8;

    INSERT INTO Desqualificadas (idEquipa, nomeClube, ranking)
    SELECT idEquipa, nomeClube, ranking
    FROM Equipa
    WHERE nomeClube = NEW.nomeClube AND ranking >= 12;
END;
