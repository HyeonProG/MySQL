-- 사전 데이터 확인
select * from employees;
select * from dept_manager;

-- 1. employees 테이블에서 manager 직원만 출력
select *
from dept_manager
where to_date = '9999-01-01';

-- 직원 테이블에 매니저인 사원을 출력하자.
select *
from employees
where emp_no in
(select emp_no from dept_manager where to_date = '9999-01-01');


-- from절에 사용하는 인라인 뷰
-- 2. 현재 근무중인 매니저들의 평균 연봉 구하기
select * from dept_manager where to_date = '9999-01-01';
select * from salaries where emp_no = 10001;

-- 한 직원의 평균 연봉, emp_no를 group by 처리
select emp_no, avg(salary) as 평균연봉
from salaries as s
group by emp_no; 

-- 인라인 뷰 사용
select emp_no, 평균연봉
from 
(select emp_no, avg(salary) as 평균연봉
from salaries as s
group by emp_no) as avg_salary
where emp_no = '10001';


-- 인라인뷰, 중첩 서브쿼리를 동시에 사용
select emp_no, 평균연봉
from 
(select emp_no, avg(salary) as 평균연봉
from salaries as s
group by emp_no) as avg_salary
where emp_no in
(select emp_no 
from dept_manager
where to_date = '9999-01-01');
-- 23847.66 의 비용이 들었다.

-- 위와 같은 결과집합을 Inner Join을 활용해서 만들어 보자.
select dm.emp_no, avg(s.salary) as '평균연봉'
from dept_manager as dm
join salaries as s
on dm.emp_no = s.emp_no and dm.to_date = '9999-01-01'
group by dm.emp_no;
-- 7.16 의 비용이 들었다.

-- 스칼라 서브 쿼리 사용
-- 각 직원의 평균 연봉 구하기
select emp_no as outer_emp_no, 
(select avg(salary)
from salaries
where emp_no = outer_emp_no) as 평균연봉
from employees;
