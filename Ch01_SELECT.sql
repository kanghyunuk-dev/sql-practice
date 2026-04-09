use shopdb;
show tables;
select * from usertbl;
select * from buytbl;
desc usertbl;
desc buytbl;

-- 01 Select
select * from usertbl;
select userid,birthyear from usertbl;
select userid as '아이디' , birthyear as '생년월일' from usertbl;
select 
userid as '아이디' , birthyear as '생년월일',concat(mobile1,'-',mobile2) as '연락처'
from usertbl;

-- 02 Select where(조건절 - 비교연산자)
select * from usertbl where name='김경호'; -- 동등 비교 연산자(=) 
select * from usertbl where userId='LSG'; -- 동등 비교 연산자(=) 
select * from usertbl where birthyear >=1970; 	-- 대소 비교 연산자
select * from usertbl where height <=170;		-- 대소 비교 연산자

-- 03 Select where(조건절 - 논리연산자)
-- and연산자 (참 and 참) 을 만족하는 경우
select * from usertbl where birthyear >= 1970 and height>=180; 
-- or연산자([참 or 참], [거짓 or 참], [참 or 거짓]) 을 만족하는 경우 
select * from usertbl where birthyear >= 1970 or height>=180; 
-- between and
select * from usertbl where height>=170 and height<=180;
select * from usertbl where height between 170 and 180;

-- in(포함문자열(완성된문자열)) , like(포함문자열(미완성된문자열 필터링))
select * from usertbl where addr in ('서울','경남');
select * from usertbl where addr='경남' or addr='서울';

select * from usertbl where name like '김%';	-- % 길이제한 없는 모든 문자 
select * from usertbl where name like '%수';	-- % 길이제한 없는 모든 문자
select * from usertbl where name like '김__'; -- _ 개수만큼의 길이제한 있는 모든 문자
select * from usertbl where name like '%경%';

-- 1 구매양(amount)가 5개 이상인 행을 출력
select * from buytbl where amount >= 5;
-- 2 가격이(price) 50 이상 500 이하인 행의 UserID와 prodName 만 출력
select userId,prodName from buytbl where price >=50 and price <=500;
select userId,prodName from buytbl where price between 50 and 500;

-- 3 구매양(amount)이 10 이상 이거나 가격이 100 이상인 행 출력
select * from buytbl where amount >= 10 or price >= 100;
-- 4 UserID 가 K로 시작하는 행 출력
select * from buytbl where userid like 'K%';

-- 5 ‘서적’ 이거나 ‘전자’ 인 행 출력
select * from buytbl where groupName in ('서적', '전자');
select * from buytbl where groupName='서적' or groupname='전자';

-- 6 상품(prodName)이 책이거나 userID가 W로 끝나는 행출력
select * from buytbl where prodName='책' or userid like '%W';

-- 7 groupname이 비어있지 않는 행만 출력 (!= , <>)
select * from buytbl where groupName!='';
select * from buytbl where groupName<>'';
select * from buytbl where groupName is not null;

-- 04 Select 조건절 - 서브쿼리

-- 김경호의 키보다 큰 행을 조회
select * from usertbl where height>(select height from usertbl where name='김경호');

-- 성시경보다 나이가 많은(birthyear) 모든 행 조회
select * from usertbl where birthyear<(select birthyear from usertbl where name='성시경');



-- 지역이 '경남'인 height보다 큰 모든 행 조회
-- all(모든 조건을 만족하는... and)
select * from usertbl where height >=all(select height from usertbl where addr in ('경남') );
-- any(어느조건이든 하나이상 만족... or)
select * from usertbl where height >=any(select height from usertbl where addr in ('경남') );

-- 문제 buytbl
-- 1 amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
select * from buytbl where 
price>=(select price  from buytbl where amount=10);

-- 2 userID 가 K로 시작하는 행의 amount 보다 큰 행을 출력하세요(서브쿼리 + ANY)
select * from buytbl where
amount>=ANY(select amount from buytbl where userid like 'K%');

-- 3 amount 가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + ALL)
select * from buytbl where
price>=all(select price from buytbl where amount = 5);

-- 05 Select order by
select * from usertbl order by mDate asc;
select * from usertbl order by mDate desc;
select * from usertbl where birthyear >= 1970 order by mDate desc;
select * from usertbl order by height desc ,mdate asc;

-- 06 distinct
select distinct addr from usertbl;

-- 07 limit
select * from usertbl;
select * from usertbl limit 3;
select * from usertbl limit 2,3;

-- 08 테이블 복사
-- 08-01 구조 + 값 복사(PK,FK 복사 x)

create table tbl_buy_copy(select * from buytbl);
select * from tbl_buy_copy;
desc tbl_buy_copy;
desc buytbl;

create table tbl_buy_copy2(select userid,prodname,amount from buytbl);
select * from tbl_buy_copy2;

-- 08-02 구조만 복사(값x, PK o, FK x , Index o)
create table tbl_buy_copy3 like buytbl;
select * from tbl_buy_copy3;
desc tbl_buy_copy3;

-- 08-03 데이터만 복사
insert into tbl_buy_copy3 select * from buytbl where amount>=3;


-- 1 userId 순으로 오름차순 정렬
select * from buytbl order by userId asc;
-- 2 price 순으로 내림차순 정렬
select * from buytbl order by price desc;
-- 3 amount 순으로 오름차순 prodName으로 내림차순정렬
select * from buytbl order by amount asc, prodName desc;
-- 4 prodName을 오름차순으로 정렬시 중복 제거
select distinct prodName from buytbl order by prodName asc;
-- 5 userID열의 검색시 중복된 아이디제거하고 select
select distinct userId from buytbl;
-- 6 구매양(amount)가 3이상인 행을 prodName 내림차순으로 정렬
select * from buytbl where amount>=3 order by prodName desc;

-- 7 usertbl의 addr 가 서울,경기인 값들을 CUsertbl에 복사
create table CUsertbl(select * from usertbl where addr in ('서울','경기'));
select * from CUsertbl;
desc CUsertbl;







