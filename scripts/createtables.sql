drop table if exists usuario;
drop table if exists cliente;
drop table if exists endereco;
drop table if exists enderecoCliente;
drop table if exists produto;


create table usuario(
codu char(3) not null,
email char(30) not null unique,
primary key(codu));


create table cliente(
codu char(3) not null,
cpf char(11) not null unique,
rg char(10) not null,
code char(3) not null,
primary key(codu),
foreign key(codu) references usuario);


create table endereco(
code char(3) not null,
cep char(8) not null,
numero char(5) not null,
complemento char(30),
uf char(2) not null,
primary key(code));

create table enderecoCliente(
codc char(3) not null,
code char(3) not null,
principal bool not null,
primary key(codc, code),
foreign key(codc) references cliente,
foreign key(code) references endereco
);


create table produto(
codp char(3) not null,
nome char(30) not null,
modelo char(20) not null,
primary key(codp)
);

