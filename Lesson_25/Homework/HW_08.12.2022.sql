-- ДЗ

use airport;
select * from airliners;
select * from clients;
select * from tickets;
select * from trips;

-- 1. Отсортируйте данные о билетах в зависимости от цены по возрастанию. В выборке должны присутствовать три атрибута — id, trip_id, price.

select
   id,
   trip_id,
   price
from tickets
order by price;
   
   
-- 2. Менеджеры авиакомпании потребовали выяснить количество различных моделей самолетов. Выведите все доступные модели, исключая дубликаты. 
-- В выборке должен присутствовать один атрибут — model_name.

select 
   count(distinct model_name) as model_name
from airliners;   


-- 3. Посчитайте кол-во моделей из прошлой задачи.

select 
   count(model_name) as model_cnt
from airliners;
														

-- 4. Аналитическое подразделение решило уточнить у авиакомпании количество билетов не бизнес-класса. Напишите запрос, который выведет id билетов, 
-- класс обслуживания в которых отличен от бизнес-класса (Business). В выборке должен присутствовать один атрибут —  id.

select
   count(id) as id
from tickets
where service_class <> 'Business';


-- 5. Посчитайте кол-во билетов из прошлой задачи.

select
   count(id) as id
from tickets
where service_class = 'Business';


-- 6. Определите модели самолетов, максимальная дальность полета которых находится в диапазоне от 4200 до 7900 включительно. 
-- В выборке должен присутствовать один атрибут —  model_name.

select
	max(range_) as model_name
from airliners
where range_ > 4200 and range_ <= 7900;   -- таких моделей просто нет

