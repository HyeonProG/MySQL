create database db_movie;

use db_movie;

create table movies(
	id int primary key auto_increment,
    title varchar(50) not null unique,
    director varchar(20),
    release_date date not null,
    genre varchar(20),
    rating double 
);

desc movies;

insert into movies(title, director, release_date, genre, rating)
values
('괴물', '봉준호', '2006-07-27', '드라마', 8.28),
('극한직업', '이병헌', '2019-01-23', '코미디', 9.20),
('명량', '김한민', '2017-07-30', '사극', 9.17),
('신과함께-죄와 벌', '김용화', '2017-12-20', '판타지', 7.56),
('밀양', '임권택', '2016-09-07', '드라마', 7.76),
('반도', '연상호', '2020-07-15', '액션', 6.71),
('베테랑', '류승완', '2015-08-05', '액션', 8.49),
('변호인', '양우석', '2013-12-18', '드라마', 8.41),
('군함도', '류승완', '2017-07-26', '사극', 8.01),
('암살', '최동훈', '2015-07-22', '액션', 8.37);

select * from movies;

-- 문제 1
-- id 가 3인 영화의 director 명을 '이순신'으로 수정
update movies set director = '이순신' where id = 3;

-- 문제 2
-- rating 이 7.0 이하인 영화의 rating 을 null 로 수정
update movies set rating = null where rating <= 7.0;

-- 문제 3
-- release_date 가 2015-01-01 이후인 영화를 출력
select * from movies where release_date >= '2015-01-01';

-- 문제 4
-- rating이 9.0 이상 이고 release_date 가 2018-01-01 이후인 영화 출력
select * from movies where rating >= 9.0 and release_date >= '2018-01-01';

-- 문제 5
-- genre 가 코미디 이거나 rating 이 8.0 이상인 영화 출력
select * from movies where genre = '코미디' or rating >= 8.0;

-- 문제 6
-- genre 가 드라마, 판타지, 사극인 영화 출력
select * from movies where genre in('드라마', '판타지', '사극');