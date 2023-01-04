use shop;

-- 1. Определить сколько покупок было совершено во вторник.

select
	count(*) as cnt
from orders
where weekday(odate) = 1;

select
	count(*) as cnt
from orders
where dayname(odate) = 'Tuesday';

select
	count(*) as cnt
from orders
where dayofweek(odate) = 3;


-- 2. Определить сколько покупок было совершено в каждый месяц. 
-- Отсортировать строки по количеству покупок - сначала месяцы с нименьшим кол-вом покупок, потом с наибольшим.
-- Вывести два поля - номер месяца и кол-во покупок в этот месяц.

select
	month(odate) as month,
    count(*) as orders_cnt
from orders
group by month
order by orders_cnt;


-- 3. Определить, в какой месяц(ы) было совершено больше всего покупок

create view v_orders_count as
select
	month(odate) as month,
    count(*) as orders_cnt
from orders
group by month;

select
	*
from v_orders_count
where orders_cnt = (select max(orders_cnt) from v_orders_count);

drop view v_max_cnt;


-- VIEWS (ПРЕДСТАВЛЕНИЯ)

select * from customers;

create view v_moscow as
select 
	*
from customers
where city = 'Москва';


select 
	* 
from v_moscow
where cust_id < 304;


-- ПРАКТИКА

use airport;

-- 1. Разделите самолеты на три класса по возрасту. 
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
        when production_year between 2000 and 2010 then 'Mid'
        else 'New'
    end as age
from airliners
where range_ <= 10000
order by age;




-- ДЗ:
-- 1. Напишите запрос, который выведет id клиентов, чье значение атрибута name начинается на Daria. В выборке должен присутствовать один атрибут — id.
-- 2. Определите рейсы с точкой назначения в аэропортах, коды которых PEZ, MMK и VKO. В выборке должен присутствовать один атрибут — id.
-- 3. Определите id рейсов, которые должны были вылететь из аэропорта Домодедово (DME), но были отменены. В выборке должен присутствовать один атрибут — id.
-- 4. Определите имена и фамилии пассажиров, чьи идентификаторы заканчиваются на RCB или FCV, а номера телефонов не начинаются на +705. В выборке должен присутствовать один атрибут — name.
-- 5. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом сегменте с учетом скидки.В выборке должны присутствовать три атрибута — id, trip_id, new_price.

