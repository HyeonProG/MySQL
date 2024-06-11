select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

-- 문제 1
-- 낮은 번호대로 각 부서의 역대 매니저와 현 매니저의 수를 구하고 그 매니저들의 평균 급여를 구해라.
-- 출력 예시 - 부서 번호, 부서 이름, 인원수, 평균 급여
select d.dept_no as '부서 번호', d.dept_name as '부서 이름' ,
count(distinct dm.emp_no) as '인원수', round(avg(s.salary)) as '평균 급여'
from departments as d
left join dept_manager as dm
on d.dept_no = dm.dept_no
left join salaries as s
on dm.emp_no = s.emp_no
group by d.dept_name
order by d.dept_no asc;

-- 문제 2
-- 재직중이고 현재 연봉이 100000 이상인 직원수가 가장 많은 3개 부서를 출력하세요
-- 부서, 고소득직원수
select d.dept_name as '부서', count(de.emp_no) as '고소득직원수'
from salaries as s
left join dept_emp as de
on s.emp_no = de.emp_no
left join departments as d
on de.dept_no = d.dept_no
where s.salary >= 100000 and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
group by d.dept_name
order by count(de.emp_no) desc
limit 3;

-- 문제 3
-- 부서중 직원수가 가장 많은 부서 하나만 찾아주세요(부서이름과, 직원 수 나오게)
select d.dept_name as '부서', count(de.emp_no) as '직원수'
from departments as d
left join dept_emp as de
on d.dept_no = de.dept_no
group by d.dept_name
order by de.emp_no asc
limit 1;

-- 문제 4
-- 생일에 입사한 사람을 모두 조회하라
-- 출력예시 employees.*
select *
from employees
where month(birth_date) = month(hire_date)
and day(birth_date) = day(hire_date);

-- 문제 5
-- 현재 재직중인 사람들의 부서 이름,소수점없는 평균연봉을 구하시오
select d.dept_name as '부서 이름', round(avg(s.salary)) as '평균 연봉'
from dept_emp as de
join departments as d
on de.dept_no = d.dept_no
join salaries as s
on de.emp_no = s.emp_no
where s.to_date = '9999-01-01'
group by d.dept_name;

-- 문제 6
-- 부서 이동이 있었던 사원의 사번, 부서번호, 성, 이름, 이동 전,후 부서의 소속 기간을 출력하시오.
select e.emp_no as '사번', de.dept_no as '부서번호', e.first_name as '성',
e.last_name as '이름', de.from_date as '전', de.to_date as '후'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
where de.emp_no in(
    select emp_no
    from dept_emp
    group by emp_no
    having count(emp_no) > 1
); 

-- 문제 7
-- 현직자 중 업종을 출력하고 업종별 임금 평균과 최대 임금을 출력하시오. 
select t.title as '업종', avg(s.salary) as '평균 임금', max(s.salary) as '최대 임금'
from titles as t
join employees as e
on t.emp_no = e.emp_no
join salaries as s
on t.emp_no = s.emp_no
where t.to_date = '9999-01-01'
group by t.title;

-- 문제 8
-- 각 직원(중복x)마다 부서와 직급을 구하라 (단, 오름차순,내림차순은 무시한다)
select e.first_name, e.last_name, d.dept_name , t.title
from departments as d
join dept_emp as de
on d.dept_no = de.dept_no
join employees as e
on e.emp_no = de.emp_no
join titles as t
on e.emp_no = t.emp_no
group by e.emp_no;


-- 문제 9
-- 재직중인 senior Engineer 들의 부서와 first_name 그리고 가장 최고 연봉을 출력하세요.
select t.title, d.dept_name, e.first_name, max(s.salary)
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join titles as t
on e.emp_no = t.emp_no
join salaries as s
on e.emp_no = s.emp_no
join departments as d
on de.dept_no = d.dept_no
where de.to_date = '9999-01-01' and t.title = 'Senior Engineer'
group by e.emp_no;

-- 문제 10
-- 직급이 staff 인 직원의 평균 연봉을 구하세요.
select avg(s.salary)
from titles as t
join salaries as s
on t.emp_no = s.emp_no
where t.title = 'staff';

-- 문제 11 
-- staff들 중 first_name이 Georgi인 동명이인을 찾고 나이가 많은 사람 순으로 정렬하시오. 
-- (출력 : title, first_name, last_name, brith_date)
select t.title, e.first_name, e.last_name, e.birth_date
from titles as t
join employees as e
on t.emp_no = e.emp_no
where e.first_name = 'Georgi' and t.title = 'staff'
order by e.birth_date asc;

-- 문제 12
-- 연봉이 10만 달러 이상인 사람의 사번, 이름, 성별, 직급을 출력하시오.
select e.emp_no, e.first_name, e.last_name, e.gender, t.title, s.salary
from employees as e
join titles as t
on e.emp_no = t.emp_no
join salaries as s
on e.emp_no = s.emp_no
group by s.salary
having s.salary >= 100000;
