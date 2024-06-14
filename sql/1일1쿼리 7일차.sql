select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

-- 문제 1
-- 1995년 이후에 입사한 현재 근무중인 직원들 중 '개발'부서에 '엔지니어' 직함을 
-- 가지고 있는 평균 연봉이 가장 높은 직원 10명을 출력
select concat(e.first_name, ' ', e.last_name) as 이름, e.hire_date as 고용일,
de.dept_no as 부서번호, d.dept_name as 부서, t.title as 직함, avg(s.salary) as 급여
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
join titles as t
on e.emp_no = t.emp_no
join salaries as s
on e.emp_no = s.emp_no
where t.title = 'Engineer' and d.dept_name = 'Development'
and de.to_date = '9999-01-01' and t.to_date = '9999-01-01' 
and e.hire_date >= '1995-01-01'
and s.salary >= 80000
group by e.emp_no
order by avg(s.salary) desc
limit 10;

-- 문제 2
-- 각 언어별로 사용하는 인구가 얼마나 되는지 조회하라, 내림차순
-- 언어, 인구수
use world;
select * from city;
select * from country;
select * from countrylanguage;

SELECT sbq.Language, SUM(인구) AS 전체인구
FROM (
	SELECT cl.*, c.Population, ROUND((cl.Percentage * c.Population) / 100) AS 인구
	FROM countrylanguage AS cl
	JOIN country AS c ON cl.CountryCode = c.Code) AS sbq
GROUP BY Language
ORDER BY 전체인구 DESC;

-- 문제 3
-- world db에서 country 테이블과 contrylanguage를 활용하여 
-- 'KOR'의 국가코드, 지역, 정부, 언어를 출력해라
select c.Code, c.Region, c.GovernmentForm, cl.Language
from country as c
join countrylanguage as cl
on c.Code = cl.CountryCode
where c.Code = 'KOR' and cl.Isofficial = 'T';


-- 문제 4
-- Development 부서에서 재직중인 매니저인 직원의 최대 연봉을 조회하시오. 
-- (직원 번호, 이름, 부서명, 최대 연봉)
select e.emp_no as 직원번호, concat(e.first_name, ' ', e.last_name) as 이름, d.dept_name as 부서명, max(s.salary) as 최대연봉
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no
join departments as d
on dm.dept_no = d.dept_no
join salaries as s
on e.emp_no = s.emp_no
where dm.to_date = '9999-01-01' and d.dept_name = 'Development';


-- 문제 5
-- 각 부서별로 1985년 5월 31일 이전 입사자의 사원번호, 사원명
-- (first_name, last_name 합쳐서), 짝수 월(month) 이면서 홀수 일(day) 인 입사날짜,
-- to_date, 근무년수,  현재 재직중이면 '재직'을, 퇴사했으면 '퇴사'를출력하세요. 
-- (사원번호, 입사날짜 오름차순으로)
-- (emp_no, name, hire_date, to_date, 근무년수, 재직여부)
select e.emp_no as 사원번호, concat(e.first_name, ' ', e.last_name), 
e.hire_date as 입사날짜, de.to_date,
case when (de.to_date = '9999-01-01') then '재직' else '퇴사' end as '재직여부',
case when (de.to_date = '9999-01-01') then(year(current_date()) - year(e.hire_date)) 
when (de.to_date != '9999-01-01') then (year(de.to_date)- year(e.hire_date)) end as 근무년수
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
where e.hire_date < '1985-05-31'
and (month(e.hire_date) % 2) = 0
and (day(e.hire_date) % 2) = 1
group by e.emp_no
order by e.emp_no, e.hire_date asc;


-- 문제 6
-- 문제 : 마케팅 부서의 남자를 출력하세요
-- (emp_no, dept_no, dept_name, gender, name)
-- name -> first_name + last_name
select e.emp_no as 사원번호, d.dept_no as 부서번호, d.dept_name 부서,
e.gender as 성별, concat(e.first_name, ' ', e.last_name) as 이름
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
where e.gender = 'M' and d.dept_name = 'Marketing'
group by e.emp_no;


-- 문제 7
-- 오늘자(년도 x) 생일자를 구하고 해당 부서의 매니저를 출력하시오
select concat(e.birth_date) as 생일자 ,
concat(e.first_name ,' ',e.last_name) as 이름, dm.emp_no as 매니저
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join dept_manager as dm
on de.dept_no = dm.dept_no
where de.to_date = '9999-01-01'
and month(e.birth_date) = month(current_date())
and day(e.birth_date) = day(current_date())
group by e.emp_no;


-- 문제 8 
-- 현재 재직중인 인원 중 권고사직할 인원 10명을 랜덤으로 추출하시오 
-- (출력값 직원번호, 풀네임)
select e.emp_no, concat(e.first_name, ' ', e.last_name) as 권고사직
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
where de.to_date = '9999-01-01'
order by rand()
limit 10;

-- 문제 9
-- 재직중인 senior engineer 의 평균연봉을 구하시오 (서브쿼리이용)
select emp_no, 평균연봉
from
	(select emp_no, avg(salary) as 평균연봉
	from salaries
    where emp_no in 
		(select emp_no
        from titles
        where to_date = '9999-01-01' and title = 'Senior Engineer')
	group by emp_no) 
as avg_s;
