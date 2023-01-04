-- ДЗ:
-- 1. Вывести всех преподавателей с их компетенциями

use Uni;

select * from teachers;
select * from teachers2competencies;
select * from competencies;

select 
	t1.name,
    t3.title
from teachers t1
left join teachers2competencies t2
on t1.id = t2.teacher_id
left join competencies t3
on t2.competencies_id = t3.id;


-- 2. Найти преподавателей без компетенций

select 
	t1.name,
    t2.competencies_id
from teachers t1
left join teachers2competencies t2
on t1.id = t2.teacher_id
where t2.teacher_id is null;

-- 3. Найти имена студентов, которые не проходят ни один курс

select
	t1.name
from students t1
left join students2courses t2
on t1.id = t2.student_id
where t2.student_id is null;


-- 4. Найти курсы, которые не посещает ни один студент

select
	t1.title
from courses t1
left join students2courses t2
on t1.id = t2.course_id
where t2.course_id is null;


-- 5. Найти компетенции, которых нет ни у одного преподавателя

select
	t1.title
from competencies t1
left join teachers2competencies t2
on t1.id = t2.competencies_id
where t2.competencies_id is null;


-- 6. Вывести название курса и имя старосты

select
	t1.title,
    t2.name
from courses t1
inner join students t2
on t1.headman_id = t2.id;


-- 7. Выведите имя студента и имена старост, которые есть на курсах, которые он проходит

select
	t1.name,
    t3.title,
    t4.name as headman
from students t1
inner join students2courses t2
on t1.id = t2.student_id
inner join courses t3
on t2.course_id = t3.id
inner join students t4
on t3.headman_id = t4.id;




