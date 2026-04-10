create database testdb;
use testdb;
-- [참고] https://hongong.hanbit.co.kr/sql-%EA%B8%B0%EB%B3%B8-%EB%AC%B8%EB%B2%95-joininner-outer-cross-self-join/
-- --------------------
-- JOIN
-- --------------------
-- 두개이상의 테이블을 서로 묶어서 하나의 조회결과를 만드는데 사용
-- --------------------
-- JOIN 종류
-- --------------------
-- INNER JOIN: ON 조건에 맞는 데이터만 조인
-- OUTER JOIN:
--   LEFT OUTER JOIN: 왼쪽 테이블 전체 + 오른쪽 조건 일치 행
--   RIGHT OUTER JOIN: 오른쪽 테이블 전체 + 왼쪽 조건 일치 행
--   FULL OUTER JOIN: 양쪽 테이블 전체 (MySQL은 직접 지원하지 않음 → UNION으로 구현)
-- CROSS JOIN: 모든 행끼리 조인 (조건 없음)
-- SELF JOIN: 자기 자신 테이블을 조인

-- --------------------
-- INNER JOIN 실습
-- --------------------
use shopdb;
select * from usertbl;
desc usertbl;
select * from buytbl;
desc buytbl;

-- INNER JOIN 구매한 고객에대한 모든 정보(전체컬럼)
select * 
from usertbl 
inner join buytbl 
on usertbl.userid = buytbl.userid;

-- INNER JOIN 원하는 컬럼만 출력
select usertbl.userid,name,addr,mobile1,mobile2,prodname,price,amount
from usertbl 
inner join buytbl 
on usertbl.userid = buytbl.userid;

-- INNER JOIN 별칭지정
select U.userid,name,addr,mobile1,mobile2,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid;

-- INNER JOIN + WHERE 
select U.userid,name,addr,mobile1,mobile2,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount >= 5;

-- 문제
-- 1 바비킴의 userID,birthYEar,prodName,GroupName 을 출력하세요

select U.userid,birthyear,prodname,groupname 
from usertbl U
inner join buytbl B
on U.userid=B.userid
where name='바비킴';

-- 2 amount*price 의 값이 100 이상인 행의 name,addr,prodname,mobile1-  mobile2를(Concat()함수사용) 
-- 출력하세요

select name,addr,prodname,concat(mobile1,'-',mobile2) as '연락처'
from usertbl U
inner join buytbl B
on U.userid=B.userid
where amount*price >=100;

-- 3 groupname이 전자인 행의 userid,name,birthyear prodname을  출력하세요
select U.userid,name,birthyear,prodname
from usertbl U
inner join buytbl B
on U.userid=B.userid
where groupname='전자';

-- --------------------
-- OUTER JOIN 실습
-- --------------------
-- LEFT OUTER JOIN(on 조건절을 만족하지 않는 left테이블의 행도 출력)
select * 
from usertbl U 	-- LEFT
left outer join buytbl B -- RIGHT
on U.userid = B.userid;

-- RIGHT OUTER JOIN(on 조건절을 만족하지 않는 right테이블의 행도 출력)
select * 
from  buytbl B	-- LEFT
right outer join usertbl U -- RIGHT
on U.userid = B.userid;

-- FULL OUTER JOIN (on 조건절을 만족하지 않는 left,right 테이블의 행도 출력)
-- mysql에서는 full outer join 을 지원하지 않는다
-- 대신 union 을 사용해서 left, right outer join을 연결

select * from usertbl U left outer join buytbl B on U.userid = B.userid
union
select * from  buytbl B	right outer join usertbl U on U.userid = B.userid;


-- 
use empolyees;
desc employees;
desc salaries;
desc dept_emp;
desc departments;

select 
-- E.emp_no,concat(first_name,' ',last_name) as 'name',salary,hire_date,S.from_date,S.to_date 
E.emp_no,concat(first_name,' ',last_name) as 'name',salary,S.from_date,S.to_date,D.dept_no,dept_name
from employees E	-- LEFT
inner join salaries S -- RIGHT
on E.emp_no = S.emp_no
inner join dept_emp DE
on E.emp_no = DE.emp_no
inner join departments D
on DE.dept_no = D.dept_no;


-- WORLD DB에서 진행 countryCode를 만족하는 
-- country'name ,
-- city's name, 
-- region ,
-- population,
-- Capital,
-- Language 
-- 를 출력하세요

use world;
desc country;
desc city;
desc countrylanguage;
select * from country;

select C.name,CT.name ,C.region,C.population,C.capital,CL.language
from country C
inner join city CT
on C.Code = CT.CountryCode
inner join countrylanguage CL
on C.Code = CL.CountryCode
order by C.name asc;