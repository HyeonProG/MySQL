use employees;

desc employees;

select * from employees;

-- 문제 1
-- 사번이 10020번 아래인 사원 중 여성을 출력
select * from employees where emp_no <= 10020 and gender = 'F';

-- 문제 2
-- 고용 날짜가 1990년 5월 이면서 태어난 날짜가 1960년인 사원 출력
select * from employees where hire_date between '1990-05-01' and '1990-05-31' and birth_date between '1960-01-01' and '1960-12-31';

-- 문제 3
-- 사원 이름중 A로 시작하고 마지막 이름이 Z로 끝나는 사원 출력
select * from employees where first_name like 'a%' and last_name like '%z';

-- 문제 4
-- 사원들 중 고용 날짜가 1990년이고 생일이 30일인 사람을 출력
select * from employees where birth_date like '%30' and hire_date between '1990-01-01' and '1990-12-31';

-- 문제 5
-- 남자 사원들중 사원번호가 10010번 이하를 출력
select * from employees where emp_no <= 10010 and gender = 'M';