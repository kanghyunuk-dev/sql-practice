-- ---------------------
-- 내장함수 (https://velog.io/@wngud4950/MySQL-%EB%82%B4%EC%9E%A5%ED%95%A8%EC%88%98-%EC%A0%95%EB%A6%AC)
-- ---------------------
-- Concat(), Concat_ws()
select concat('hello','-','world',5,6);
select concat_ws("-",'hello','world',5,6); -- 첫번째 - 구분자

-- SubString()

select substring("HELLO WORLD",6);	-- 6 index 부터 마지막 문자까지
select substring("HELLO WORLD",1,6);	-- 1 index부터 6개문자

select substring_index("HELLO MY NAME IS JUNG"," ",3);
select userId,substring_index(mDate,'-',2) as '가입연월' from usertbl;
select mdate from usertbl;

-- length()
select length("Hello World");
select length(lastname) from classicmodels.employees;
select region,length(Region) from world.country;

-- LOWER(), UPPDER()
select Region,Upper(Region),Lower(Region) , length(Region) from world.country;
-- Trim()
select "  HELLO WORLD  ", length("  HELLO WORLD  "),trim("  HELLO WORLD  ") ,length(trim("  HELLO WORLD  "));
select trim("  HELLO WORLD  ");

-- Replace
-- instr
-- lpad,rpad
-- left,right
-- mid

-- bin,oct,hex

select bin(1);
select bin(2);
select bin(3);
select bin(4);
select bin(5);
select bin(6);
select bin(7);
select bin(8);
select bin(9);
select bin(10);
select bin(11);
select bin(12);
select bin(13);
select bin(14);
select bin(15);

-- REVERSE
-- SPACE
-- REPEAT
-- LOCATE
-- FORMAT

-- 날짜관련 함수 생략
select Year(mDate) from usertbl;
select month(mDate) from usertbl;
select day(mDate) from usertbl;
-- 중요
select now() ; -- 현재날짜 시간
select date(now()) ;
select curdate() ;
select time(now());
select curtime() ;

-- 현재 날짜시간에서 연,월,일,시,분,초를 각각 추출해내고
-- 다음과 같은 포맷팅으로 출력하세요
-- YYYY#MM#DD-hh|mm|ss
select replace(curdate(),'-','#') ;
select replace(curtime(),':','|') ;
select concat(replace(curdate(),'-','#')," ",replace(curtime(),':','|'));






