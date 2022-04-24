drop view if exists filial_lojista;
drop view if exists produto_vendido_por_filial;
drop view if exists produtos_comprados;
drop table if exists produto_pedido;
drop table if exists pedido;
drop table if exists produtos_carrinho;
drop table if exists carrinho;
drop table if exists avaliacao;
drop table if exists categoria_produto;
drop table if exists categoria;
drop table if exists produto_vendido;
drop table if exists filial;
drop table if exists produto;
drop table if exists fornecedor;
drop table if exists endereco_cliente;
drop table if exists lojista;
drop table if exists endereco;
drop table if exists cliente;
drop table if exists usuario;


create table usuario(
codu bigserial not null,
nome char(40) not null,
email char(30) not null unique,
primary key(codu));


create table cliente(
codu bigserial not null,
codc bigserial not null unique,
cpf char(11) not null unique,
rg char(10) not null unique,
primary key(codc),
foreign key(codu) references usuario);

create table lojista(
codu bigserial not null,
codloj bigserial not null unique,
cnpj char(9) not null unique,
primary key(codloj),
foreign key(codu) references usuario
);

create table endereco(
code bigserial not null,
cep char(8) not null,
numero char(5) not null,
uf char(2) not null,
complemento char(30),
primary key(code)
);

create table filial(
codloj bigserial not null,
codfil bigserial not null,
numero_filial int not null,
code bigserial not null,
primary key(codfil),
foreign key(codloj) references lojista,
foreign key(code) references endereco
);

create table endereco_cliente(
codc bigserial not null,
code bigserial not null,
principal bool not null,
primary key(codc, code),
foreign key(codc) references cliente,
foreign key(code) references endereco
);

create table fornecedor(
nome char(20) not null,
primary key(nome));

create table categoria(
codcat bigserial not null,
nome char(20) not null unique,
primary key(codcat)
);

create table produto(
codp bigserial not null,
nome char(30) not null,
modelo char(20) not null,
fornecedor char(20) not null,
primary key(codp),
foreign key(fornecedor) references fornecedor
);

create table categoria_produto(
codp bigserial not null,
codcat bigserial not null,
primary key(codp,codcat),
foreign key(codp) references produto,
foreign key(codcat) references categoria
);

create table produto_vendido(
codfil bigserial not null,
codp bigserial not null,
codpv bigserial not null,
estoque int not null check (estoque>=0),
preco numeric(5) not null check (preco >= 0),
primary key(codpv),
foreign key(codfil) references filial,
foreign key(codp) references produto
);

create table avaliacao(
codc bigserial not null,
codp bigserial not null,
nota int not null check (nota>=0 and nota<=5),
descricao char(140),
primary key (codc, codp),
foreign key (codc) references cliente,
foreign key (codp) references produto
);

create table carrinho(
codcar bigserial not null,
codc bigserial not null,
finalizado bool not null,
primary key (codcar,codc),
foreign key (codc) references cliente
);

create table produtos_carrinho(
codcar bigserial not null,
codc bigserial not null,
codpv bigserial not null,
preco numeric(5) not null check (preco>0),
frete numeric(5) not null check (frete>=0),
primary key(codcar,codpv),
foreign key(codcar,codc) references carrinho,
foreign key(codpv) references produto_vendido,
foreign key (codc) references cliente
);

create table pedido(
codcar bigserial not null,
codc bigserial not null,
metodo_pagamento char(6) not null check(metodo_pagamento in ('cartao','boleto')),
data_compra date not null,
primary key(codcar,codc),
foreign key(codcar,codc) references carrinho,
foreign key(codc) references cliente
);


-- Criando usuarios
insert into usuario values ('01','Fulano Silva', 'fulano@gmail.com');
insert into usuario values ('02','Ciclano Costa','ciclano@gmail.com');
insert into usuario values ('03','Fulano Santos','fulano123@gmail.com');
insert into usuario values ('04','Ricardo Eletro','ricardo@eletro.com');
insert into usuario values ('05','Loja de Esportes','lojadeesportes@esportes.com');
insert into usuario values ('06','Tche Produtos','tche_produtos@gmail.com');

-- Criando clientes
insert into cliente values('01','01','99999999901','9999999901');
insert into cliente values('02','02','99999999902','9999999902');
insert into cliente values('03','03','99999999903','9999999903');

-- Criando lojistas
insert into lojista values('04','01','000000001');
insert into lojista values('05','02','000000002');
insert into lojista values('06','03','000000003');

-- Criando enderecos
insert into endereco values('01','15053320','2500','rs');
insert into endereco values('02','15053321','1200','rs');
insert into endereco values('03','15053322','178','sc');
insert into endereco values('04','15053323','900','ac');
insert into endereco values('05','15053324','123','ba');
insert into endereco values('06','15053325','1200','ce');
insert into endereco values('07','15053326','9890','sp');
insert into endereco values('08','15053327','9090','rs','apto 12');
insert into endereco values('09','15053328','9090','rs','apartamento 51');
insert into endereco values('10','15053329','751','sp');
insert into endereco values('11','15053331','451','rj');
insert into endereco values('12','15053332','2051','rj');
insert into endereco values('13','15053333','2009','rs');

-- Enderecos Clientes
insert into endereco_cliente values('01','01',true);
insert into endereco_cliente values('01','02',false);
insert into endereco_cliente values('02','03',true);
insert into endereco_cliente values('03','07',true);
insert into endereco_cliente values('03','08',false);

-- Filias
insert into filial values('01','01','1','06');
insert into filial values('01','02','2','04');
insert into filial values('01','03','3','05');
insert into filial values('02','04','1','11');
insert into filial values('02','05','2','12');
insert into filial values('03','06','1','13');

-- Categoria
insert into categoria values('01','celular');
insert into categoria values('02','televisor');
insert into categoria values('03','air fryer');
insert into categoria values('04','processador');
insert into categoria values('05','eletrodomestico');
insert into categoria values('06','eletronico');
insert into categoria values('07','roupa');
insert into categoria values('08','tenis');
insert into categoria values('09','camiseta');
insert into categoria values('10','chuteira');

-- Fornecedor
insert into fornecedor values('tramontina');
insert into fornecedor values('samsung');
insert into fornecedor values('mondial');
insert into fornecedor values('puma');
insert into fornecedor values('adidas');
insert into fornecedor values('nike');

-- Produtos
insert into produto values('01','galaxy 12','128gb','samsung');
insert into produto values('02','galaxy 12','64gb','samsung');
insert into produto values('03','air fryer gold','5l','tramontina');
insert into produto values('04','air fryer premium','5l','mondial');
insert into produto values('05','air fryer','3l','mondial');
insert into produto values('06','mixer','preto','mondial');
insert into produto values('07','mixer','vermelho','mondial');
insert into produto values('08','camisa gremio','G','puma');
insert into produto values('09','camisa inter','G','nike');
insert into produto values('10','camisa vasco','M','adidas');
insert into produto values('11','chuteira next','38','nike');
insert into produto values('12','chuteira next','39','nike');
insert into produto values('13','chuteira next','41','nike');
insert into produto values('15','ultraboost','41','adidas');
insert into produto values('16','ultraboost','34','adidas');


-- Categoria Produtos
insert into categoria_produto values('01','01');
insert into categoria_produto values('01','06');
insert into categoria_produto values('02','01');
insert into categoria_produto values('02','06');
insert into categoria_produto values('03','03');
insert into categoria_produto values('03','05');
insert into categoria_produto values('04','03');
insert into categoria_produto values('04','05');
insert into categoria_produto values('05','03');
insert into categoria_produto values('05','05');
insert into categoria_produto values('06','04');
insert into categoria_produto values('06','05');
insert into categoria_produto values('07','04');
insert into categoria_produto values('07','05');
insert into categoria_produto values('08','07');
insert into categoria_produto values('08','09');
insert into categoria_produto values('09','07');
insert into categoria_produto values('09','09');
insert into categoria_produto values('10','07');
insert into categoria_produto values('10','09');
insert into categoria_produto values('11','07');
insert into categoria_produto values('11','08');
insert into categoria_produto values('11','09');
insert into categoria_produto values('12','07');
insert into categoria_produto values('12','08');
insert into categoria_produto values('12','09');
insert into categoria_produto values('13','07');
insert into categoria_produto values('13','08');
insert into categoria_produto values('13','09');
insert into categoria_produto values('15','07');
insert into categoria_produto values('15','08');
insert into categoria_produto values('16','07');
insert into categoria_produto values('16','08');


-- Produtos Vendidos
insert into produto_vendido values('01','01','01','100','3500.98');
insert into produto_vendido values('01','02','02','30','2700.98');
insert into produto_vendido values('01','03','03','1000','799.00');
insert into produto_vendido values('01','04','04','1100','350.00');
insert into produto_vendido values('01','05','05','0','299.00');
insert into produto_vendido values('01','06','06','390','500.00');
insert into produto_vendido values('01','07','07','10','400.79');

insert into produto_vendido values('02','02','08','5','3000.00');
insert into produto_vendido values('02','03','09','450','799.00');
insert into produto_vendido values('02','04','10','981','250.00');
insert into produto_vendido values('02','05','11','192','200.00');

insert into produto_vendido values('03','03','12','10','899.00');
insert into produto_vendido values('03','04','13','11','340.00');
insert into produto_vendido values('03','05','14','39','294.00');
insert into produto_vendido values('03','06','15','129','278.00');
insert into produto_vendido values('03','07','16','3','400.79');

insert into produto_vendido values('04','08','17','100','250.00');
insert into produto_vendido values('04','09','18','160','210.00');
insert into produto_vendido values('04','10','19','300','300.00');
insert into produto_vendido values('04','15','20','9','900.79');

insert into produto_vendido values('05','11','21','400','390.00');
insert into produto_vendido values('05','12','22','200','390.00');
insert into produto_vendido values('05','13','23','600','340.00');
insert into produto_vendido values('05','15','24','200','899.99');
insert into produto_vendido values('05','16','25','100','810.39');

---insert into produto_vendido values(codfil,codp,codpv,estoque,preco)/
insert into produto_vendido values('06','08','26','300','299.99');
insert into produto_vendido values('06','09','27','400','199.99');

-- Avaliacoes 
insert into avaliacao values('01','01','4','Viciou a bateria! :C');
insert into avaliacao values('01','03','5','Ajudou muito!');
insert into avaliacao values('01','06','3','Lamina sem fio :/');

insert into avaliacao values('02','01','5');
insert into avaliacao values('02','04','4');

insert into avaliacao values('03','09','5');
insert into avaliacao values('03','12','2');

-- Carrinho
insert into carrinho values('01','01',true);
insert into carrinho values('02','01',true);
insert into carrinho values('03','01',false);


insert into carrinho values('01','02',true);

-- Produtos Carrinho
insert into produtos_carrinho values('01','01','07','400.79','0.00');
insert into produtos_carrinho values('01','01','08','3200.00','15.00');


insert into produtos_carrinho values('02','01','01','4000','17.98');
insert into produtos_carrinho values('02','01','25','850.27','32.00');

insert into produtos_carrinho values('01','02','01','4300','0.00');

-- Pedidos
-- Ideia, tirar preço total do banco, usar agrupamento para isso
insert into pedido values('01','01','cartao','2021-01-01');
insert into pedido values('01','02','boleto','2021-11-30');
insert into pedido values('02','01','cartao','2021-11-30');


-- Produtos comprados
create view produtos_comprados
as select *
from 
	pedido
join carrinho using(codcar,codc)
join produtos_carrinho using(codcar,codc)
where carrinho.finalizado = true;

-- Produto vendido por filial
create view produto_vendido_por_filial 
as select * 
from usuario natural join lojista natural join filial natural join produto_vendido;


create view filial_lojista
as select *
from usuario natural join lojista natural join filial;





