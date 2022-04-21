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
codu char(3) not null,
nome char(40) not null,
email char(30) not null unique,
primary key(codu));


create table cliente(
codu char(3) not null,
codc char(3) not null unique,
cpf char(11) not null unique,
rg char(10) not null,
primary key(codc),
foreign key(codu) references usuario);

create table lojista(
codu char(3) not null,
codloj char(3) not null unique,
cnpj char(9) not null unique,
primary key(codloj),
foreign key(codu) references usuario
);

create table endereco(
code char(3) not null,
cep char(8) not null,
numero char(5) not null,
uf char(2) not null,
complemento char(30),
primary key(code)
);

create table filial(
codloj char(3) not null,
codfil char(3) not null,
numero_filial int not null,
code char(3) not null,
primary key(codfil),
foreign key(codloj) references lojista,
foreign key(code) references endereco
);

create table endereco_cliente(
codc char(3) not null,
code char(3) not null,
principal bool not null,
primary key(codc, code),
foreign key(codc) references cliente,
foreign key(code) references endereco
);

create table fornecedor(
nome char(20) not null,
primary key(nome));

create table categoria(
codcat char(3) not null,
nome char(20) not null unique,
primary key(codcat)
);

create table produto(
codp char(3) not null,
nome char(30) not null,
modelo char(20) not null,
fornecedor char(20) not null,
primary key(codp),
foreign key(fornecedor) references fornecedor
);

create table categoria_produto(
codp char(3) not null,
codcat char(3) not null,
primary key(codp,codcat),
foreign key(codp) references produto,
foreign key(codcat) references categoria
);

create table produto_vendido(
codfil char(3) not null,
codp char(3) not null,
codpv char(3) not null,
estoque int not null check (estoque>=0),
preco numeric(5,2) not null check (preco >= 0),
primary key(codpv),
foreign key(codfil) references filial,
foreign key(codp) references produto
);

create table avaliacao(
codc char(3) not null,
codp char(3) not null,
nota int not null check (nota>=0 and nota<=5),
descricao char(140) not null,
primary key (codc, codp),
foreign key (codc) references cliente,
foreign key (codp) references produto
);

create table carrinho(
codcar char(3) not null,
codc char(3) not null,
primary key (codcar),
foreign key (codc) references cliente
);

create table produtos_carrinho(
codcar char(3) not null,
codp char(3) not null,
preco numeric(5,2) not null check (preco>0),
frete numeric(5,2) not null check (frete>=0),
primary key(codcar,codp),
foreign key(codcar) references carrinho,
foreign key(codp) references produto
);

create table pedido(
codped char(3) not null,
codc char(3) not null,
preco numeric(5,2) not null check (preco>0),
metodo_pagamento char(6) not null check(metodo_pagamento in ('cartao','boleto')),
data_compra date not null,
primary key(codped),
foreign key(codc) references cliente
);

create table produto_pedido(
codped char(3) not null,
codp char(3) not null,
preco numeric(5,2) not null check (preco>0),
frete numeric(5,2) not null check (frete>=0),
primary key(codped,codp),
foreign key(codped) references pedido,
foreign key(codp) references produto
);

-- Criando usuarios
insert into usuario values ('u01','Fulano Silva', 'fulano@gmail.com');
insert into usuario values ('u02','Ciclano Costa','ciclano@gmail.com');
insert into usuario values ('u03','Fulano Santos','fulano123@gmail.com');
insert into usuario values ('u04','Ricardo Eletro','ricardo@eletro.com');
insert into usuario values ('u05','Loja de Esportes','lojadeesportes@esportes.com');

-- Criando clientes
insert into cliente values('u01','c01','99999999901','9999999901');
insert into cliente values('u02','c02','99999999902','9999999902');
insert into cliente values('u03','c03','99999999903','9999999903');

-- Criando lojistas
insert into lojista values('u04','l01','000000001');
insert into lojista values('u05','l02','000000002');

-- Criando enderecos
insert into endereco values('e01','15053320','2500','rs');
insert into endereco values('e02','15053321','1200','rs');
insert into endereco values('e03','15053322','178','sc');
insert into endereco values('e04','15053323','900','ac');
insert into endereco values('e05','15053324','123','ba');
insert into endereco values('e06','15053325','1200','ce');
insert into endereco values('e07','15053326','9890','sp');
insert into endereco values('e08','15053327','9090','rs','apto 12');
insert into endereco values('e09','15053328','9090','rs','apartamento 51');
insert into endereco values('e10','15053329','751','sp');
insert into endereco values('e11','15053331','451','rj');
insert into endereco values('e12','15053332','2051','rj');

-- Enderecos Clientes
insert into endereco_cliente values('c01','e01',true);
insert into endereco_cliente values('c01','e02',false);
insert into endereco_cliente values('c02','e03',true);
insert into endereco_cliente values('c03','e07',true);
insert into endereco_cliente values('c03','e08',false);

-- Filias
insert into filial values('l01','f01','1','e06');
insert into filial values('l01','f02','2','e04');
insert into filial values('l01','f03','3','e05');
insert into filial values('l01','f04','4','e10');
insert into filial values('l02','f05','1','e11');
insert into filial values('l02','f06','2','e12');

-- Categoria
insert into categoria values('c01','celular');
insert into categoria values('c02','televisor');
insert into categoria values('c03','liquidificador');
insert into categoria values('c04','processador');
insert into categoria values('c05','eletrodomestico');
insert into categoria values('c06','eletronico');
insert into categoria values('c07','roupa');
insert into categoria values('c08','tenis');
insert into categoria values('c09','camiseta');
insert into categoria values('c10','chuteira');

-- Fornecedor
insert into fornecedor values('tramontina');
insert into fornecedor values('samsung');
insert into fornecedor values('mondial');
insert into fornecedor values('puma');
insert into fornecedor values('adidas');
insert into fornecedor values('nike');

-- Produtos
insert into produto values('p01','galaxy 12','128gb','samsung');
insert into produto values('p02','galaxy 12','64gb','samsung');
insert into produto values('p03','air fryer','5l','tramontina');
insert into produto values('p04','air fryer','5l','mondial');
insert into produto values('p05','air fryer','3l','mondial');
insert into produto values('p06','mixer','preto','mondial');
insert into produto values('p07','mixer','vermelho','mondial');
insert into produto values('p08','camisa gremio','G','puma');
insert into produto values('p09','camisa inter','G','nike');
insert into produto values('p10','camisa vasco','M','adidas');
insert into produto values('p11','chuteira next','38','nike');
insert into produto values('p12','chuteira next','39','nike');
insert into produto values('p13','chuteira next','41','nike');
insert into produto values('p15','ultraboost','41','adidas');
insert into produto values('p16','ultraboost','34','adidas');




