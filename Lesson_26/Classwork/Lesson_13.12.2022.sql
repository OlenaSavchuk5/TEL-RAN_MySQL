-- ДЗ
-- 1. Отсортируйте данные о билетах в зависимости от цены по возрастанию. В выборке должны присутствовать три атрибута — id, trip_id, price.

use airport;

select
	id,
    trip_id,
    price
from tickets
order by price;

-- 2. Менеджеры авиакомпании потребовали выяснить количество различных моделей самолетов. 
-- Выведите все доступные модели, исключая дубликаты. В выборке должен присутствовать один атрибут — model_name.

select distinct
	model_name
from airliners;

-- 3. Посчитайте кол-во моделей из прошлой задачи.

select
	count(*) as cnt
from (
	select distinct
		model_name
	from airliners
) t1;

-- 4. Аналитическое подразделение решило уточнить у авиакомпании количество билетов не бизнес-класса. 
-- Напишите запрос, который выведет id билетов, класс обслуживания в которых отличен от бизнес-класса (Business). 
-- В выборке должен присутствовать один атрибут —  id.

select
	id
from tickets
where service_class <> 'Business';

-- 5. Посчитайте кол-во билетов из прошлой задачи.

select
	count(*)
from tickets
where service_class <> 'Business';

-- 6. Определите модели самолетов, максимальная дальность полета которых находится в диапазоне от 4200 до 7900 включительно. 
-- В выборке должен присутствовать один атрибут —  model_name.

select
	model_name
from airliners
where range_ between 4200 and 7900;


-- Работа с датой и временем

select date('2022-12-13 13:23:14');


-- ПРАКТИКА

-- 1. Создать БД Shop и заполнить ее данными

create database Shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   CHAR(20), 
       CITY    CHAR(20), 
       COMM    NUMERIC(3, 2),
       BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   CHAR(20), 
       CITY    CHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);


-- 2. Определить какие покупки были совершены в марте

use shop;

select
	*
from orders
where monthname(odate) = 'March';

select
	*
from orders
where month(odate) = 3;

-- 3. Определить, какие покупки были совершены в период с 10 апреля 2022 по 10 мая 2022 (включительно)

select
	*
from orders
where date(odate) between '2022-04-10' and '2022-05-10';


-- 4. Определить сколько покупок было совершено в июне

select
	count(*)
from orders
where month(odate) = 6;

-- 5. Определить какие покупки были совершены во вторник

select
	*
from orders
where weekday(odate) = 1;

-- 6. Определить средную стоимость покупок в марте. Округлить полученное значение.

select
	round(avg(amt)) as avg_amt
from orders
where month(odate) = 3;

-- 7. Определелить какие покупки были совершены в недели больше 20

select
	*
from orders
where yearweek(odate) > 202220;



