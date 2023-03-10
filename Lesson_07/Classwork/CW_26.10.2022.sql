show databases;

create database Group_35_36;

use Group_35_36;

create table Example (
id integer primary key,
first_name varchar(128),
last_name varchar(128)

);

create table Example_2 (
id integer primary key,
first_name varchar(128),
last_name varchar(128)

);

select * from example;

show tables;

drop database Group_35_36;

drop table example_2;

select * from example;

insert into example (id, first_name, last_name) values (1, 'Oleg', 'Ivanov');

insert into example (id, first_name, last_name) values (2, 'Anna', 'Petrova'),
													   (3, 'Ivan', 'Orlov'),
													   (4, 'Nelli', 'Efremyan'),
                                                       (5, 'Tamara', 'Gracheva');
                                                       
insert into example (first_name, id, last_name) values ('Petr', 6, 'Sidorov');      

/* 1. Создать таблицу goods (товары) с полями:
- id (уникальное значение, не null)
- title (cтрока максимум 30 символов)
- quantity (число больше 0)
- price
- in_stock (символ (Y/N)) 
2. Заполните созданную таблицу данными, минимум 5 строк. */

create table Goods (
	id integer primary key,
    title varchar(30),
    quantity integer CHECK(quantity > 0),
    price varchar(30),
    in_stock char(1) CHECK (in_stock in ('Y', 'N'))
);

insert into Goods (id, title, quantity, price, in_stock) values (1, 'Bluse', 30, '20$', 'Y'),
                                                                (2, 'T-Shirt', 20, '10$', 'Y'),
                                                                (3, 'Hut', 15, '8$', 'N'),
                                                                (4, 'Scharf', 10, '25$', 'Y'),
                                                                (5, 'Bag', 40, '40$', 'Y');
                                                                
select * from Goods;       

select id, title, price 
from Goods
where price > '10$';
                                                         

select id, title, in_stock
from Goods
where in_stock in ('Y');

delete from Goods
where id = 5;

delete from Goods;

set sql_safe_updates = 0;

create table Goods_2 (
	id integer primary key auto_increment,
    title varchar(30),
    quantity integer CHECK(quantity > 0),
    price integer default 0,
    in_stock char(1) CHECK (in_stock in ('Y', 'N'))
);

insert into Goods_2 (title, quantity, in_stock) values ('Bluse', 30, 'Y'),
															  ('T-Shirt', 20, 'Y'),
															  ('Hut', 15, 'N'),
															  ('Scharf', 10, 'Y'),
															  ('Bag', 40, 'Y');
                                                            
select * from Goods_2;   

delete from Goods_2; 

truncate Goods_2;   

drop table Goods_2;   
