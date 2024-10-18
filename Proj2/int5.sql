.mode columns
.headers on
.nullvalue NULL

select ID , NOME, sum(AZUL) as AZUL, sum(VERMELHO) as VERMELHO
from(
    select Jogador.idPessoa ID, Jogador.nome NOME, count(*) AZUL, 0 as VERMELHO
    from Jogador
    join AtribuiCartao on AtribuiCartao.idJogador = Jogador.idPessoa 
    join Cartao on Cartao.idEvento = AtribuiCartao.idCartao
    WHERE Cartao.cor = 'Azul' 
    group by 1, 2

UNION

    select Jogador.idPessoa ID, Jogador.nome NOME, 0 as AZUL, count(*) VERMELHO
    from Jogador
    join AtribuiCartao on AtribuiCartao.idJogador = Jogador.idPessoa 
    join Cartao on Cartao.idEvento = AtribuiCartao.idCartao
    WHERE Cartao.cor = 'Vermelho'
    group by 1, 2
)

group by 1, 2
order by 3, 4