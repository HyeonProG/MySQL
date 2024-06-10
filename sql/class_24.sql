CREATE TABLE tb_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO tb_employees (name, department, salary) VALUES
('John Doe', 'Sales', 48000000),
('Jane Smith', 'Sales', 55000000),
('Alice Johnson', 'Marketing', 50000000),
('Chris Lee', 'Marketing', 45000000),
('Bob Brown', 'HR', 35000000),
('Patricia Pink', 'HR', 40000000),
('Michael White', 'Engineering', 75000000),
('Anna Black', 'Engineering', 65000000),
('Linda Green', 'Engineering', 72000000),
('James Red', 'Engineering', 68000000),
('Larry Blue', 'Sales', 52000000),
('Jessica Purple', 'Sales', 51000000),
('Amber Yelow', 'Marketing', 47000000),
('Peter Orange', 'HR', 43000000),
('Lisa Teal', 'HR', 39000000);

select * from tb_employees;

-- 문제 1 : 각 부서별 평균 급여 계산. 단, 소수점은 제거
-- select department, truncate(avg(salary), 0) as 평균
select department, round(avg(salary), 0) as 평균
from tb_employees
group by department;

-- 문제 2 : 평균 급여가 50,000,000 이상인 부서를 출력
select department, truncate(avg(salary), 0) as 평균
from tb_employees
group by department
having avg(salary) >= 50000000;


-- 문제 3 : 각 부서에서 가장 높은 급여를 받는 직원의 급여 금액을 출력
select name, department, max(salary)
from tb_employees
group by department;

select * from tb_employees;

-- 문제 4 : 특정 부서에서 근무하는 직원 수가 3명 이상인 부서만 출력
select department, count(department) as 직원수
from tb_employees
group by department
having 직원수 >= 3;

-- 문제 5 : 각 부서별 평균 급여와 직원 수를 출력
select department, count(department) as 직원수, truncate(avg(salary), 0) as 평균
from tb_employees
group by department;


-- order by(asc - 오름차순, desc - 내림차순) 와 limit 그리고 offset
select id, name, class, score
from tb_student
where score > 80
order by score desc
limit 3;

-- offset의 이해 limit (3, 0) 두 번째가 limit 가 된다.
-- 앞에 3이 offset이 된다.
-- offset의 숫자는 0부터 시작된다.
select id, name, class, score
from tb_student
limit 3, 3;

