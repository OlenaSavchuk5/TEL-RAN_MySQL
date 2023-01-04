-- ДЗ:
-- 1. Напишите запрос, который выведет id клиентов, чье значение атрибута name начинается на Daria. 
-- В выборке должен присутствовать один атрибут — id.

use airport;

select
	id
from clients
where name like 'Daria%';

-- 2. Определите рейсы с точкой назначения в аэропортах, коды которых PEZ, MMK и VKO. В выборке должен присутствовать один атрибут — id.

select
	id
from trips
where arrival in ('PEZ', 'MMK', 'VKO');

-- 3. Определите id рейсов, которые должны были вылететь из аэропорта Домодедово (DME), но были отменены. 
-- В выборке должен присутствовать один атрибут — id.

select
	id
from trips
where departure = 'DME' and status = 'Cancelled';

-- 4. Определите имена и фамилии пассажиров, чьи идентификаторы заканчиваются на RCB или FCV, а номера телефонов не начинаются на +705. 
-- В выборке должен присутствовать один атрибут — name.

select
	name
from clients
where (id like '%RCB' or id like '%FCV') and phone not like '+705%';

-- 5. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%. 
-- Определите цену билета в каждом сегменте с учетом скидки.В выборке должны присутствовать три атрибута — id, trip_id, new_price.

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






