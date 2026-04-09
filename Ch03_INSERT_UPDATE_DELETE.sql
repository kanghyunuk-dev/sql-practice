-- use shopdb;
-- select * from buytbl;
-- create table tbl_buy_2(select num,userid,prodname,amount from buytbl);
-- select * from tbl_buy_2;
-- delete from tbl_buy_2;
-- ------------------------------------
-- INSERT 
-- ------------------------------------
-- ------------------------------------
-- 1) 여러 값 한번에 삽입
-- ------------------------------------
-- insert into tbl_buy_2 values
-- (1,'aaa','운동화',1),
-- (2,'bbb','운동화',1),
-- (3,'ccc','운동화',1),
-- (4,'ddd','운동화',1),
-- (5,'eee','운동화',1);

-- select * from tbl_buy_2;
-- delete from tbl_buy_2;

-- ------------------------------------
-- 2) PK 중복시 무시(IGNORE ☆)
-- ------------------------------------
-- insert ignore into tbl_buy_2 values(1,'aaa','운동화',2);
-- insert ignore into tbl_buy_2 values(2,'bbb','냉장고',4);
-- insert ignore into tbl_buy_2 values(1,'ccc','노트북',3);
-- insert ignore into tbl_buy_2 values(4,'ddd','세탁기',1);
-- select * from tbl_buy_2;

-- ------------------------------------
-- 3) AUTO INCREMENT(☆)
-- ------------------------------------
-- insert ignore into tbl_buy_2 values(null,'aaa','운동화',2);
-- insert ignore into tbl_buy_2 values(null,'bbb','냉장고',4);
-- insert ignore into tbl_buy_2 values(66,'ccc','노트북',3);
-- insert ignore into tbl_buy_2 values(null,'ddd','세탁기',1);
-- select * from tbl_buy_2;

-- ------------------------------------
-- AUTO INCREMENT 확인(다음값)
-- ------------------------------------
-- select auto_increment from information_schema.tables where table_schema='shopdb' and table_name='tbl_buy_2';
-- 마지막으로 성공한 auto_increment 확인
-- select last_insert_id();

-- ------------------------------------
-- AUTO INCREMENT 초기화
-- ------------------------------------
-- delete from tbl_buy_2;
-- select * from tbl_buy_2;
-- insert ignore into tbl_buy_2 values(null,'aaa','운동화',2);
-- alter table tbl_buy_2 auto_increment=0;
-- insert ignore into tbl_buy_2 values(null,'aaa','운동화',2);

-- ------------------------------------
-- 4) ON DUPLICATE KEY 옵션
-- ------------------------------------
-- insert ignore into tbl_buy_2 values(1,'aaa','운동화',2) ON DUPLICATE KEY UPDATE amount=amount+1;
-- select * from tbl_buy_2;


-- UPDATE

-- DELETE
