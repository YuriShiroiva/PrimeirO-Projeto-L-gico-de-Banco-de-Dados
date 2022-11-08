-- criação do bancos de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
          idClient int auto_increment primary key,
          Fname varchar(10),
          Minit char(3),
          Lname varchar(20),
          CPF char(11) not null,
          Address varchar(30),
          constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment = 1;
desc clients;
-- criar tabela produto
-- size = dimensão do produto

create table product(
          idProduct int auto_increment primary key,
          Pname varchar(10) not null,
          classification_kids bool default false,
          category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos') not null,
		  avaliação float default 0,
          size varchar(10)
);

create table payments(
          idClient int,
          idPayment int,
          typePayment enum('Boleto','Cartão de crédito','Cartão de débito'),
		  limitAvailable float,
          primary key (idClient, id_payment)
);


-- criar tabela pedido

create table orders(
          idOrder int auto_increment primary key,
          idOrderClient int,
          orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
          orderDescripition varchar(255),
		  sendValue float default 10,
          paymentCash bool default false,
          constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);
desc orders;

-- criar tabela estoque
create table productStorage(
          idProdStorage int auto_increment primary key,
          storageLocation varchar(255),
          quantity int default 0
);

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
          CNPJ char(15) not null,
          CPF char(9),
          location varchar(255),
          contact char(11) not null,
          constraint unique_cnpj_seller unique (CNPJ),
          constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
          idPseller int,
          idPproduct int,
          prodQuantity int default 1,
          primary key (idPproduct, idPseller),
          constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
          constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
desc productSeller;

create table productOrder(
          idPOproduct int,
          idPOorder int,
          poQuantity int default 1,
          poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
          primary key (idPOorder, idPOproduct),
          constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
          constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
          idLproduct int,
          idLstorage int,
          location int default 1,
          primary key (idLproduct, idLstorage),
          constraint fk_storoge_location_product foreign key (idLproduct) references product(idProduct),
          constraint fk_storoge_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

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
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
