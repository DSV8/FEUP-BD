CREATE TRIGGER maxplayoffs
AFTER INSERT ON JogoPlayoff
FOR EACH ROW
BEGIN
   SELECT
      CASE
         WHEN (SELECT COUNT(*) FROM JogoPlayoff) > 7 THEN
            RAISE(ABORT, 'O número máximo de jogos nos Playoffs é 7.')
      END;
END;