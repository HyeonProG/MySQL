create database mydb2;
use mydb2;

create table tb_student(
	student_id int auto_increment primary key,
    student_name varchar(100) not null
);

insert into tb_student(student_name)
values
('홍길동'),
('이순신');

select * from tb_student;

create table tb_class(
	class_id int auto_increment,
    class_name varchar(100) not null,
    teacher varchar(20) not null,
    primary key(class_id)
);

insert into tb_class(class_name, teacher)
values
('국어', '국어선생님'),
('수학', '수학선생님');

select * from tb_class;

-- 학생과 수업 테이블은 N:M 관계가 형성 된다.
-- 중간 테이블 설계(수강 등록 테이블)
create table tb_registration(
	student_id int,
    class_id int,
    registration_date date,
    primary key(student_id, class_id),
    foreign key(student_id) references tb_student(student_id),
    foreign key(class_id) references tb_class(class_id)
);

insert into tb_registration(student_id, class_id, registration_date)
values
(1, 1, '2024-05-01'),
(2, 2, '2024-05-02');

desc tb_registration;
select * from tb_registration;