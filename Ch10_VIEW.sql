-- ---------------------------
-- View (https://coding-factory.tistory.com/224)
-- ---------------------------
-- 뷰는 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기 위한
-- 가상 테이블

use shopdb;
select * from usertbl;
select * from buytbl;

create or replace view view_01
as
select userid,name,addr,concat(mobile1,'-',mobile2) as 'phone' from usertbl;

select * from view_01;
-- 확인
show create view view_01;
select * from information_schema.views where table_schema='shopdb';
desc view_01;


create or replace view view_02
as
select userid,name,addr,concat(mobile1,'-',mobile2) as 'phone' 
from usertbl 
where addr in ('서울','경기');

select * from view_02;

create or replace view view_03
as
select U.userid,name,addr, concat(mobile1,'-',mobile2) as'phone',prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid;

select * from view_03;

use shopdb;

create or replace view view_04
as
select C.name as 'countryname',CT.name ,C.region,C.population,C.capital,CL.language
from world.country C
inner join world.city CT
on C.Code = CT.CountryCode
inner join world.countrylanguage CL
on C.Code = CL.CountryCode
order by C.name asc;


select * from view_04;


--


drop table tbl_a;
drop table tbl_b;
drop view view_a_b;
create table tbl_a(
	col1 int  primary key,
    col2 int 
);
create table tbl_b(
	col3 int  primary key,
    col4 int,
    col5 int,
    constraint FK_tbl_b_tbl_a foreign key(col4) references tbl_a(col1)
    on update cascade
    on delete cascade
);

create or replace view view_a_b
as
select *  
from tbl_a
inner join tbl_b
on tbl_a.col1 = tbl_b.col4;


desc tbl_a;
desc tbl_b;
select * from tbl_a;
select * from tbl_b;
select * from view_a_b;

insert into tbl_a values(1,10);
insert into tbl_b values(2,1,20);
-- JOIN 된 view table에 insert 불가(단일 Table View는 제약조건을 만족하면 가능)
insert into view_a_b(col1,col3) values(3,4);	
insert into view_a_b(col1,col2) values(3,20);	
insert into view_a_b(col3,col4,col5) values(4,3,30);

insert into view_a_b(col1) values(4);	
insert into view_a_b(col3,col4) values(5,4);