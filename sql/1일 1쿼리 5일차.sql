select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

-- 문제 1
-- 급여가 85000 이상인 근무중인 직원들 중 생일이 6월달인 직원을 출력(급여가 높은 순으로)
-- 출력 예시 : 직원 이름, 생일, 급여
select concat(e.first_name, ' ', e.last_name) as name, e.birth_date, s.salary
from salaries as s
left join employees as e
on s.emp_no = e.emp_no
left join dept_emp as de
on s.emp_no = de.emp_no
where de.to_date = '9999-01-01' and s.salary >= 85000
and date_format(e.birth_date, '%m') = '06'
order by s.salary desc;

-- 문제 2
-- 현재 근무 중인 직원들 중에 38년 이상 근무했으나 직급이 Staff이고 salary_standard가 Low인 직원만 출력해주세요.
-- (salary가 70000 이상이면 'High', 50000 이상이면 'Medium', 50000 미만이면 'Low'라고 표시하되 표기명은 salary_standard입니다.)
-- (단, 같은 직원일 경우 가장 높은 급여만 'max_salary'라는 표기로 출력해야 합니다.)
select e.emp_no,e.first_name,e.last_name,t.title, MAX(s.salary) as max_salary, 
case
when MAX(s.salary) >= 70000
then 'High'
when MAX(s.salary) >= 50000
then 'Medium'
else 'Low'
end as 'salary_standard'
from salaries as s
join employees as e
on s.emp_no = e.emp_no
join titles t
on e.emp_no = t.emp_no 
where t.to_date = '9999-01-01'
and year(current_date) - year(hire_date) >= 38
and t.title = 'Staff'
group by s.emp_no
having salary_standard = 'Low';

-- 문제 3. 
-- db sakila 에서 각 언어 마다 몇개의 영화가 있는지 조회하라 (데이터상 모든 영화가 영어지만, 다른 언어가 0개 임을 표현해야함)
select l.name, count(f.language_id) as count
from language as l
left join film as f on l.language_id = f.language_id
group by l.language_id;

-- 문제 4(demo3 DB 사용)
-- 남성 셔츠 여성 면바지 남성 슬랙스의 각자의 가격을 구하시오
use demo3;
select * from tb_categories;
select * from tb_products;

select p.product_name, p.price, p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where p.product_name = '남성셔츠'
or p.product_name = '여성면바지'
or p.product_name = '남성슬랙스';

-- 문제 5(employees DB 사용)
-- 재직중이고 1995년 이후 입사한 Senior Engineer 직원이 가장 많은 부서 3개를 출력하세요
select d.dept_name as '부서', count(de.emp_no) as '직원수'
from dept_emp as de
join titles as t
on de.emp_no = t.emp_no
join departments as d
on de.dept_no = d.dept_no
join employees as e
on de.emp_no = e.emp_no
where year(e.hire_date) >= 1995 
and de.to_date = '9999-01-01'
and t.title = 'Senior Engineer'
group by d.dept_name
order by 직원수 desc
limit 3;

-- 문제 6
-- 가장 인원이 많은 부서의 매니저 이름을 출력하세요. db = employees
-- (정답 = first_name : Leon , last_name : DasSarma)
-- (퇴사한 매니저는 제외 && 퇴사 직원 제외)
-- (서브쿼리를 사용 안해도 가능)
select e.first_name, e.last_name
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no
join( select dept_no, count(*) as a
        from dept_emp
        where to_date = '9999-01-01'
        group by dept_no
        order by a desc
        limit 1
        ) as count_max_dept
on dm.dept_no = count_max_dept.dept_no
where dm.to_date = '9999-01-01';


-- 문제 7
-- 데이터베이스 db_tenco_market 에서 '김범수' 고객의 최종합계금액을 조회하세요.
use db_tenco_market;
select * from buytbl;
select * from usertbl;

select u.userName, sum(price) as '최종금액'
from usertbl as u
join buytbl as b
on u.userName = b.userName
where u.userName = '김범수'
group by u.userName;


-- 문제 8
-- demo3에서 남성슬랙스, 여성면바지의 상품이름, 가격, 사이즈, 색상을 출력하시오 
-- 단, 서브쿼리를 쓰시오.
use demo3;
select * from tb_categories;
select * from tb_products;

select p.product_name, p.price, p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '슬랙스'
and c.parent_id =
(select category_id from tb_categories where category_name = '팬츠'
and parent_id = 1)
or c.category_name = '면바지'
and c.parent_id =
(select category_id from tb_categories where category_name = '팬츠'
and parent_id = 2);


-- 문제 9
-- 제일 비싼 상품을 가지고 있는 카테고리를 출력(카테고리 이름 + 상품 이름 + 가격 )  
-- mydb3 의 tb_products, tb_categories 사용
use mydb3;
select * from tb_categories;
select * from tb_products;

select c.category_name, p.product_name, p.price
from tb_categories as c
join tb_products as p
on c.category_id = p.category_id
order by p.price desc
limit 1;


-- 문제 10
-- 현재 어느 부서의 매니저도 아닌 직원 중, 재직중이며 연봉이 100000이 넘는 직원을 조회하세요. 
-- (사원번호,first_name,last_name,연봉)
select e.emp_no, e.first_name, e.last_name, s.salary
from employees as e
left join dept_emp as de
on e.emp_no = de.emp_no
left join salaries as s
on e.emp_no = s.emp_no
left join titles as t
on e.emp_no = t.emp_no
where de.to_date = '9999-01-01' and t.title != 'Manager'
and s.salary >= 100000
group by e.emp_no;


-- 문제 11
-- 직원번호 10033 직원의 최고 연봉액과 근무일수를 구하시오
select max(s.salary) as '최고연봉', datediff(de.to_date, de.from_date) + 1 as '근무일수'
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join salaries as s
on e.emp_no = s.emp_no
where e.emp_no = 10033;


-- 문제 12
-- 부서 번호가 d009인 부서에서 재직중이며 매니저가 있는 직원을 조회하여라.(직원 번호, 이름, 부서명)
-- 단, 서브쿼리를 사용하여 departments 테이블의 dept_name에 담아서 출력하여라.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no
join departments as d
on dm.dept_no = d.dept_no
where dm.to_date = '9999-01-01'
and d.dept_name =
(select dept_name
from departments
where dept_no = 'd009');


-- 문제 13
-- demo3 데이터베이스를 사용하여 색깔이 '퍼플' 인 남성복 셔츠의 정보를 조회하시오.
-- ( 서브쿼리 사용 )
use demo3;
select * from tb_categories;
select * from tb_products;

select p.product_name, p.price, p.size, p.color, c.category_name
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where p.color = '퍼플'
and c.category_id =
(select category_id
from tb_categories
where category_name = '셔츠' and parent_id = 1);