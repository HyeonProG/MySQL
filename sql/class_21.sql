-- 샘플 데이터
create table employee(
	id int,
    name varchar(50),
    department varchar(50),
    salary decimal(10, 2),
    hire_date date
);

INSERT INTO employee (id, name, department, salary, hire_date) VALUES
(1, '김철수', '인사부', 3000000.00, '2024-03-01'),
(2, '박영희', '개발부', 4000000.00, '2024-06-15'),
(3, '이민준', '기획부', 3500000.00, '2023-01-10'),
(4, '최지아', '마케팅부', 3200000.00, '2024-05-21'),
(5, '한수연', '영업부', 2900000.00, '2021-12-30');

select * from employee;
desc employee;

/*
	decimal란 데이터 타입이다.
    고정 소수점 수를 저장하는데 사용하는 SQL 데이터 타입
    이 데이터 타입은 금융 계산과 같이 정확한 소수점 연산이 필수적인
    애플리케이션에서 매우 유용하며, 소수점 이하의 정확도가 중요할 때 주로 사용
    형식 = decimal(5, 2)
    5 = 몇자리 숫자를 저장할 것인지 - 5자리
    2 = 이 중 몇자리를 소수부로 정할 것인지 - 2자리
    즉 -999.99 ~ 999.99 까지의 범위를 가진다
*/


-- 다른 DB에 있는 테이블에 스키마와 데이터를 복사해 보자
use mydb2;

create table new_employees
as select * from employees.employees
where emp_no < 10005;

select * from new_employees;