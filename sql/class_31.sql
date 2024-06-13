create table tb_products(
	product_id int auto_increment primary key,
    product_name varchar(255),
    category_id int,
    price decimal(10, 2),
    size varchar(10),
    color varchar(50),
    foreign key(category_id) references tb_categories(category_id)
);

-- 남성복 상품 입력
insert into tb_products(product_name, category_id, price, size, color)
values
('남성셔츠', 4, 49000, 'L', '퍼플'),
('남성면바지', 7, 55000, 'M', '핑크'),
('남성슬랙스', 8, 105000, 'XL', '샤인');

-- 여성복 상품 입력
insert into tb_products(product_name, category_id, price, size, color)
values
('여성셔츠', 6, 49000, 'L', '퍼플'),
('여성면바지', 9, 55000, 'M', '핑크'),
('여성슬랙스', 10, 105000, 'XL', '샤인');

select * from tb_products;

-- 특정 카테고리에 속하는 모든 상품 조회
-- 1단계 (남성, 여성 팬츠에 속하는 상품을 모두 조회)
select p.product_name, p.price, p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지';

-- 2단계(만약 여성 면바지만 출력 해야 된다면)
-- 조인 --> 서브쿼리
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지' and c.parent_id = 5;

-- ----------------------------------------------------

select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지' 
and c.parent_id = 
(select category_id from tb_categories 
where category_name = '팬츠' and parent_id = 2);


select *, parent_id from tb_categories where category_name = '팬츠';
select parent_id from tb_categories where category_name = '팬츠';
select parent_id from tb_categories 
where category_name = '팬츠' and parent_id = 2;


-- 문제 1 남성복 셔츠만 출력
select p.product_name, p.price, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '셔츠' and c.parent_id = 1;


-- 문제 2 여성복 슬랙스만 출력
select p.product_name, p.price, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '슬랙스' 
and c.parent_id =
(select category_id from tb_categories 
where category_name = '팬츠' and parent_id = 2);


-- 특정 색상의 상품이 있는 모든 카테고리 조회
-- 예를 들어 '퍼플'상품이 있는 모든 카테고리를 조회
select c.category_name, p.product_name, p.price, p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where p.color = '퍼플';

-- 1단계
-- 결과집합에서 중복 제거를 할때 distinct
select distinct c.category_name
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where p.color = '샤인';

-- 가장 비싼 상품을 가진 카테고리 찾기
-- 각 카테고리 중 가장 비싼 상품을 가지고 있는 카테고리와 그 상품의 정보를 조회하는 쿼리
select c.category_name, p.product_name, max(p.price) as 'price', p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
group by c.category_id
order by max(p.price) desc
limit 2;

select *, max(p.price) as max_price
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
group by c.category_name
order by max_price desc
limit 1;