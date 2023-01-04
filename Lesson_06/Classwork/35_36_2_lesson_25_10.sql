/*
ДЗ:
-- Создайте таблицу goods:
id первичный ключ
title строка 128
quantity строка 128
price целое число
-- Добавьте 10 строк
-- Проверьте содержимое таблицы
-- Найдите товары дешевле 1000
-- Найдите товары, начинающиеся на А
*/

show databases;
use group_35_36_2;

show tables;

drop table goods;

create table goods (
	id integer primary key auto_increment,
    title varchar(128),
    quantity integer,
    price integer
);

select * from goods;

insert into goods (title, quantity, price) values ('Apple', 5, 500),
													('Orange', 7, 1000),
													('Lemon', 3, 700),
													('Lime', 9, 1500),
													('Banana', 15, 200);
select
	*
from goods
where price < 1000;

select
	*
from goods
where title like 'a%';

-- Удалите товары дороже 1000 *

delete from goods
where price > 1000;

set sql_safe_updates = 0;

select * from goods;

-- Очистите всю таблицу *

delete from goods; -- очищает таблицу
truncate goods; -- сбрасывает таблицу до первоначального состояния


create table users (
	id integer primary key auto_increment,
    firstname varchar(128),
    lastname varchar(128),
    age integer check (age >= 18) default 20,
    gender char(1) check (gender in ('m', 'f'))
);

insert into users (firstname, lastname, gender) values ('Anna', 'Ivanova', 'f');
insert into users (firstname, lastname, age, gender) values ('Anton', 'Petrov', 33, 'm');

select * from users;
drop table users;

/*
Создать таблицу students с полями:
id первичный ключ авто-инкремент
firstname строка 128 not null
lastname строка 128 not null
age больше 20
avg_mark число от 0 до 5 значение по умолчанию 3.0
*/

create table students (
	id integer primary key auto_increment,
    firstname varchar(128) not null,
    lastname varchar(128) not null,
    age integer check (age > 20),
    avg_mark numeric(2, 1) check (avg_mark between 0 and 5) default 3.0
);

-- Заполнить таблицу строками (4 шт)

insert into students (firstname, lastname, age, avg_mark) values ('Anna', 'Petrova', 25, 4.5), ('Anton', 'Ivanov', 30, 4.8);
insert into students (firstname, lastname, age) values ('Petr', 'Sidorov', 23), ('Irina', 'Sokolova', 39);

select * from students;
