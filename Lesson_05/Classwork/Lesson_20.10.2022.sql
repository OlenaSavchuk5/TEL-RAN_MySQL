-- Однострочный комментарий

/*
Многострочный
комментарий
*/

show databases;
create database Group_35_36_1;
use Group_35_36_1;

create table goods (
	id integer primary key auto_increment,
  	title varchar(30),
  	quantity integer check(quantity > 0),
  	price integer,
  	in_stock char(1) check(in_stock in('Y', 'N'))
);

create table users (
	id integer primary key,
    firstname varchar(64),
    lastname varchar(64),
    age integer
);

create table users_2 (
	id integer primary key,
    firstname varchar(64),
    lastname varchar(64),
    age int
);

select * from goods;
show tables;

drop table goods;
drop database Group_35_36_1;

insert into goods (title, quantity, price, in_stock) values ('Apple', 3, 500, 'Y');

insert into goods (title, quantity, price, in_stock) values ('Lemon', 2, 300, 'N'), 
															('Grapes', 5, 400, 'Y'), 
															('Lime', 8, 600, 'Y'),
															('Orange', 3, 350, 'N');

insert into goods (title, price, in_stock) values ('Banana', 500, 'Y');

select 
	title,
    price
from goods
where price >= 500;

delete from goods; -- очищает таблицу
truncate goods; -- приводит таблицу к изначальному состоянию

set sql_safe_updates = 1;


/*
1. Создать таблицу Users с полями:
id уникальное не нулл авто инкремент
fistname строка 64
lastname строка 64
age целое число больше или равно 18
gender символ m или f

2. заполнить таблицу 6-ю строками
*/

drop table if exists Users;
create table Users (
	id integer primary key auto_increment,
    firstname varchar(64),
    lastname varchar(64),
    age integer check (age >= 18),
    gender char(1) check(gender in('m', 'f'))
);

insert into users (firstname, lastname, age, gender) value ('Olga', 'Petrova', 18, 'f'),
															('Ivan', 'Sidorov', 22, 'm'),
                                                            ('Irina', 'Sokolova', 50, 'f'),
                                                            ('Nelli', 'Efremyan', 27, 'f'),
                                                            ('Anton', 'Grishin', 45, 'm');

select * from users;

-- вывести всех пользователей старше 30 лет

select
	*
from users
where age > 30;

-- вывести всех пользователей в возрасте между 40 и 45 (включая концы)

select
	*
from users
where age between 40 and 45;

-- вывести всех пользователей, у которых имя начинается на I

select
	*
from users
where firstname like 'I%';

-- вывести всех мужчин

select
	*
from users
where gender = 'm';
												
