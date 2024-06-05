use employees;

-- 테이블 복사(구조만 복사)
create table dept_emp_copy
as select * from dept_emp
where 1 = 0;

select * from dept_emp_copy;
desc dept_emp_copy;

-- 테이블 구조와 데이터 모두 복사
create table employees_copy
as select * from employees;

select * from employees_copy;

-- 기존 테이블의 데이터를 이용하여 새 데이터를 삽입할 수 있습니다.
-- insert into select문 사용

delete from dept_emp_copy;

insert into dept_emp_copy(emp_no, dept_no, from_date, to_date)
select emp_no, dept_no, from_date, to_date
from dept_emp
where emp_no > 20001;