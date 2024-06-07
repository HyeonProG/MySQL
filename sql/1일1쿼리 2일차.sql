select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


-- 문제 1
-- 사원의 평균 급여와 최대, 최소 급여를 구하세요.
select avg(salary), max(salaries.salary), min(salaries.salary)
from salaries;

-- 문제 2
-- 부서 이름과 부서별 인원, 그 부서별 평균 급여를 출력하세요.
-- ex) 부서 이름, 직원 수, 평균 급여
select d.dept_name, count(de.emp_no) as '직원수', avg(s.salary) as '평균 급여'
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
left join departments as d
on d.dept_no = de.dept_no
left join salaries as s
on s.emp_no = e.emp_no
group by d.dept_name;

-- 문제 3
-- salaries테이블의 salary(연봉)을 월급으로 나누고(환율1365)
-- dept_name, dept_no, emp_no, from_date,to_date 조회하시오(조인필요)
-- 단 (from,to _date)는 salary의 테이블, 월급은 1,000,000 이상부터 나머지는 테이블 관계 X
select s.emp_no,substring((s.salary/12*1365),1,10) as '월급(년)',
        de.dept_no,de.dept_name,s.from_date,s.to_date
from salaries as s
left join dept_emp as e
on s.emp_no=e.emp_no
left join departments as de
on e.dept_no=de.dept_no
where substring((s.salary/12*1365),1,10)>1000000;

-- 문제 4
-- 매니저들의 최고 급여를 추출하세요.
select dm.emp_no, e.first_name, e.last_name, max(s.salary)
from dept_manager as dm
join salaries as s
on dm.emp_no = s.emp_no
join employees as e
on e.emp_no = dm.emp_no
group by dm.emp_no;

-- 문제 5
-- 퇴사자와 재직자를 구분 하며 퇴사자의 경우 재직년수를 출력하세요
-- (출력예시 = first_name, last_name, 근무상태(재직중 or 퇴사자경우 근무연수 
-- 단, 부서 이동을 했을 때 이전 부서의 근속년수와 재직중 작성))
select e.first_name, e.last_name,
case
when de.to_date != '9999-01-01'
then (year(current_date)) - (year(de.to_date))
else '재직중'
end as '근무년수'
from dept_emp as de
join employees as e
on de.emp_no = e.emp_no;

-- 문제 6
-- 직원의 이름, 근무연수, 부서를 출력하시오.
-- 단 , 직원의 이름은 퍼스트네임, 라스트네임을 합쳐쳐서 표에 나타내고 
-- 근무연수는 35년 이상 직원의 직원들만 포함시키시오. 
select concat(e.first_name, ' ', e.last_name) as '이름',
(year(current_date) - year(e.hire_date)) as '근무년차',
d.dept_name as '부서'
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
left join departments as d
on d.dept_no = de.dept_no
where ((year(current_date)) - (year(e.hire_date)) >= 35);

-- 문제 7
-- 부서 이름과 그 부서에 현재근무하는 직원에 정보를 출력 하세요.
select e.first_name, e.last_name, d.dept_name, de.from_date
from departments as d
left join dept_emp as de
on d.dept_no = de.dept_no
left join employees as e
on de.emp_no = e.emp_no
where de.to_date != '9999-01-01';

-- 문제 8
-- 회사 CEO가 근속 20년이 넘은 직원들을 대상으로 14일의 안식 휴가와 감사패를 
-- 지급하기로 결정했습니다. 해당하는 직원들의 근속 년수와 풀네임을(한 컬럼) 출력하시오.
select concat(e.first_name, ' ', e.last_name) as '이름',
(year(current_date)) - (year(de.from_date)) as '근속 년수'
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
where (year(current_date)) - (year(de.from_date)) >= 20; 

-- 문제 9
-- 재직 중인 사람의 이름과 년차수를 출력 하세요.
select e.first_name, e.last_name,
(year(current_date)) - (year(de.from_date)) as '근속 년수'
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
where de.to_date = '9999-01-01';

-- 문제 10
-- first_name의 두 번째 알파벳이 a인 직원의 평균연봉을 구하세요.
select e.first_name, e.last_name, avg(s.salary)
from employees as e
join salaries as s
on e.emp_no = s.emp_no
where substring(e.first_name, 2, 1) = 'a'
group by e.first_name;

-- 문제 11
-- 각 부서별 직원의 수와 평균 연봉을 구하세요.
-- 표시 예시('부서', '직원수' ,avg)
select d.dept_name as '부서', count(de.emp_no) as '직원수', avg(s.salary) as '평균 연봉'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on d.dept_no = de.dept_no
join salaries as s
on s.emp_no = e.emp_no
group by d.dept_name;


-- 문제 12
-- 마케팅부 30년차 근로자들 중 연봉이 80000 이상이면 O 아니면 X로 표기하세요.
-- 이름(first_name + last_name), 년차, 연봉, 체크(O,X) 로 표시
select concat(e.first_name, ' ', e.last_name) as '이름',
(year(current_date)) - (year(de.from_date) + 1) as '년차',
s.salary as '연봉',
case
when s.salary >= 80000 then 'O' else 'X' end as '체크'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join salaries as s
on e.emp_no = s.emp_no
where de.dept_no = 'd001'
and de.to_date = '9999-01-01'
and (year(current_date)) - (year(de.from_date) + 1) = 30;

-- 문제 13
-- 현재 근무중인 근로자들의 직급(title)별 평균연봉을 나타내세요
-- 직급, 평균연봉(소수점 제외) 로 표시
select t.title as '직급', cast(avg(s.salary)as decimal(6)) as '평균 연봉'
from titles as t
join salaries as s
on t.emp_no = s.emp_no
where t.to_date = '9999-01-01'
group by t.title;