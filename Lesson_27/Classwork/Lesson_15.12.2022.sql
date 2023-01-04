-- ДЗ
-- 1. Отсортируйте данные о билетах в зависимости от цены по возрастанию. В выборке должны присутствовать три атрибута — id, trip_id, price.

use airport;

select
	id,
    trip_id,
    price
from tickets
order by price;

-- 2. Менеджеры авиакомпании потребовали выяснить количество различных моделей самолетов. Выведите все доступные модели, исключая дубликаты. 
-- В выборке должен присутствовать один атрибут — model_name.

select distinct
	model_name
from airliners;

-- 3. Посчитайте кол-во моделей из прошлой задачи.

select
	count(*) as models_cnt
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
	count(*) as tickets_cnt
from tickets
where service_class <> 'Business';

-- 6. Определите модели самолетов, максимальная дальность полета которых находится в диапазоне от 4200 до 7900 включительно. 
-- В выборке должен присутствовать один атрибут —  model_name.

select
	model_name
from airliners
where range_ between 4200 and 7900;


-- ПРАКТИКА

-- 1. Напишите запрос, который выведет id клиентов, чье значение атрибута name начинается на Daria.
-- В выборке должен присутствовать один атрибут — id.

select
	id
from clients 
where name like 'Daria%';

-- 2. Определите id рейсов, которые должны были вылететь из аэропорта Домодедово (DME), но были отменены.
-- В выборке должен присутствовать один атрибут — id.

select
	id
from trips
where departure = 'DME' and status = 'Cancelled';

-- 3. Определите имена и фамилии пассажиров, чьи идентификаторы заканчиваются на RCB или FCV, а номера телефонов не начинаются на +705.
-- В выборке должен присутствовать один атрибут — name.

select
	name
from clients
where (id like '%RCB' or id like '%FCV') 
and phone not like '+705%';

-- 4. Разделите самолеты на три класса по возрасту. 
-- Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. 
-- Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. 
-- Более новые самолеты отнесите к классу 'New'. 
-- Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
-- Отсортируйте выборку по классу возраста в порядке возрастания.
-- В выборке должны присутствовать два атрибута — side_number, age.

select
	side_number,
    case
		when production_year < 2000 then 'Old'
        when production_year <= 2010 then 'Mid'
        else 'New'
    end as age
from airliners
where range_ <= 10000
order by age;

-- 5. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, 
-- а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, trip_id, new_price.

select
	id,
    trip_id,
    case
		when service_class = 'Economy' then price * 0.85
        when service_class = 'Business' then price * 0.9
        when service_class = 'PremiumEconomy' then price * 0.8
    end as new_price
from tickets
where trip_id in ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');





-- РАБОТА С ДАТОЙ И ВРЕМЕНЕМ

-- дата
select date('2022-12-15 11:18:23') as date; 

-- индекс месяца
select month('2022-12-15 11:18:23') as month;

-- название месяца
select monthname('2022-12-15 11:18:23') as month;

-- день в месяце
select day('2022-12-15 11:18:23') as day;

-- индекс дня недели
select weekday('2022-12-15 11:18:23') as weekday; -- 3 (Monday 0 - Sunday 6)

select dayofweek('2022-12-15 11:18:23') as weekday; -- 5 (Sunday 1 - Saturday 7)

-- день в году
select dayofyear('2022-12-15 11:18:23') as dayofyear;

-- неделя в году

select weekofyear('2022-12-15 11:18:23') as weekofyear;

SELECT CURRENT_DATE();
SELECT CURRENT_TIMESTAMP();


-- ПРАКТИКА

-- 1. Создать БД Shop

create database Shop;
use Shop;

-- 2. Наполнить БД данными

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


-- 1. Определить какие покупки были совершены в марте

select
	*
from orders
where month(odate) = 3;

select
	*
from orders
where monthname(odate) = 'March';

-- 2. Определить какие покупки были совершены в период с 10 апреля 2022 по 10 мая 2022 (включительно)

select
	*
from orders
where date(odate) between '2022-04-10' and '2022-05-10';

-- 3. Определить сколько покупок было совершено в июне

select
	count(*) as orders_cnt
from orders
where month(odate) = 6;


-- 4. Определить среднюю стоимость покупок в марте. Округлите полученное значение

select 
	ROUND(avg(amt)) as avg_amt
from orders
where month(odate) = 3;

select round(4.33566); -- по правилам математики
select ceil(4.000000001); -- округление вверх
select floor(4.999999999); -- округление вниз


-- 5. Определить какие покупки были совершены во вторник

select
	*
from orders
where weekday(odate) = 1;


-- 6. Определить сколько покупок было совершено в каждый месяц. Отсортировать строки в порядке возрастания количества покупок.
-- Вывести два поля - номер месяца и количество покупок.


select
	month(odate) as month,
    count(*) as cnt
from orders
group by month
order by cnt;






