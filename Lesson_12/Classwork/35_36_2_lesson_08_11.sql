-- ДЗ:
-- 1) Вывести имя, фамилию и город сотрудников, которые работают в Seattle или Toronto

use hr;

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

select * from departments;


-- 2) Выведите названия департаментов, в которых менеджеры зарабатывают больше 10000

select
	t1.department_name
from departments t1
inner join employees t2
on t1.manager_id = t2.employee_id
where t2.salary > 10000;

-- 3) Вывести имя и фамилию сотрудника и имя и фамилию его менеджера * (self join)

select * from employees;

select
	t1.first_name as employee_firstname,
    t1.last_name as employee_lest_name,
    t2.first_name as manager_firstname,
    t2.last_name as manager_lastname
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id;


-- 4) Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера * (self join)

select distinct
	t1.job_id
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id
where t1.salary > t2.salary;


-- ПРАКТИЧЕСКАЯ РАБОТА
drop database uni;

-- Создать БД Uni
/*
Создание таблиц

1) создать таблицу Students
с полями:
- id целое число первичный ключ автоинкремент
- name строка 128 не null
- age целое число

2) создать таблицу Teachers
с полями:
- id целое число первичный ключ автоинкремент
- name строка 128 не null
- age целое число

3) создать таблицу Competencies
с полями:
- id целое число первичный ключ автоинкремент
- title строка 128 не null

4) создать таблицу Teachers2Competencies
с полями:
- id целое число первичный ключ автоинкремент
- teacher_id целое число
- competencies_id целое число

5) создать таблицу Courses
- id целое число первичный ключ автоинкремент
- teacher_id целое число
- title строка 128 не null
- headman_id целое число

6) создать таблицу Students2Courses
- id целое число первичный ключ автоинкремент
- student_id целое число
- course_id целое число
*/

create database Uni;
use Uni;

create table Students(
	id integer primary key auto_increment,
    name varchar(128) not null,
    age integer
);

create table Teachers(
	id integer primary key auto_increment,
    name varchar(128) not null,
    age integer
);

create table Competencies(
	id integer primary key auto_increment,
    title varchar(128) not null
);

create table Teachers2Competencies(
	id integer primary key auto_increment,
    teacher_id integer,
    competencies_id integer
);

create table Courses(
	id integer primary key auto_increment,
    teacher_id integer,
    title varchar(128) not null,
    headman_id integer
);

create table students2courses(
	id integer primary key auto_increment,
    student_id integer,
    course_id integer
);

show tables;

/*
**Заполнение таблиц**

Добавить 6 записей в таблицу Students

Анатолий 29
Олег 25
Семен 27
Олеся 28
Ольга 31
Иван 22

Добавить 6 записей в таблицу Teachers

Петр 39
Максим 35
Антон 37
Всеволод 38
Егор 41
Светлана 32

Добавить 4 записей в таблицу Competencies

Математика 
Информатика
Программирование
Графика

Добавьте 6 записей в таблицу Teachers2Competencies

1 1
2 1
2 3
3 2
4 1
5 3

Добавьте 5 записей в таблицу Courses

1 Алгебра логики 2
2 Математическая статистика 3
4 Высшая математика 5
5 Javascript 1
5 Базовый Python 1

Добавьте 5 записей в таблицу students2courses

1 1
2 1
3 2
3 3
4 5
*/


insert into students (name, age) values ('Анатолий', 29);
insert into students (name, age) values ('Олег', 25);
insert into students (name, age) values ('Семен', 27);
insert into students (name, age) values ('Олеся', 28);
insert into students (name, age) values ('Ольга', 31);
insert into students (name, age) values ('Иван', 22);

insert into teachers (name, age) values ('Петр', 39);
insert into teachers (name, age) values ('Максим', 35);
insert into teachers (name, age) values ('Антон', 37);
insert into teachers (name, age) values ('Всеволод', 38);
insert into teachers (name, age) values ('Егор', 41);
insert into teachers (name, age) values ('Светлана', 32);

insert into Competencies (title) values ('Математика');
insert into Competencies (title) values ('Информатика');
insert into Competencies (title) values ('Программирование');
insert into Competencies (title) values ('Графика');

insert into Teachers2Competencies (teacher_id, competencies_id) values (1, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 3);
insert into Teachers2Competencies (teacher_id, competencies_id) values (3, 2);
insert into Teachers2Competencies (teacher_id, competencies_id) values (4, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (5, 3);

insert into courses (teacher_id, title, headman_id) values (1, 'Алгебра логики', 2);
insert into courses (teacher_id, title, headman_id) values (2, 'Математическая статистика', 3);
insert into courses (teacher_id, title, headman_id) values (4, 'Высшая математика', 5);
insert into courses (teacher_id, title, headman_id) values (5, 'Javascript', 1);
insert into courses (teacher_id, title, headman_id) values (5, 'Базовый Python', 1);

insert into students2courses (student_id, course_id) values (1, 1);
insert into students2courses (student_id, course_id) values (2, 1);
insert into students2courses (student_id, course_id) values (3, 2);
insert into students2courses (student_id, course_id) values (3, 3);
insert into students2courses (student_id, course_id) values (4, 5);


-- 1) Вывести имена студентов и курсы, которые они проходят

select * from students;
select * from students2courses;
select * from courses;

select
	t1.name,
    t3.title
from students t1
inner join students2courses t2
on t1.id = t2.student_id
inner join courses t3
on t2.course_id = t3.id;



/*
ДЗ:
1. Вывести всех преподавателей с их компетенциями
2. Найти преподавателей без компетенций
3. Найти имена студентов, которые не проходят ни один курс
4. Найти курсы, которые не посещает ни один студент
*/


