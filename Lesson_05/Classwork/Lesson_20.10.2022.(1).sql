-- Однострочный комментарий

/*
Многострочный
комментарий
*/

show databases;
create database Group_35_36_2;
use Group_35_36_2;

create table goods (
	id integer primary key,
  	title varchar(30),
  	quantity integer check(quantity > 0),
  	price integer,
  	in_stock char(1) check(in_stock in ('Y', 'N'))
);

create table goods_2 (
	id integer primary key,
  	title varchar(30),
  	quantity integer check(quantity > 0),
  	price integer,
  	in_stock char(1) check(in_stock in ('Y', 'N'))
);

show tables; 
select * from goods;

create table jobs (
	id integer,
    title varchar(64)
);

drop table jobs;
drop database Group_35_36_2;

insert into goods (id, title, quantity, price, in_stock) values (1, 'Apple', 3, 300, 'Y');
insert into goods (id, title, quantity, price, in_stock) values (2, 'Lemon', 5, 500, 'N'), 
																(3, 'Lime', 6, 700, 'Y'), 
                                                                (4, 'Banana', 8, 300, 'Y'), 
                                                                (5, 'Grapes', 4, 350, 'N');

insert into goods (id, title) values (6, 'Orange');
                                                                
select * from goods;

delete from goods
where id = 3;
