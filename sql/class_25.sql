-- 사용자 생성하기(비밀번호 함께 설정)

-- 사용자 계정 생성은(원격지, 로컬 환경)이 있다.
-- 원격지에서 접근하는 사용자 계정 생성
-- 루트 권한을 제외하고 비밀번호 설정에 대한 제약이 있을 수 있다.
create user 'tenco1'@'%' identified by '1q2w3e4r5t!';

-- localhost에서 접근 가능한 계정 생성
create user 'tenco1'@'localhost' identified by '1q2w3e4r5t!';

-- 사용자 계정 권한 확인
show grants for 'tenco1'@'%';
show grants for 'tenco1'@'localhost';

-- 작업별 권한 할당
-- grant select, insert, update, delete on mydb2.* to 'tenco1'@'%';
grant select, update, delete on mydb2.* to 'tenco1'@'%';
grant select, update, delete on mydb2.* to 'tenco1'@'localhost';

-- root 권한으로 새로운 사용자 생성 및 권한 할당
-- 권한 바로 적용하기(세션 종료 후 재접속 하면 적용됨)
flush privileges;

create user 'tenco2'@'%' identified by '1q2w3e4r5t!';
grant select on mydb2.* to 'tenco2'@'%';
grant select on mydb3.* to 'tenco2'@'%';

-- 현재 나의 RDBMS에 연결되어 있는 세션을 확인하는 명령어
show processlist;
