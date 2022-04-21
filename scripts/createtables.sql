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
email char(30) not null unique,
primary key(codu));


create table cliente(
codu char(3) not null,
codc char(3) not null unique,
cpf char(11) not null unique,
rg char(10) not null,
code char(3) not null,
primary key(codc),
foreign key(codu) references usuario);

create table lojista(
codu char(3) not null,
codloj char(3) not null unique,
cnpj char(9) not null unique,
nome_fantasia char(30) not null,
primary key(codu),
foreign key(codu) references usuario
);

create table endereco(
code char(3) not null,
cep char(8) not null,
numero char(5) not null,
complemento char(30),
uf char(2) not null,
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

