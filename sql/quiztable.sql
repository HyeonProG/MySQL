-- 데이터베이스 생성

create database quizdb;
use quizdb;

create table quiz(
	id int auto_increment primary key,
    question varchar(500) not null,
    answer varchar(500) not null
);

desc quiz;

-- 기본 샘플 데이터 입력
insert into quiz(question, answer) values
('대한민국의 수도는?', '서울'),
('한반도의 남쪽에 위치한 나라는?', '대한민국'),
('세계에서 가장 높은 산은?', '에베레스트'),
('태양계의 세 번째 행성은?', '지구'),
('한국의 전통 명절 중 하나로, 음력 8월 15일에 해당하는 날은?', '추석'),
('임진왜란의 종전 년도는?', '1598'),
('고기압과 저기압에서 바람이 부는 방향은?', '고기압');

-- 랜덤으로 값 뽑아내기 rand() 
select * from quiz order by rand() limit 1;

select * from quiz;
