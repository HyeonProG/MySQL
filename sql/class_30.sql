create database demo3;
use demo3;

-- 카테고리 테이블(상위, 하위 개념 추가)
create table tb_categories(
	category_id int auto_increment primary key,
    parent_id int null,
    category_name varchar(100),
	foreign key(parent_id) references tb_categories(category_id)
);

insert into tb_categories(category_name) values('남성복');
insert into tb_categories(category_name) values('여성복');

select * from tb_categories;

-- 남성복의 하위 카테고리
insert into tb_categories(category_name, parent_id) 
values('팬츠', 1);
insert into tb_categories(category_name, parent_id) 
values('셔츠', 1);

-- 여성복의 하위 카테고리
insert into tb_categories(category_name, parent_id) 
values('팬츠', 2);
insert into tb_categories(category_name, parent_id) 
values('셔츠', 2);

-- 남성복 팬츠의 하위 카테고리
insert into tb_categories(category_name, parent_id) 
values('면바지', 3);
insert into tb_categories(category_name, parent_id) 
values('슬랙스', 3);

-- 여성복 팬츠의 하위 카테고리
insert into tb_categories(category_name, parent_id) 
values('면바지', 5);
insert into tb_categories(category_name, parent_id) 
values('슬랙스', 5);

select * from tb_categories;