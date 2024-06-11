create database m_board;
use m_board;

create table user(
	id int primary key auto_increment,
    userName varchar(100) not null unique,
    password varchar(255) not null,
    email varchar(100) not null,
    userRole varchar(20),
    createDate timestamp
);

select * from user;

-- board table, reply table 설계 
create table board(
	id int primary key auto_increment,
    userId int,
    title varchar(100) not null,
    content text,
    foreign key(userId) references user(id)
);

select * from board;

create table reply(
	id int primary key auto_increment,
    userId int,
    boardId int,
    content varchar(300) not null,
    createDate timestamp,
    foreign key(userId) references user(id) on delete set null,
    foreign key(boardId) references board(id)
);

select * from reply;

-- 스키마 구조를 변경하는 쿼리 --> DDL
-- user 테이블에 address 컬럼을 추가해주세요.
alter table user add address varchar(100) not null;

INSERT INTO user (username, password, email, address, userRole, createDate)
VALUES
('홍길동', '1234', 'hong@example.com', '서울시 강남구', 'admin', NOW()),
('이순신', '1234', 'lee@example.com', '부산시 해운대구', 'user', NOW()),
('김유신', '1234', 'kim@example.com', '대구시 수성구', 'user', NOW());


-- board 테이블에 readCount 컬럼을 추가해주세요.
alter table board add readCount int;

INSERT INTO board (userId, title, content, readCount)
VALUES
(1, '첫 번째 글입니다', '안녕하세요, 홍길동입니다. 이것은 테스트 게시글입니다.', 150),
(2, '이순신의 포스팅', '부산에서 이순신입니다. 바다가 아름다운 날입니다.', 45),
(3, '대구의 뜨거운 여름', '여름이 기승을 부리는 대구에서 김유신입니다.', 30);


INSERT INTO reply (userId, boardId, content, createDate)
VALUES
(2, 1, '홍길동님의 글 잘 읽었습니다!', NOW()),
(3, 1, '저도 의견이 같네요.', NOW()),
(1, 2, '부산도 좋지만 서울도 좋아요!', NOW()),
(1, 3, '대구가 그렇게 덥군요, 조심하세요!', NOW());

-- 특정 사용자의 게시글 조회(사용자 ID가 1인 홍길동의 모든 게시글을 보고싶다면)
select b.title, b.content, b.readCount
from board as b
where b.userId = 1;

-- 1번 게시글에 대한 모든 댓글 조회
select u.userName, r.content, r.createDate
from reply as r
left join user as u
on r.userId = u.id
where r.boardId = 1;

-- 게시글 댓글 달기
-- 예를 들어, 사용자 ID 2가 게시글 ID 1에
-- "새로운 댓글입니다"라는 내용의 댓글을 추가하려면 다음 쿼리를 사용합니다.
-- insert into...
insert into reply(userId, boardId, content, createDate)
values
(2, 1, '새로운 댓글입니다', now());

-- 특정 사용자의 게시글 해당 게시글의 댓글 수 조회
-- 제목, 내용, 작성자 이름, 댓글 수
select b.title, b.content, u.userName, count(r.content) as 댓글수
from board as b
left join user as u
on b.userId = u.id
left join reply as r
on u.id = r.userId
group by b.id;

-- 조회수가 가장 높은 게시글 상위 2개 조회
select title, content, readCount
from board
order by readCount DESC
limit 2;
