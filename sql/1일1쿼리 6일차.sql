select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


--  문제 1
-- db sakila 에서 가장 많은 작품을 찍은 배우의 작품을 모두 조회하라
-- 출력 예시 (first_name, title, category_name)
use sakila;

SELECT a.first_name, f.title, c.name AS category_name
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 문제 2
-- emp_no,birth_date,last_name,dept_name ,gender 그리고
-- dept_name 의 수가 2개 이상인 직원의 나이와 나이순으로 내림차순조회
-- 성별은 여성, dept_no번호는 d001 제외, 생일날짜의 달이 짝수인 직원(서브쿼리 사용안함)
select e.emp_no, birth_date,last_name,d.dept_name,gender,count(dept_name) 부서,
case when count(dept_name)=2 then year(current_time())-year(birth_date) end as 나이
from dept_emp e
join employees em on e.emp_no=em.emp_no and  gender='M'
join departments d on e.dept_no=d.dept_no and 
(d.dept_no not like  '%___1%'and month(hire_date)%2=0 )
group by emp_no
order by 나이 desc; 

-- 문제 3
-- case when then 응용 문제
-- 마케팅 부서에서 재직중이고, 태어난 년도의 일의자리가 1,2,3 이면 O 아니면 X로 표시.
-- 사번, 이름(성+이름), 생년월일, 체크 로 출력
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', e.birth_date as '생년월일',
case
when year(e.birth_date) % 10 in (1, 2, 3) then 'O'
else 'X' end as '체크'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
where de.to_date = '9999-01-01' and d.dept_no = 'd001';


-- 문제 4
-- 중첩 서브 쿼리 응용 문제
-- 현재 재직 중인 직원 중, 직함이 'Staff'인 직원들의 이름, 사원번호, 평균 연봉를 출력.
select e.first_name, e.last_name, e.emp_no, avg(s.salary)
from employees as e
join titles as t
on e.emp_no = t.emp_no
join salaries as s
on e.emp_no = s.emp_no
where e.emp_no in
(select emp_no
from titles
where title = 'Staff' and to_date = '9999-01-01')
group by e.emp_no;


-- 문제 5
-- 일을 그만 둔 title에 senior가 포함된 직원들의 
-- 부서 넘버, 부서 이름, title, 부서별 그만둔 직원의 인원을 조회하시오
select d.dept_no, d.dept_name, t.title, count(de.emp_no)
from dept_emp as de
join titles as t
on de.emp_no = t.emp_no
join departments as d
on de.dept_no = d.dept_no
where t.title like 'Senior%' and de.to_date != '9999-01-01'
and t.to_date != '9999-01-01'
group by d.dept_name
order by d.dept_no asc;


-- 문제 6
-- 현재 부서 매니저들의 부서번호, 부서명, 직책, 성, 이름, 사번을 출력하시오.
-- (단 서브쿼리 사용 없이 조인만으로 쿼리 작성할 것.)
select dm.dept_no, d.dept_name, t.title, e.first_name, e.last_name, e.emp_no
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no
join titles as t
on e.emp_no = t.emp_no
join departments as d
on dm.dept_no = d.dept_no
where dm.to_date = '9999-01-01'
group by d.dept_name
order by d.dept_no asc;


-- 문제 7
-- 근무자의 부서 이름, 이름, 성별, 근로기간을 출력하세요(단, 이름은 합치고, 성별은 남자여야 하며,
-- 근로기간은 1992년 1월1일기준으로 일하고 있는 사람의 계약 근로기간을 
-- xxxx-x-x ~ xxxx-x-x 형식으로 출력하세요)
-- 근로기간 계산은 datediff()를 이용한다
select d.dept_name as '부서명', concat(e.first_name, ' ', e.last_name) as '이름',
e.gender as '성별', concat(de.from_date, ' ~ ', de.to_date) as '근무기간'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
where e.gender = 'M'
and (datediff(de.to_date, '1992-01-01') > 0)
and (datediff('1992-01-01', de.from_date) > 0);


-- 문제 8
-- 퇴사한 매니저의 기본정보(* from employees), 담당 부서, 매니저로 근무한 년수를 출력하세요
select e.*, d.dept_name, year(dm.to_date) - year(dm.from_date) as year
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no
join departments as d
on dm.dept_no = d.dept_no
where dm.to_date != '9999-01-01';


-- 문제 9
-- 부서별 여자직원의 평균연봉을 출력하기(서브쿼리이용)
select d.dept_name, avg(fs.salary) as '여자직원평균연봉'
from
(select s.salary, e.emp_no
from salaries as s
join employees as e
on s.emp_no = e.emp_no
where e.gender = 'F') as fs
join dept_emp as de
on fs.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
group by d.dept_name;


-- 문제 10
-- 평균 연봉이 가장 높은 부서의 재직중인 매니저의 emp_no, 부서명, 평균연봉, 이름을 출력하시오
-- 소숫점 2자리, first_name과 last_name은 결합하여 출력
select e.emp_no, d.dept_name, round(avg(s.salary), 2), e.first_name, e.last_name
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join salaries as s
on e.emp_no = s.emp_no
join departments as d
on de.dept_no = d.dept_no
join dept_manager as dm
on e.emp_no = dm.emp_no
join titles as t
on e.emp_no = t.emp_no
where t.title = 'Manager' and t.to_date = '9999-01-01'
group by de.dept_no
order by round(avg(s.salary), 2) desc
limit 1;


-- 문제 11
-- 마케팅 부서의 현재까지 지출했던 직급별 평균 연봉을 구하고 제일 높은 연봉을 
-- 받는 직원의 이름 (f, last name)을 구하시오
select 
avg(case when t.title = 'staff' then s.salary end) as 스태프평균연봉,
avg(case when t.title = 'senior staff' then s.salary end) as 시니어스태프평균연봉,
e.최고연봉자
from dept_emp as de
join salaries as s
on de.emp_no = s.emp_no
join titles as t
on de.emp_no = t.emp_no
join
(select concat(e.first_name, ' ', e.last_name) as 최고연봉자
from employees as e
join salaries as s
on e.emp_no = s.emp_no
join dept_emp as de
on e.emp_no = de.emp_no
where de.dept_no = 'd001'
order by s.salary desc
limit 1) as e
where de.dept_no = 'd001';


-- 문제 12
-- 마케팅 부서에 시니어 스태프 사원 수를 출력 (서브쿼리 사용)
-- 출력 dept_no, title, 직원수, dept_name
select d.dept_no, t.title, count(de.emp_no) as 직원수, d.dept_name
from dept_emp as de
join titles as t
on de.emp_no = t.emp_no
join departments as d
on de.dept_no = d.dept_no
where t.title = 'Senior Staff' and d.dept_name =
(select d.dept_name from departments as d where d.dept_name = 'Marketing')
group by d.dept_no;

