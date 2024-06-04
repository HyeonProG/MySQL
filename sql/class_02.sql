-- 데이터 집합 생성
create database db_tenco_market;

-- 사용
use db_tenco_market;

-- db 삭제 명령어
-- drop database db_tenco_market;

-- 사전 기반 지식 : mysql 은 대소문자를 구별하지 않는다.
-- 단, 구분하는 RDBMS 도 있다.

-- 테이블 설계하기

-- 고객 테이블 생성
create table userTBL(
	userName char(3) not null primary key,
    birthYear int not null,
    addr char(2) not null,
    mobile char(12)
);

show tables;

select * from userTBL;

desc userTBL;

-- 구매 테이블 생성
create table buyTBL(
	id int not null auto_increment, -- 상품이 추가될 때 마다 자동으로 숫자를 매긴다.
    userName char(3) not null,
    prodName char(3) not null,
    price int not null,
    amount int,
    primary key(id),
    foreign key(userName) references userTBL(userName)
);

show tables;
select * from buyTBL;
desc buyTBL;