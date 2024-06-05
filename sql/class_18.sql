-- LEFT OUTER JOIN
-- 1단계
select *
from tb_student as s
left join tb_grade as g
on s.grade = g.grade;

-- 2단계
select *
from tb_grade as g
left join tb_student as s
on g.grade = s.grade;

desc tb_student;

-- RIGHT OUTER JOIN
select *
from tb_student as s
right join tb_grade as g
on s.grade = g.grade;