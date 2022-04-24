-- 1 Como um lojista, quero saber todos os produtos vendidos por minhas filiais
select
	pv.numero_filial,
	p.nome,
	pv.preco,
	p.modelo
from
	produto_vendido_por_filial pv
	join produto p using(codp)
where
	pv.nome = 'Ricardo Eletro';

-- 2 Como um lojista, quero saber quais filiais estao com um rendimento acima de um certo valor
select
	nome,
	numero_filial,
	sum(pc.preco)
from
	filial_lojista fl natural
	join produto_vendido pv
	join produtos_carrinho pc using(codpv)
	join carrinho c using(codcar, codc)
where
	c.finalizado = true
	and nome = 'Ricardo Eletro'
group by
	nome,
	numero_filial
having
	sum(pc.preco) > 4000;

-- 3 Quero premiar meus clientes fieis, ou seja, clientes que apenas compraram comigo
select
	distinct c.codu as cliente_fiel
from
	cliente c
	join pedido p using(codc)
	join carrinho c2 using(codcar, codc)
	join produtos_carrinho pc using(codcar, codc)
	join produto_vendido pv using(codpv)
	join filial_lojista using (codfil)
where
	c.codu not in (
		select
			c.codu
		from
			cliente c
			join pedido p using(codc)
			join carrinho c2 using(codcar, codc)
			join produtos_carrinho pc using(codcar, codc)
			join produto_vendido pv using(codpv)
			join filial_lojista fl using (codfil)
		where
			fl.nome <> 'Ricardo Eletro'
	);

--4 - Quero saber todos os lojistas que possuem filias apenas no RS(ou um estado especifico)
select
	distinct nome as lojista
from
	filial_lojista
	join endereco e using(code)
where
	codfil not in (
		select
			codfil
		from
			filial f2
			join endereco e2 using(code)
		where
			uf <> 'rs'
	);

--Consulta com NOT EXISTS (revisar essa aqui com cuidado)
--5 - Quero saber se existe um {cliente} que nao realizou compras nem nenhuma filila de um  {lojista}
-- Tem que ser da forma TODOS ou NENHUM
select
	distinct c.codu
from
	cliente c
	join pedido p using(codc)
where
	not exists (
		select
			*
		from
			filial_lojista
			join produto_vendido pv2 using(codfil)
			join produtos_carrinho pc2 using(codpv)
			join carrinho c2 using(codcar, codc)
		where
			c2.finalizado = true
			and c2.codc = c.codc
			and nome = 'Tche Eletro'
	);

-- Desejo saber todos os lojistas que só tem filiais em estados onde nao há filiais de outros lojistas
select
	distinct fl.nome
from
	filial_lojista fl
where
	not exists(
		select
			*
		from
			filial f
			join endereco e using(code)
		where
			f.codloj <> fl.codloj
			and e.uf in (
				select
					distinct e2.uf
				from
					filial f2
					join endereco e2 using(code)
				where
					f2.codloj = fl.codloj
			)
	) --6 - Quero saber todos os produtos comprados pro mim(um cliente) 
select
	p.nome,
	p.modelo,
	p.fornecedor,
	pc.preco,
	pc.data_compra
from
	produtos_comprados pc
	join produto_vendido pv using(codpv)
	join produto p using(codp)
where
	codc = '1';

--7 - Quero saber se já comprei um {produto} antes
select
	count(pv.codp) > 0
from
	produtos_comprados pc
	join produto_vendido pv using(codpv)
where
	codc = '1'
	and codp = '1';

--8 - Eu como um cliente quero poder ver todos os produtos vendidos por um {fornecedor}
select
	p.nome,
	p.modelo
from
	produto p
	join fornecedor f on p.fornecedor = f.nome
where
	fornecedor = 'samsung';

--9 - Desejando saber a abraangencia de um {fornecedor}, quero todas as {categorias} que ele vende
select
	c.nome
from
	produto p
	join fornecedor f on p.fornecedor = f.nome
	join categoria_produto cp using(codp)
	join categoria c using(codcat)
where
	fornecedor = 'adidas'
group by
	c.nome;

--10 - Desejando saber qual filial esta mais perto do cliente, quero saber {filail} no mesmo uf que o {cliente}
select
	numero_filial
from
	filial_lojista
	join endereco e using(code)
where
	nome = 'Tche Produtos'
	and e.uf in (
		select
			distinct e2.uf
		from
			usuario u2
			join cliente c using(codu)
			join endereco_cliente ec using(codc)
			join endereco e2 using(code)
	);