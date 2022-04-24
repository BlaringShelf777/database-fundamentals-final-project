-- 1

select
	pv.numero_filial ,
	p.nome,
	pv.preco ,
	p.modelo
from
	produto_vendido_por_filial pv
join produto p
		using(codp)
where
	pv.nome = 'Ricardo Eletro'

-- 2
select
	nome ,
	numero_filial,
	sum(pc.preco)
from
	filial_lojista fl natural
join produto_vendido pv
join produtos_carrinho pc
		using(codpv)
join carrinho c
		using(codcar,
	codc)
where
	c.finalizado = true
group by
	nome,
	numero_filial
having
	sum(pc.preco) > 500
	-- 3
select
	distinct u1.codu as cliente_fiel
from
	usuario u1 natural
join cliente c
join pedido p
		using(codc)
join carrinho c2
		using(codcar,
	codc)
join produtos_carrinho pc
		using(codcar,
	codc)
join produto_vendido pv
		using(codpv)
join filial f
		using (codfil)
join lojista l
		using(codloj)
join usuario u2 on
	l.codu = u2.codu
where
	u1.codu not in (
	select
		u.codu
	from
		usuario u natural
	join cliente c
	join pedido p
			using(codc)
	join carrinho c2
			using(codcar,
		codc)
	join produtos_carrinho pc
			using(codcar,
		codc)
	join produto_vendido pv
			using(codpv)
	join filial f
			using (codfil)
	join lojista l
			using(codloj)
	join usuario u2 on
		l.codu = u2.codu
	where
		u2.nome <> 'Ricardo Eletro'
)
	--4 - Quero saber todos os lojistas que possuem filias apenas no RS(ou um estado especifico)

select
	distinct u.nome as lojista
from
	usuario u
join lojista l
		using(codu)
join filial f
		using(codloj)
join endereco e
		using(code)
where
	f.codfil not in (
	select
		codfil
	from
		filial f2
	join endereco e2
			using(code)
	where
		uf <> 'rs'
		);
--
--Consulta com NOT EXISTS (revisar essa aqui com cuidado)
--5 - Quero saber se existe um {cliente} que nao realizou compras num {lojista}
	
	
select distinct u.codu 
from
	usuario u 
join cliente c using(codu)
join pedido p using(codc)
join carrinho  using(codcar, codc)
join produtos_carrinho pc using(codcar, codc)
join produto_vendido pv using(codpv)
join filial f using(codfil)
where not exists (
	select *
	from 
		usuario u2
	join lojista l using(codu)
	join filial f2 using (codloj)
	join produto_vendido pv2 using(codfil)
	join produtos_carrinho pc2 using(codpv)
	join carrinho c2 using(codcar, codc)
	where c2.finalizado = true and c2.codc = c.codc 
		and u2.nome = 'Ricardo Eletro'
)
	
--Consultas com visoes
--
--Visao definida:
--
--- Produtos vendidos (pedido join produtos_carrinhos join produto_vendido join produto)
--
--6 - Quero saber todos os produtos comprados pro mim(um cliente) 

select p.nome , p.modelo , p.fornecedor , pc.preco, pc.data_compra
from produtos_comprados pc join produto_vendido pv using(codpv) join produto p using(codp)
where codc='1';


--7 - Quero saber se já comprei um {produto} antes
--
--8 - Eu como um cliente quero poder ver todos os produtos vendidos por um {fornecedor}
--9 - Desejando saber a abraangencia de um {fornecedor}, quero todas as {categorias} que ele vende
--10 - Desejando saber qual filial esta mais perto do cliente, quero saber {filail} no mesmo uf que o {cliente}
-- adicionar um carrinho para usuario 1 nao aparecer
