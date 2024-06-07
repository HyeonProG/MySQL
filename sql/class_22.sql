-- 집계 함수 문제
-- 문제 1 : 모든 직원의 평균 급여를 계산하세요.
-- 단 주의!
-- avg() 평균의 합계와 다른 컬럼을 적는다면 관계가 없는 데이터 결과 집합이다.
select avg(salary) from employee;
-- select avg(salary), name, id from employee;

-- 문제 2 : 각 부서별로 직원 수를 세고, 부서별 급여의 합을 계산하세요.
-- 부서별, 부서별 직원수, 부서별 급여의 합계 금액
-- 그룹화 시켜야 한다.
select department, count(*) as '직원수', sum(salary) as '급여'
from employee
group by department;

-- 문자열 함수 문제
-- 문제 3 : 모든 직원의 이름을 대문자로 변환하고 이름 앞에 'Mr/Ms' 를 추가하세요.
select concat('Mr/Ms ', upper(name)) as '이름' 
from employee;

-- 문제 4 : 직원 이름에서 첫 2글자만 추출하세요.
select substring(name, 1, 2) as '이름' from employee;
-- 문제 4-1 : 직원 이름에서 끝 2글자만 추출하세요.
select right(name, 2) as '이름' from employee;

-- 문제 5 : 각 직원에 대한 급여가 3백만원 이상이면 
-- 'High', 아니면 'Low' 표시하세요.
select name, salary, 
case 
	when salary >= 3000000 then 'High'
	else 'Low' 
    end as '평가'
from employee;

-- 날짜 및 시간 함수 문제
-- 문제 6 : 오늘 날짜를 반환하세요.
select current_date as today;
select '안녕 반가워' as a;

-- 문제 7 : 각 직원이 고용된날 부터 몇 년이 지났는지 계산하세요.
select name, hire_date, 
	(year(current_date) - year(hire_date)) + 1
	as '년차'
from employee;

-- 문제 8 : 각 직원의 고용 월을 반환하세요.
select name, extract(month from hire_date) as hire_month
from employee;

-- 문제 9 : 각 직원의 급여를 문자열 형태로 표시하세요.
select name, cast(salary as char) as salary_text
from employee;

-- 문제 10 : 문자열로 저장된 날짜 '2024-06-07'를 Date 타입으로 변환하세요.
select cast('2024-06-07' as date) as date;


select * from employee;