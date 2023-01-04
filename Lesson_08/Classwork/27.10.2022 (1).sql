show databases;				-- смотрим, какие есть БД
use GENTECH_35_36; 			-- используем базу данных GENTECH_35_36
show tables;				-- смотрим таблицы в БД
drop table if exists goods; -- удаляем таблицу с названием goods ЕСЛИ ТАКАЯ ЕСТЬ
-- ===================================================================
CREATE TABLE goods (        -- создаем таблицу
	id integer primary key auto_increment,
    title varchar (128),
    price integer,
    quantity integer check (quantity between 5 and 10)
);
-- ===================================================================
-- заполняем таблицу
INSERT INTO goods (title, price, quantity) VALUES ('Apple', 500, 5),
												  ('Pineapple', 1500, 7),
                                                  ('Lemon', 700, 6),
                                                  ('Lime', 300, 9);
INSERT INTO goods (title, price, quantity) VALUES ('Orange', 1500, 4);
-- смотрим данные в таблице
SELECT * FROM goods;
-- =====================================================================
-- ALTER TABLE - используется для добавления, удаления и изменения полей. Можно добавлять/удалять ограничения
-- Добавление нового поля:

ALTER TABLE goods 
ADD country varchar (128);

ALTER TABLE goods 
ADD city varchar (128) default 'Berlin'; -- По-умолчанию будет везде "Берлин"

-- Удаление поля:

ALTER TABLE goods 
DROP COLUMN city;

ALTER TABLE goods 
DROP COLUMN country;

-- Изменение поля (типа данных)

ALTER TABLE goods 
MODIFY COLUMN price numeric (6, 2);

-- Изменение имени поля 

ALTER TABLE goods 
CHANGE item_price price integer;

-- Удаление ограничения

ALTER TABLE goods 
DROP CHECK goods_chk_1;

-- Добавление ограничения

ALTER TABLE goods 
MODIFY COLUMN quantity integer check (quantity between 4 and 10);

-- =================================================================

-- UPDATE - позволяет изменять данные внутри таблицы
-- Перед тем, как делать UPDATE или DELETE, необходимо убрать ограничения командой: 
-- set sql_safe_updates = 0;

UPDATE goods
SET price = 2500
WHERE title = 'Apple';

UPDATE goods
SET price = 1000
WHERE title LIKE 'l%';


-- выбрать четные ID:

SELECT 
	* 
FROM goods
WHERE id % 2 =0;

-- ========================================================
-- ПРАКТИЧЕСКОЕ ЗАДАНИЕ:

/*
1) Создать таблицу students с полями
name (не null)
lastname (не null)
avg_mark (от 0 до 5)
gender varchar(128) (или “M” или “F”)
*/

CREATE TABLE students (
	name varchar (120) NOT NULL,
	last_name varchar (30) NOT NULL,
    avg_mark numeric(2,1) check (avg_mark between 0 and 5),
    gender varchar (128) check (gender in ('M', 'F'))
);

/*
2) добавить 5 записей студентов
Олег Петров 4.3 M
Семен Степанов 3.1 M 
Ольга Семенова 4.7 F 
Игорь Романов 3.1 M 
Ирина Иванова 2.2 F
*/
INSERT INTO students (name, last_name, avg_mark, gender) VALUES ('Oleg', 'Petrov', 4.3, 'M'),
																('Semen', 'Stepanov', 3.1, 'M'),
                                                                ('Olga', 'Semenova', 4.7, 'F'),
                                                                ('Igor', 'Romanov', 3.1, 'M'),
                                                                ('Irina', 'Ivanova', 2.2, 'F');

-- 3) добавить поле id integer primary key auto_increment
ALTER TABLE students 
ADD id integer primary key auto_increment;

-- 4) поменять тип у gender на char(1)
ALTER TABLE students 
MODIFY COLUMN gender char (1);

-- 5) переименовать поле name на firstname
ALTER TABLE students 
CHANGE name firstname varchar (128);

-- =================================================================
-- ДОМАШНЕЕ ЗАДАНИЕ 
/*
6) выборки
​
- найти учеников, у которых оценка больше 4
- найти учеников, у которых не входит в диапазон от 3 до 4
- найти учеников, у которых имя начинается на И
- найти учеников, у которых оценка 2.2 или 3.1 или 4.7 
*/

SELECT
	*
FROM students
WHERE avg_mark > 4;

SELECT
	*
FROM students
WHERE avg_mark not between 3 and 4;

SELECT
	*
FROM students
WHERE firstname like 'i%';

SELECT
	*
FROM students
WHERE avg_mark in (2.2, 3.1, 4.7);

-- 7)  Найти набор уникальных оценок

SELECT distinct
	avg_mark
FROM students;

-- 8)  Увеличить всем учащимся оценку в 10 раз

ALTER TABLE students
MODIFY COLUMN avg_mark numeric(3,1);

ALTER TABLE students
DROP CHECK students_chk_1;

UPDATE students
SET avg_mark = avg_mark * 10;
set sql_safe_updates = 0;

-- 9) Поменяйте у Олега Петрова фамилию на Сидоров

UPDATE students
SET firstname = 'Sidorov'
WHERE firstname = 'Oleg' AND last_name = 'Petrov';

-- 10) Для всех учеников, у которых оценка не больше 31 увеличить на 10

UPDATE students
SET avg_mark = avg_mark * 10
WHERE avg_mark < 31;

select * from students;



