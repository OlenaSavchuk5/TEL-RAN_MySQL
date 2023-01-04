show databases;
use group_35_36;
show tables;
drop table goods2;

-- UNION / UNION ALL - "вертикальное" объединение таблиц
-- UNION - убирает дубли
-- UNION ALL - подтягивает все данные

-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ
-- Создать таблицу goods:
-- id integer первичный ключ
-- title строка 128
-- quantity integer 0 - 10

-- Создать таблицу goods_2:
-- id integer первичный ключ
-- title строка 128
-- price inteder
-- quantity integer 0 - 10

drop table if exists goods;
create table goods (
	id integer primary key,
    title varchar(128),
    quantity integer check (quantity between 0 and 10)
);

create table goods_2 (
	id integer primary key,
    title varchar(128),
    price integer,
    quantity integer check (quantity between 0 and 10)
);

-- Заполнить данными обе таблицы

insert into goods (id, title, quantity) values (1, 'Apple', 5), (2, 'Orange', 7), (3, 'Banana', 8);
insert into goods_2 (id, title, price, quantity) values (1, 'Pineapple', 700, 5), (2, 'Lemon', 500, 7), (3, 'Lime', 350, 8);

select * from goods_2;

-- Объединить данные из goods и goods_1 (без дублей)
select id, title, quantity from goods
union
select id, title, quantity from goods_2;

-- Объединить данные из goods и goods_1 (все записи)
select id, title, quantity from goods
union all
select id, title, quantity from goods_2;

-- Объединить данные из goods и goods_1, указав price, где это возможно

select
	id,
    title,
    quantity,
    null as price
from goods
union all
select
	id,
    title,
    quantity,
    price
from goods_2;



-- JOIN - 'горизонтальное' объединение таблиц


use hr;
create database hr;

-- 1. Вывести имя и фамилию сотрудника и название его департамента
select * from employees;
select * from departments;
select * from locations;


select
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1
left join departments t2
on t1.department_id = t2.department_id;

-- 2. Вывести имя и фамилию сотрудника и название его департамента только тех сотрудников, которые работают в IT, Treasury или IT Support

select
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1
left join departments t2
on t1.department_id = t2.department_id
where t2.department_name in ('IT', 'Treasury', 'IT Support');

-- 3. Вывести имя и фамилию сотрудников, которые работают в Seattle или Toronto

select
	t1.first_name,
    t1.last_name,
    t3.city
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
inner join locations t3
on t2.location_id = t3.location_id
where t3.city in ('Seattle', 'Toronto');

-- 4. Найти департаменты, в которых никто не работает

select
	t1.department_name
from departments t1
left join employees t2
on t1.department_id = t2.department_id
where t2.department_id is null;

select
	department_name
from departments
where manager_id is null;

-- ДЗ:
-- 1. Выведите названия департаментов, в которых менеджеры зарабатывают больше 10000
-- 2. Вывести имя и фамилию сотрудника и имя и фамилию его менеджера * sell join?
-- 3. Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера *
