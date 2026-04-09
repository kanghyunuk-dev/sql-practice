use shopdb;
-- ------------------------------
-- PK 제약조건
-- ------------------------------
-- 01 테이블 생성시 PK 제약조건 포함
create table tbl_a(
	id varchar(45) primary key,
    name varchar(45) not null
);
-- desc tbl_a;
-- select table_name,column_name,data_type,column_key from information_schema.columns where table_schema='shopdb' and table_name='tbl_a';

create table tbl_b(
	id varchar(45) ,
    name varchar(45) not null,
    primary key(id)
);
desc tbl_b;

create table tbl_c(
	id varchar(45) ,
    name varchar(45) not null,
    primary key(id,name)
);
desc tbl_c;

-- 02 기존 테이블에 PK 제약조건 추가
create table tbl_d(
	id varchar(45) ,
    name varchar(45) not null
);

desc tbl_d;
alter table tbl_d add constraint PK_tbl_d primary key(id);



-- 03 PK 제약조건 제거
alter table tbl_d drop primary key;
desc tbl_d;

-- 복합키
create table tbl_e(
	id varchar(45) ,
    name varchar(45),
    primary key(id,name)
);
desc tbl_e;

-- 문제
-- buytbl을 C_buytbl로 구조+데이터 복사하고 num를 primary key 로 설정 해보세요
create table C_buytbl(select * from buytbl);
select * from C_buytbl;
desc C_buytbl;
alter table C_buytbl add constraint PK_C_buytbl primary key(num);

-- ------------------------------
-- FK 제약조건
-- ------------------------------
-- 테이블 생성시 FK 설정
create table tbl_test1(
	no int primary key,
    id varchar(45) not null,
    constraint FK_tbl_test1_tbl_a foreign key(id) references tbl_a(id)
);
desc tbl_test1;

-- FK OPTION 정리
-- CASCADE		: PK 열의 값 on Update , on Delete  이 변경시 FK 열의 값도 함께 변경 
-- No Action	: PK 열의 값이 변경시 FK 열의 값은 변경 X
-- RESTRICT		: PK,FK 열의 값의 변경 차단 
-- Set null		: PK 열의 값이 변경시 FK 열의 값을 NULL로 설정
-- Set Default	: PK 열의 값이 변경시 FK 열의 값은 Default 로 설정된 기본값을 적용

create table tbl_test2(
	no int primary key,
    id varchar(45) not null,
    constraint FK_tbl_test2_tbl_b foreign key(id) references tbl_a(id)
    on update cascade
    on delete cascade
);
-- 확인
desc tbl_test2;
select 
* 
from information_schema.referential_constraints
where 
constraint_schema='shopdb'
and
table_name='tbl_test2';
;

-- 기존 테이블에서 FK 추가
create table tbl_test3(
	no int primary key,
    id varchar(45) not null
);
desc tbl_test3;

alter table tbl_test3 
add constraint FK_tbl_test3_tbl_c 
foreign key(id) 
references tbl_c(id)
on update cascade
on delete cascade
;

-- 복합키에 대한 FK 
create table tbl_test4(
	no int primary key,
	id varchar(45) ,
    name varchar(45)    
);
desc tbl_test4;

alter table tbl_test4 
add constraint FK_tbl_test4_tbl_e 
foreign key(id,name) 
references tbl_e(id,name)
on update cascade
on delete cascade
;
desc tbl_test4;

-- FK 제거
desc tbl_test1;
alter table tbl_test1 drop foreign key FK_tbl_test1_tbl_a;

-- INDEX 제거
show index from tbl_test1;
alter table tbl_test1 drop index FK_tbl_test1_tbl_a;


-- FK명 모를 때 확인
show create table tbl_test2;

-- PK - FK 설정시 PK열의 테이블 삭제 x - 정상삭제
drop table tbl_e; -- x FK 참조되는 테이블이기 때문에 삭제 불가
drop table tbl_test4; -- FK 테이블 삭제 선행
drop table tbl_e; -- FK 테이블 삭제 가능

-- PK - FK 설정시 PK열의 테이블 삭제 x - 강제삭제
set foreign_key_checks = 0;
drop table tbl_a;
drop table tbl_b;
drop table tbl_c;
set foreign_key_checks = 1;

-- 문제 
-- buytbl 을 copy_buytbl로 구조 + 데이터 복사 이후
-- num를 PK 설정 
-- userid를 FK 설정(on delete Restrict on update cascade)
create table copy_buytbl(select * from buytbl);
alter table copy_buytbl add constraint PK_copy_buytbl primary key(num);
alter table copy_buytbl
add constraint FK_usertbl_copy_buytbl foreign key(userid) references usertbl(userid)
on update cascade
on delete restrict;
desc copy_buytbl;

-- ------------------------------
-- UNIQUE 제약조건(중복허용X ,NULL)
-- ------------------------------
create table tbl_test05
(
	id int primary key,
    name varchar(25),
    email varchar(50) unique
);
desc tbl_test05;
show index from tbl_test05;

create table tbl_test06
(
	id int primary key,
    name varchar(25),
    email varchar(50),
    constraint uk_email unique (email)
);
create table tbl_test07
(
	id int primary key,
    name varchar(25),
    email varchar(50)
);
alter table tbl_test07 add constraint Uk_tbl_test07_email unique(email);
desc tbl_test07;

-- 삭제 
alter table tbl_test07 drop constraint Uk_tbl_test07_email;

-- 확인
show create table tbl_test07;

-- ------------------------------
-- CHECK 제약조건
-- ------------------------------
create table tbl_test08
(
	id varchar(20) primary key,
    name varchar(20) not null,
    age int check(age>=10 and age<=50),	-- age는 10 - 50세 까지만 입력가능
    addr varchar(5), 					-- addr은 서울,대구,인천 만 가능하도록 설정
	constraint CK_ADDR check(addr in('서울','대구','인천'))
);
desc tbl_test08;
show create table tbl_test08;
select * from INFORMATION_SCHEMA.CHECK_CONSTRAINTS;

alter table tbl_test08 drop check CK_ADDR;


-- ------------------------------
-- Default 설정
-- ------------------------------
create table tbl_test09
(
	id varchar(20) primary key,
    name varchar(20) default '이름없음',
    age int check(age>=10 and age<=50) default 20,			-- age는 10 - 50세 까지만 입력가능
    addr varchar(5) default '인천', 					-- addr은 서울,대구,인천 만 가능하도록 설정
	constraint CK_ADDR check(addr in('서울','대구','인천'))
);
desc tbl_test09;

alter table tbl_test09 alter column name set default '홍길동';
desc tbl_test09;

alter table tbl_test09 alter column age drop default;
desc tbl_test09;






-- ------------------------------
-- 
-- ------------------------------
-- ------------------------------
-- 
-- ------------------------------
-- ------------------------------
-- 
-- ------------------------------


