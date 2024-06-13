create database movies;
use movies;

create table movies(
	영화ID varchar(10) primary key,
    영화제목 varchar(50),
    개봉일 date,
    `매출액(만)` int,
    평점 double,
    `관객수(만)` int,
    감독ID varchar(10),
    foreign key(감독ID) references director(감독ID)
);

insert into movies values
('M1', '인셉션', '2010-07-21', '82000', 9.48, 601, 'D1'),
('M2', '다크나이트', '2008-08-06', '100000', 9.57, 428, 'D1'),
('M3', '올드보이', '203-11-21', '1700', 9.29, 326, 'D2'),
('M4', '살인의추억', '2003-04-25','8000', 9.63, 525, 'D3'),
('M5', '기생충', '2019-05-30', '26000', 9.07, 1031, 'D3');

create table actor(
	배우ID varchar(10) primary key,
    배우이름 varchar(50),
    배우생일 date,
    배우키 int
);

insert into actor values
('A1', '레오나르도 디카프리오', '1974-11-11', 183),
('A2', '마리옹 꼬띠아르', '1975-09-30', 166),
('A3', '크리스찬 베일', '1974-01-30', 183),
('A4', '히스 레저', '1979-04-04', 185),
('A5', '최민식', '1962-04-27', 177),
('A6', '오달수', '1968-06-15', 176),
('A7', '송강호', '1967-01-17', 180),
('A8', '김뢰하', '1965-11-15', 173),
('A9', '정지소', '1999-09-17', 162);

create table director(
	감독ID varchar(10) primary key,
    감독이름 varchar(50)
);

insert into director values
('D1', '크리스토퍼 놀란'),
('D2', '박찬욱'),
('D3', '봉준호');

create table appearance(
	영화ID varchar(10),
    배우ID varchar(10),
    역할 varchar(10),
    foreign key(영화ID) references movies(영화ID),
    foreign key(배우ID) references actor(배우ID)
);

insert into appearance values
('M1', 'A1', '주연'),
('M1', 'A2', '조연'),
('M2', 'A3', '주연'),
('M2', 'A4', '조연'),
('M3', 'A5', '주연'),
('M3', 'A6', '조연'),
('M4', 'A7', '주연'),
('M4', 'A8', '조연'),
('M5', 'A7', '주연'),
('M5', 'A9', '조연');
