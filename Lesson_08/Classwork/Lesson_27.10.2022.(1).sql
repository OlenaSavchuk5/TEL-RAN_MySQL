use group_35_36_2;

drop table if exists goods;
create table goods (
	id integer primary key auto_increment,
    title varchar(128),
    price integer,
    quantity integer check (quantity between 5 and 10)
);

insert into goods (title, price, quantity) values ('Apple', 500, 5),
													('Pineapple', 1500, 7),
                                                    ('Lemon', 700, 6),
                                                    ('Lime', 300, 9);
									
insert into goods (title, price, quantity) values ('Orange', 1500, 4);
insert into goods (title, price, quantity) values ('Kiwi', 500, 1);


-- ALTER TABLE
-- Используется для добавления, удаления и изменения полей. Можно добавлять/удалять ограничения

-- Добавление нового поля
alter table goods
add country varchar(128);

alter table goods
add city varchar(128) default 'Berlin';

-- Удаление поля
alter table goods
drop column country,
drop column city;

-- Изменение поля (тип данных)
alter table goods
modify column price numeric(6, 2);

-- Изменение имени поля
alter table goods
change price price numeric(6, 2);

-- Удаление ограничения
alter table goods
drop check goods_chk_1;

-- Добавление ограничения
alter table goods
modify column quantity integer check (quantity between 4 and 10);


-- UPDATE
-- Изменение данных
-- set sql_safe_updates = 0;

update goods
set price = 2500
where title = 'Apple';

update goods
set price = 1000
where title like 'l%';

update goods
set price = price / 2;




-- ПРАКТИКА
/*
1) Создать таблицу students с полями
name (не null)
lastname (не null)
avg_mark (от 0 до 5)
gender varchar(128) (или “M” или “F”)
*/

drop table if exists students;
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

-- 3) добавить поле id integer primary key auto_increment

alter table students
add id integer primary key auto_increment;

select * from students;

-- 4) поменять тип у gender на char(1)

alter table students
modify column gender char(1);

-- 5) переименовать поле name на firstname

alter table students
change name firstname varchar(128);



-- ДЗ:
/*
6) выборки

- найти учеников, у которых оценка больше 4
- найти учеников, у которых не входит в диапазон от 3 до 4
- найти учеников, у которых имя начинается на И
- найти учеников, у которых оценка 2.2 или 3.1 или 4.7 
*/

-- 7)  Найти набор уникальных оценок
-- 8)  Увеличить всем учащимся оценку в 10 раз
-- 9) Поменяйте у Олега Петрова фамилию на Сидоров
-- 10) Для всех учеников, у которых оценка не больше 31 увеличить на 10
