select * from employees;
select * from dept_emp;
select * from dept_manager;
select * from salaries;
select * from departments;
select * from titles;


-- 전직원 2000년도의 연봉을 출력하세요(출력 예시 :  id , firstname, lastname,slalary)
select e.emp_no, e.first_name, e.last_name , s.salary
from employees as e
join salaries as s
on e.emp_no = s.emp_no
where s.from_date like '2000%';

-- 'd004'  부서의 남자직원의 이름을 출력하세요 (출력예시 : firstname , M , 'd004' )
select e.first_name , e.gender , d.dept_no 
from employees as e
join dept_emp  as d
on e.emp_no = d.emp_no
where e.gender = 'M' and d.dept_no = 'd004' ;


-- 각 직원의 정보를 확인하기 (직원번호, 생년월일, 이름, 성,부서번호, 부서명, 직업명)
select e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, de.dept_no, d.dept_name, t.title
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
left join departments as d
on de.dept_no = d.dept_no
left join titles as t
on e.emp_no = t.emp_no;

-- 1990년 이상 입사자 이름과 급여 부서 직책
select e.last_name, e.first_name, e.hire_date, s.salary, d.dept_no, t.title
from employees as e
left join salaries as s
on e.emp_no = s.emp_no 
left join dept_emp as d
on e.emp_no = d.emp_no 
left join titles as t 
on e.emp_no = t.emp_no
where e.hire_date >= '1990-01-01' and d.dept_no = 'd005';


-- dept_emp 와 employees 테이블 에 모든 데이터를  emp_no를 기준으로 조인하여 조회
-- 단(employees의 birth_date가 '05'를 포함하고,성별은 '남성'일 경우)
select *
from dept_emp as d
join employees as e
on d.emp_no=e.emp_no
where e.birth_date like '%05%' and e.gender='M';

-- 모든 마케팅 부서 직원의 이름을 조회
select e.emp_no,e.first_name,e.last_name,d.dept_name
from dept_emp as de
join employees as e on de.emp_no = e.emp_no
join departments as d on de.dept_no= d.dept_no
where d.dept_name = 'Marketing'; 


-- 아직 재직중인 사람의 이름과 성 직급 입사일자를 출력해 보자.
select e.first_name, e.last_name, t.title, e.hire_date
from employees as e
join titles as t
on e.emp_no = t.emp_no
where t.to_date = '9999-01-01';

-- 부서 매니저들의 평균 연봉을 추출해 보자.
select avg(s.salary)
from dept_manager as dm
join salaries as s
on dm.emp_no = s.emp_no;


-- 부서 매니저의 연봉이 100,000 달러 이상인 사람을 확인하시오 (출력예시 : 사원번호,입사날짜,연봉) 
select dm.emp_no, dm.from_date, s.salary
from dept_manager as dm
join salaries as s
on dm.emp_no = s.emp_no
where s.salary >= 100000;

-- 8월 15일에 고용한 직원들에게 태극기를 지급하기로 했다. 사원 번호, 고용 날짜와 last_name을 조회하시오
select e.emp_no, e.hire_date, e.last_name
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
where e.hire_date like '%08-15';

-- 현재 재직중인 사람중 입사일이 1991-10-10 인 사람의 부서를 찾아주세요.
select d.dept_name, de.from_date, de.to_date
from dept_emp as de
join departments as d
on de.dept_no = d.dept_no
where de.from_date = '1991-10-10' and de.to_date = '9999-01-01';

-- 시니어 엔지니어의 월급중 6만달러가 넘는 사람이 몇명인지 찾아주세요.
select t.title, s.salary
from titles as t
join salaries as s
on t.emp_no = s.emp_no
where s.salary >= 60000;