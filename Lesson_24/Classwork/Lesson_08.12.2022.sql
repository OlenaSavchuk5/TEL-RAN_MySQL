-- ДЗ
-- 22

select
	speed,
	avg(price) as avg_price
from pc
where speed > 600
group by speed;

-- 23

select distinct
	t2.maker
from pc t1
inner join product t2
on t1.model = t2.model
and t1.speed >= 750
inner join (
	select
		t2.maker
	from laptop t1
	inner join product t2
	on t1.model = t2.model
	where t1.speed >= 750
) t3
on t2.maker = t3.maker;


-- 24

select 
	model
from (
	select model, price from pc
	union
	select model, price from laptop
	union 
	select model, price from printer
) t1
where price = (
	select
		max(price) as max_price
	from (
		select price from pc
		union
		select price from laptop
		union 
		select price from printer
	) t2
);


-- 25

select distinct
	t1.maker
from product t1
inner join pc t2
on t1.model = t2.model
where t2.ram = (select min(ram) from pc)
and t2.speed = (
	select
		max(speed) as max_speed
	from pc
	where ram = (select min(ram) from pc)
)
and t1.maker in (select maker from product where type = 'printer');


-- 2. В БД HR найти департаменты, в которых ВСЕ сотрудники зарабатывают больше 10000. 
-- В результате нужно вывести два поля - department_name и поле result (1, 0). 
-- 1 выводится в случае, если в департаменте все зарабатывают больше 10 тыс, 0 - если не все

use hr;

select
	t1.department_name,
    t2.result
from departments t1
inner join (
	select
		department_id,
		min(
			case
				when salary >= 10000 then 1
				else 0
			end
		) as result
	from employees
	where department_id is not null
	group by department_id
) t2
on t1.department_id = t2.department_id;


-- ПРАКТИКА
-- 1. Создать БД airport

create database airport;
use airport;

-- 2. Заполнить базу данными из документа

-- 3. Клиент ищет билеты из точки А в точку Б. Однако есть важное условие — стоимость билета не должна превышать 13200.
-- Напишите запрос, который выведет id билетов, стоимость которых меньше или равна 13200.
-- В выборке должен присутствовать один атрибут — id.

select
	id
from tickets
where price <= 13200;

-- 4. Выведите коды всех рейсов, в рамках которых воздушные судна вылетели из Москвы и в данный момент находятся в воздухе (статус таких рейсов —  departed). 
-- Коды аэропортов Москвы: SVO, VKO, DME.
-- В выборке должен присутствовать один атрибут — trip_code.

select
	trip_code
from trips
where status = 'departed'
and departure in ('SVO', 'VKO', 'DME');


-- 5. Выведите бортовые номера (side_number) и дальность полета (range_) всех ближне- и дальнемагистральных самолетов. 
-- Примечание: ближнемагистральными считайте те, дальность полета которых > 1000 км и <= 2500 км. 
-- Дальнемагистральными — с дальностью полета >= 6000 км.
-- В выборке должны присутствовать два атрибута — side_number и range_.

select
	side_number,
    range_
from airliners
where (range_ > 1000 and range_ <= 2500)
or range_ >= 6000;

-- 6. Выведите идентификаторы билетов бизнес-класса дешевле 65 000 и экономкласса дороже 15 000. 
-- Исключите из выборки билеты рейсов VR5SF5YIWN, OZAO28DLFP и LL4S1G8PQW, так как для них ценовая политика не меняется.
-- В выборке должен присутствовать один атрибут — id.

select
	id
from tickets
where ((price < 65000 and service_class = 'Business') or (price > 15000 and service_class = 'Economy'))
and trip_id not in ('VR5SF5YIWN', 'OZAO28DLFP', 'LL4S1G8PQW');


-- 7. Найти кол-во айдишников из прошлой задачи

select
	count(id) as cnt
from tickets
where ((price < 65000 and service_class = 'Business') or (price > 15000 and service_class = 'Economy'))
and trip_id not in ('VR5SF5YIWN', 'OZAO28DLFP', 'LL4S1G8PQW');


-- 8. Найдите данные обо всех билетах с классом обслуживания не Economy и не Business. 
-- Таблица tickets может содержать значения NULL.
-- В выборке должны присутствовать два атрибута — id, trip_id.

select
	id,
    trip_id
from tickets
where service_class not in ('Economy', 'Business') 
or service_class is null;


-- Разделите самолеты на ближне-, средне- и дальнемагистральные. 
-- Ближнемагистральными будем считать самолеты, дальность полета которых > 1000 км и <= 2500 км. 
-- Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. 
-- В выборке должно быть два столбца, где в первом указана модель самолета. 
-- Во втором, category, — категория, со значениями short-haul, medium-haul, long-haul (ближне-, средне- и дальнемагистральные соответственно). 
-- Каждый самолет точно попадает ровно в одну категорию.
-- В выборке должны присутствовать два атрибута — model_name, category.

select
	model_name,
    case
		when range_ > 1000 and range_ <= 2500 then 'short-haul'
        when range_ > 2500 and range_ <= 6000 then 'medium-haul'
        when range_ > 6000 then 'long-haul'
    end as category
from airliners;


-- ДЗ
-- 1. Отсортируйте данные о билетах в зависимости от цены по возрастанию. В выборке должны присутствовать три атрибута — id, trip_id, price.
-- 2. Менеджеры авиакомпании потребовали выяснить количество различных моделей самолетов. Выведите все доступные модели, исключая дубликаты. В выборке должен присутствовать один атрибут — model_name.
-- 3. Посчитайте кол-во моделей из прошлой задачи.
-- 4. Аналитическое подразделение решило уточнить у авиакомпании количество билетов не бизнес-класса. Напишите запрос, который выведет id билетов, класс обслуживания в которых отличен от бизнес-класса (Business). В выборке должен присутствовать один атрибут —  id.
-- 5. Посчитайте кол-во билетов из прошлой задачи.
-- 6. Определите модели самолетов, максимальная дальность полета которых находится в диапазоне от 4200 до 7900 включительно. В выборке должен присутствовать один атрибут —  model_name.





