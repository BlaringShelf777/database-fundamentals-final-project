
-- 1

select pv.numero_filial  ,p.nome, pv.preco , p.modelo 
from produto_vendido_por_filial pv join produto p using(codp) 
where pv.nome = 'Ricardo Eletro'


-- 2
select nome ,numero_filial, sum(pc.preco) 
from filial_lojista fl natural join produto_vendido pv join produtos_carrinho pc using(codpv) join carrinho c using(codcar,codc) 
where c.finalizado = true
group by nome, numero_filial 
having sum(pc.preco) > 500

-- 3
select distinct u1.codu as cliente_fiel
from usuario u1 natural join cliente c join pedido p using(codc) join carrinho c2 using(codcar,codc) join produtos_carrinho pc using(codcar,codc) join produto_vendido pv using(codpv)
	join filial f using (codfil) join lojista l using(codloj) join usuario u2 on l.codu = u2.codu
where u1.codu not in (
	select u.codu 
	from usuario u natural join cliente c join pedido p using(codc) join carrinho c2 using(codcar,codc) join produtos_carrinho pc using(codcar,codc) join produto_vendido pv using(codpv)
	join filial f using (codfil) join lojista l using(codloj) join usuario u2 on l.codu = u2.codu
	where u2.nome  <> 'Ricardo Eletro'
)


-- 4




-- adicionar um carrinho para usuario 1 nao aparecer
