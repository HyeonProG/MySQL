use demo3;

-- 복합키 생성 방법 확인
create table 수강정보(
	학생ID int,
    과목코드 varchar(10),
    과목명 varchar(10),
    담당교수 varchar(10),
    primary key(학생ID, 과목코드)
);


-- 수강 정보 테이블 만들기
create table 수강정보(
	학생ID int,
    과목코드 varchar(10),
    primary key(학생ID),
    foreign key(과목코드) references 수강정보(과목코드)
);

-- 과목 정보 테이블 만들기
create table 과목정보(
	과목코드 varchar(10),
    과목명 varchar(10),
    담당교수 varchar(10)
);
