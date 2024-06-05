-- 문제 1
-- 사원 이름과 부서 이름, 부서 번호를 출력
select e.first_name, e.last_name, d.dept_name, de.dept_no
from dept_emp as de
join employees as e
on de.emp_no = e.emp_no
join departments as d
on de.dept_no = d.dept_no;

-- 문제 2
-- 부서 번호, 부서 이름, 매니저 넘버를 출력
select d.dept_no, d.dept_name, dm.emp_no
from departments as d
left join dept_manager as dm
on d.dept_no = dm.dept_no;

-- 문제 3
-- 직원넘버와 직함 이름을 순서대로 나열
select e.emp_no, t.title, e.first_name, e.last_name
from titles as t
join employees as e
on t.emp_no = e.emp_no;