-- criação do banco de dados para o cenáeio de E-commerce
create database ecommerce;
use ecommerce;

-- criar uma tabela cliente
create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname char(3),
CPF char(11) not null,
Address varchar(30),
constraint unique_cpf_client unique (CPF)
);

desc clients;

-- criar tabela produto 
-- size = dimensão do produto
create table product(
idProduct int auto_increment primary key,
Pname varchar(10) not null,
classification_kids bool default false,
category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
avaliação float default 0,
size varchar(10)
);

desc product;

-- criar tabela pagamento
create table payments(
idPayment int,
idClient int,
typePayment enum('Boleto', 'Dois cartões'), 
limitAvailable float,
primary key(idClient, idPayment),
constraint fk_payment_client foreign key (idClient) references clients (idClient)
);

desc payments;

-- criar tabela pedido
drop table orders;
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash boolean default false,
        constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
        );
        
        desc orders;

-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

desc productStorage;

-- criar tabela fornecedor
create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

desc supplier;

-- criar tabela vendedor
create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

desc seller;

-- criar tabela produto/vendedor
create table productSeller(
		idPseller int,
		idPproduct int,
		prodQuantity int default 1,
		primary key (idPseller, idPproduct),
		constraint fk_productorder_seller foreign key (idPseller) references seller(idSeller),
		constraint fk_productorder_product foreign key (idPproduct) references product(idProduct)
	);
    
    desc productSeller;
    
create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);

desc productOrder;

create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar (500) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
		constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

desc storageLocation;

create table productSupplier(
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
		constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)

);

desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc table_constraints;
desc referencial_constraints;



