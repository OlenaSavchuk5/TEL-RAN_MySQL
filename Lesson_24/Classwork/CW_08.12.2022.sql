use airport;

select * from airliners;
select * from trips;
select * from clients;
select * from tickets;

-- 1. Выведите коды всех рейсов, в рамках которых воздушные судна вылетели из Москвы и в данный момент находятся в воздухе (статус таких рейсов - departed).
-- Коды аэропортов Москвы: SVO, VKO, DME.
-- В выборке должен присутствовать один атрибут - trip_code.

select
  trip_code
from trips
where status = 'departed' 
and departure in ('SVO','VKO','DME');

-- in - для 2 и более
-- = - для 1
-- like - ищем по части слова

-- 2. Выведите бортовые номера (side_number) и дальность полета (range) всех ближне- и дальнемагистральных самолетов.
-- Примечание: ближнемагистральными считаете те, дальность полета которых > 1000 км и <= 2500 км. Дальнемагистральными - с
-- дальностью полета >= 6000 км.
-- В выборке должны присутствовать два атрибута - side_number и range_. 

select
  side_number,
  range_
from airliners
where (range_ > 1000 and range_ <= 2500)
or range_ >= 6000; 


-- 3. Выведите идентификаторы билетов бизнес-класса дешевле 65000 и экономкласса дороже 15000.
-- Исключите из выборки билеты рейсов VR5SF5YIWN, OZAO28DLFP и LL4S1G8PQW, так как для них ценовая политика не меняется.
-- В выборке должен присутствовать один атрибут - id. 

select
  id
from tickets
where  ((service_class in ( 'Business') and price < 65000) or (service_class in ( 'Economy') and price > 15000))
and trip_id not in ('VR5SF5YIWN', 'OZAO28DLFP','LL4S1G8PQW');


-- 4. Посчитать кол-во айдишников из прошлой задачи

select
  count(id) as id_count
from tickets
where  ((service_class in ( 'Business') and price < 65000) or (service_class in ( 'Economy') and price > 15000))
and trip_id not in ('VR5SF5YIWN', 'OZAO28DLFP','LL4S1G8PQW');


-- 5. Для каждого самолета модели Cessna 172 выведите дальность полета. 
-- Имя столбца с результатом должно быть max_distance.
-- В выборке должен присутствовать один атрибут — max_distance.

select
   range_ as max_distance
from airliners
where model_name = 'Cessna 172';


-- 6. Разделите самолеты на ближне-, средне- и дальнемагистральные. 
-- Ближнемагистральными будем считать самолеты, дальность полета которых > 1000 км и <= 2500 км. 
-- Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. 
-- В выборке должно быть два столбца, где в первом указана модель самолета. 
-- Во втором, category, — категория, со значениями short-haul, medium-haul, long-haul (ближне-, средне- и дальнемагистральные соответственно). 
-- Каждый самолет точно попадает ровно в одну категорию.
-- Если дальность <= 1000 или значение не задано, тогда вывести undefined
-- В выборке должны присутствовать два атрибута — model_name, category.

select
  model_name,
  case 
      when range_ > 1000 and range_ <= 2500 then 'short-haul'
      when range_ > 2500 and range_ <= 6000 then 'medium-haul'
      when range_ > 6000 then 'long-haul'
      else 'undefined'
  end as category
from airliners;      

