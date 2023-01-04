show databases;
use group_35_36;
show tables;
drop table goods_2;

drop table goods;
create table goods (
	id integer primary key auto_increment,
    title varchar(128),
    quantity integer,
    price integer default 100,
    in_stock char(1) check (in_stock in ('y', 'n')),
    country varchar(128)
    );
    
select * from goods;

insert into goods (title, quantity, in_stock) value ('Apple', 4, 'y'),
													('Orange', 5, 'n'),
                                                    ('Grape', 3, 'y'),
                                                    ('Banana', 2, 'n'),
                                                    ('Lemon', 7, 'y');
                                                    
insert into goods (title, quantity, price, in_stock) value ('Lime', 8, 120, 'y');
insert into goods (title, quantity, in_stock) value ('Blackberry', 0, 'n');


-- ИЗМЕНИЕ ПОЛЯ
-- Добавление нового поля
alter table goods
add country varchar(128);


-- Удаление поля 
alter table goods
drop column country;


-- Изменение поля (тип данных)
alter table goods
modify column country char(3);


-- Изменить имя поля
alter table goods
change country product_country varchar(128);


-- Удалить ограничение
alter table goods
drop check goods_chk_1;


-- Изменить значение
update goods
set quantity = 0
where quantity >= 5;

update goods
set quantity = null;

set sql_safe_updates = 0;

/*
1. Создать таблицу products
id первичный ключ автоинкремент
title строка 128
quantity от 0 до 10 
-- 2. Добавить несколько строк
-- 3. Добавить поле price integer co значением по умолчанию 0
-- 4. Изменить тип price на numeric(8,2)
-- 5. Измените тип price обратно на integer
-- 6. Переименуйте поле item_price
-- 7. Удалите поле item_price
*/

create table products (
	id integer primary key auto_increment,
    title varchar(128),
    quantity integer check(quantity between 0 and 10)
);

select * from products;

-- 2. Добавить несколько строк
insert into products (title, quantity) value ('Bag', 9),
                                             ('Hut', 10),
                                             ('Shorts', 5),
                                             ('Caps', 10);
                                             
-- 3. Добавить поле price integer co значением по умолчанию 0                                             
alter table products
add price integer default 0;  


-- 4. Изменить тип price на numeric(8,2)
alter table products
modify column price numeric(8, 2); 


-- 5. Измените тип price обратно на integer
alter table products
modify column price integer;


-- 6. Переименуйте поле item_price
alter table products
change price item_price integer;	


-- 7. Удалите поле item_price
alter table products
drop column item_price;		


-- ПРЕДСТАВЛЕНИЯ 
-- Представления позволяют нам сохранить глобально не сами данные, а запрос. При каждом обращении к представлению выполняется 
-- запрос и формируется набор данных из таблицы.

create view v_s_products as 
select 
*
from products
where title like 's%';

select * from products;

select * from v_s_products
where quantity = 5;

drop view v_s_products;	

show tables;		

​
/*
1) необходимо создать таблицу students с полями
​
name (не null)
lastname (не null)
avg_mark (от 0 до 5)
gender varchar(128) (или “M” или “F”)
​
2) добавить 5 записей студентов
​
Олег Петров 4.3 M
Семен Степанов 3.1 M 
Ольга Семенова 4.7 F 
Игорь Романов 3.1 M 
Ирина Ирина 2.2 F
​
3) добавить поле id integer primary key auto_increment
4) поменять тип у gender на char(1)
5) переименовать поле name на firstname
*/		

create table students (
	first_name varchar(128) not null,
    last_name varchar(128) not null,
    avg_mark numeric(2, 1) check(avg_mark between 0 and 5),
    gender char(1) check(gender in ('M', 'F'))
);	

insert into students (first_name, last_name, avg_mark, gender) value ('Олег', 'Петров', 4.3, 'M'),
                                                                     ('Семен', 'Степанов', 3.1, 'M'),
                                                                     ('Ольга', 'Семенова', 4.7, 'F'),
                                                                     ('Игорь', 'Романов', 3.1, 'M'),
                                                                     ('Ирина', 'Семенова', 2.2, 'F');
drop table students;

select * from students;

alter table students
add id integer primary key auto_increment;

alter table students
change first_name name varchar(128);


/*
6) выборки
​
- найти учеников, у которых оценка больше 4
- найти учеников, у которых оценка не входит в диапазон от 3 до 4
- найти учеников, у которых имя начинается на И
- найти учеников, у которых оценка 2.2 или 3.1 или 4.7
*/


select name, last_name, avg_mark
from students
where avg_mark > 4;

select name, last_name, avg_mark
from students
where avg_mark not between 3 and 4;

select name, last_name, avg_mark
from students
where name like ('И%');

select name, last_name, avg_mark
from students
where avg_mark in (2.2, 3.1, 4.7);

rename table students_1 to students;

show tables;


/*
7) Создать представление, которое содержит всех мужчин (без поля gender)
8) Создать представление, которое содержит всех женщин (без поля gender)
9) Найти набор уникальных оценок
*/


create view v_students_m as 
select 
name, last_name, id
from students
where  gender = 'M';


create view v_students_f as 
select 
name, last_name,id
from students
where  gender = 'F';



select distinct
avg_mark
from students;

select * from v_students_m;
select * from v_students_f;

-- Увеличить всем учащимся оценку в 10 раз

alter table students
modify column avg_mark numeric(3, 1);

alter table students
drop check students_chk_1;

update students
set avg_mark = avg_mark * 10;


set sql_safe_updates = 0;

-- ДЗ:
-- 11) Поменяйте у Олега Петрова фамилию на Сидоров
-- 12) Для всех учеников, у которых оценка не больше 31 увеличить ее на 10


update students
set last_name = 'Сидоров'
where last_name = 'Петров';

update v_students_avg
set avg_mark = avg_mark + 10;


select * from students;

drop table v_students_avg;