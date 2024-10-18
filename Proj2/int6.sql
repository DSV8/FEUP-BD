.mode columns
.headers on
.nullvalue NULL

select Jogador.idPessoa as ID, Jogador.nome as NOME, count(*) as GOLOS
from jogador
join MarcaGolo on MarcaGolo.idJogador = Jogador.idPessoa
group by 1
order by 3 desc
limit 20




	