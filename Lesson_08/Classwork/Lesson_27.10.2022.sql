-- ДЗ
-- Создайте таблицу goods:
-- id первичный ключ автоинкремент
-- title строка 128
-- quantity
-- price целое число

show databases;
use group_35_36_1;

show tables;
drop table goods;

drop table if exists goods;
create table goods (
	id integer primary key auto_increment,
    title varchar(128),
    quantity integer,
    price integer default 100
);

-- Добавьте 10 строк

insert into goods (title, quantity, price) values ('Bike', 5, 1500), 
													('Skate', 3, 750),
                                                    ('Skies', 6, 1100),
                                                    ('Ball', 15, 350),
                                                    ('Skates', 10, 900);

insert into goods (title, quantity) values ('Bike', 5), 
											('Skate', 3);
                                                    
insert into goods (title, quantity) values ('Bike', 5), 
											('Skate', 3),
											('Skies', 6),
											('Ball', 15),
											('Skates', 10);

-- Проверьте содержимое таблицы

select * from goods;

-- Найдите товары дешевле 1000

select 
	* 
from goods
where price < 1000;

-- Найдите товары, начинающиеся на А

select
	*
from goods
where title like 'a%';

-- Удалите товары дороже 1000

delete from goods
where price > 1000;

set sql_safe_update = 0;

-- Очистите таблицу так, чтобы при повторном заполнении автоинкремент добавлял айдишники с 1 

delete from goods;
truncate goods;


-- ALTER TABLE - добавление, удаление или изменение полей в таблице

-- Добавление нового поля
alter table goods
add country varchar(128);

-- Удаление поля
alter table goods
drop column country;

-- Изменение поля (тип данных/ограничение)
alter table goods
modify column price numeric(6, 2);

-- Изменение именя поля
alter table goods
change price product_price integer;

-- Сброс/удаление ограничения
alter table goods
drop check goods_chk_1;


-- UPDATE
-- Изменение данных таблицы
update goods
set price = 1300
where title = 'Bike';

update goods
set price = price / 2
where price < 1000;

update goods
set quantity = quantity * 10;

select * from goods;


-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ
/*
1. Создать таблицу products
id первичный ключ автоинкремент
title строка 128
quantity от 0 до 10
*/

create table products (
	id integer primary key auto_increment,
    title varchar(128),
    quantity integer check (quantity between 0 and 10)
);

-- 2. Добавить несколько строк

insert into products (title, quantity) values ('Apple', 3), ('Orange', 2), ('Banana', 10), ('Pineapple', 7), ('Kiwi', 4);

-- 3. Добавить поле price integer со значение по умолчанию 0

alter table products
add price integer default 0;

-- 4. Изменить тип price на numeric(8, 2)

alter table products
modify column price numeric(8, 2);

-- 5. Измените тип price обратно на integer

alter table products
modify column price integer;

-- 6. Переименуйте поле на item_price

alter table products
change price item_price integer;

-- 7. Удалите поле item_price
alter table products
drop column item_price;

select * from products;


-- Представления (view)
-- Сохраняет не сами данные, а запрос

create view v_quantity as
select
	*
from products
where quantity >= 4;

select 
	* 
from v_quantity 
where title like 'p%';

show tables;
drop view v_quantity;

-- ПРАКТИКА
/*
1) Создать таблицу students с полями
name (не null)
lastname (не null)
avg_mark (от 0 до 5)
gender varchar(128) (или “M” или “F”)
*/

create table students (
	name varchar(128) not null,
    lastname varchar(128) not null,
    avg_mark numeric(2, 1) check (avg_mark between 0 and 5),
    gender varchar(128) check (gender in('M', 'F'))
);

/*
2) добавить 5 записей студентов

Олег Петров 4.3 M
Семен Степанов 3.1 M 
Ольга Семенова 4.7 F 
Игорь Романов 3.1 M 
Ирина Иванова 2.2 F
*/

insert into students (name, lastname, avg_mark, gender) values ('Олег', 'Петров', 4.3, 'M'),
																('Семен', 'Степанов', 3.1, 'M'),
                                                                ('Ольга', 'Семенова', 4.7, 'F'),
                                                                ('Игорь', 'Романов', 3.1, 'M'),
                                                                ('Ирина', 'Иванова', 2.2, 'F');

select * from students;

-- 3) добавить поле id integer primary key auto_increment

alter table students
add id integer primary key auto_increment;

-- 4) поменять тип у gender на char(1)

alter table students
modify column gender char(1);

-- 5) переименовать поле name на firstname

alter table students
change name firstname varchar(128);

/*
6) выборки

- найти учеников, у которых оценка больше 4
- найти учеников, у которых не входит в диапазон от 3 до 4
- найти учеников, у которых имя начинается на И
- найти учеников, у которых оценка 2.2 или 3.1 или 4.7
*/

select
	*
from students
where avg_mark > 4;

select
	*
from students
where avg_mark not between 3 and 4;

select
	*
from students
where firstname like 'и%';

select 
	*
from students
where avg_mark in (2.2, 3.1, 4.7);


-- 9) Найти набор уникальных оценок

select distinct
	avg_mark
from students;


-- ДЗ:
-- 7) Создать представление, которое содержит всех мужчин
-- 8) Создать представление, которое содержит всех женщин
-- 10) Увеличить всем учащимся оценку в 10 раз
-- 11) Поменяйте у Олега Петрова фамилию на Сидоров
-- 12) Для всех учеников, у которых оценка не больше 31 увеличить на 10


