Create Trigger R3
Before Insert On Jogo
For Each Row
Begin
    Update Classificacao Set pontos = pontos + 3, numJogos = numJogos + 1, vitorias = vitorias + 1 Where nomeClube = New.vencedor;
    Update Classificacao Set pontos = pontos + 0, numJogos = numJogos + 1, derrotas = derrotas + 1 Where nomeClube = New.derrotado;
End;