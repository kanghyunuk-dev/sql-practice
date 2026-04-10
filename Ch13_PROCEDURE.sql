-- -------------------
-- Stored Procedure
-- -------------------
-- 데이터베이스에서 실행 가능한 저장 프로그램
-- SQL문들의 논리적인 묶음
-- Function(함수)와 유사하나 특정부분에서의 차이점이 존재한다.

-- -------------------
-- Stored Procedure 와 Function 과의 공통점
-- -------------------
-- 01 재사용성
-- 02 모듈화
-- 03 매개변수의 존재
-- 04 흐름제어 처리(if,case,while사용가능)
-- 05 트랜잭션 처리
-- 06 커서사용 
-- 07 반환값 존재 
-- 08 동적 SQL문 실행가능(prepare - execute)

-- -------------------
-- Stored Procedure 와 Function 과의 차이점
-- -------------------
-- 반환값 
	-- 프로시저에서는 반환값이 필수는 아니다
    -- 함수에서는 항상 값을 반환한다

-- 허용되는 문맥
	-- 프로시저는 SELECT,INSERT,UPDTE,DELETE문과 같은 SQL문 내에서 직접호출 가능
	-- 함수는 주로 SELECT 문이나 WHERE절에서 호출되어 사용, SQL문에서 직접호출되는 경우가 적음

-- 트랜잭션
	-- 프로시저 : 트랜잭션 내에서 여러 SQL문을 실행할수 있다
    -- 함수 : 주로 읽기 전용 작업에 사용되며, 트랜잭션에서 변경 사항을 가지지 않도록 설계

-- 예외처리
	-- 프로시저 : 프로시저 내에서 예외처리 가능
    -- 함수 : 예외처리가 가능하지만 주로 SELECT문을 사용하기 때문에(조회) 예외처리를 적용하는
	-- 경우가 적음
    
-- -------------------
-- 예제 01
-- -------------------    

delimiter $$
create procedure pro1()
begin
	-- 변수 선언
    declare var1 int;
    -- 값 삽입
    set var1 = 100;
    -- if문(조건절)
	if var1= 100 
		then
			select 'var1 은 100 입니다';
        else	
			select 'var1 은 100 이 아닙니다';
    end if;        
    
end $$
delimiter;

show procedure status where db='shopdb';

call pro1();

-- -----------
-- 02 파라미터 
-- -----------
delimiter $$
create procedure pro2(in param int)
begin

    -- if문(조건절)
	if param = 100 
		then
			select param ,'은 100 입니다';
        else	
			select param,'은 100 이 아닙니다';
    end if;        
    
end $$
delimiter ;
call pro2(105);
call pro2(100);
call pro2(99);
    
    
 -- -----------
-- 02 테이블 적용
-- -----------
delimiter $$
create procedure pro3(in amt int)
begin
        select * from buytbl where amount>=amt;
end $$
delimiter ;
   
call pro3(4);
call pro3(6); 

delimiter $$
create procedure pro4(in amt int,in isGt int)
begin
	if isGt != 0
		then
			select * from buytbl where amount>=amt;
        else
			select * from buytbl where amount<=amt;
    end if;    
end $$
delimiter ;

call pro4(4,0);
call pro4(4,1);


drop procedure pro5;
delimiter $$
create procedure pro5()
begin
	declare avg_total_price double;
    set avg_total_price = (select avg(amount*price) from buytbl);
    select *,price*amount,if(price*amount>=avg_total_price,'평균이상','평균이하') as '평균이상/이하' from buytbl;
end $$
delimiter ;

call pro5();

set @avr=(select avg(amount*price) from buytbl);
select @avr;
select *,price*amount,if(price*amount>=@avr,'평균이상','평균이하') as '평균이상/이하' from buytbl;


-- 문제
-- usertbl에서 출생년도를 입력받아 해당 출생년도보다 나이가 많은 행만 출력
-- birthyear열을 이용
-- 프로시저명 : older( IN param int)
select * from usertbl;
delimiter $$
create procedure older(IN param int)
begin
	select * from usertbl where birthyear<=param;
end $$
delimiter ;

call older(1990);


-- 문제
-- 근태일 , 가입일로부터 지난일 구하기(usertbl)
-- 가입일로부터 지난날짜 확인(테이블 조회시 열하나 추가해서 보여주세요~)
-- select curdate(); -- 현재 날짜(YYYY-MM-DD)
-- select now();	 -- 현재 날짜시간
-- select curtime();	-- 현재 시간
-- select *,ceil(datediff(curdate(),mDate)/365) from usertbl;
select *,ceil(datediff(curdate(),mDate)/365) as '근속년수' from usertbl;
select *,ceil(datediff(curdate(),mDate)) as '근속일수' from usertbl;

drop procedure tmp;
delimiter $$
create procedure tmp()
begin
	select *,ceil(datediff(curdate(),mDate)) as '가입일로부터 N일' from usertbl;
end $$
delimiter ;

call tmp();

-- 0000년을 기준으로 현재 까지의 일수
select to_days(curdate());

-- 만 나이 계산 ('YYYY-MM-DD')
select *, DATE(CONCAT(birthyear, '-01-01')) from usertbl; 
select *,to_days( DATE(CONCAT(birthyear, '-01-01')) ) from usertbl;

select *,((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) from usertbl;
select *,
ceil((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) as '나이(만)' 
from usertbl;

use shopdb;

--  나이 계산하기
-- ceil : 올림 , round : 반올림 floor : 내림처리
drop procedure if exists  add_age;
delimiter $$
create procedure add_age()
begin 
	select U.userid,name,birthyear,prodname,price*amount,
    floor((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) as '나이'
	from usertbl U
	inner join buytbl B
	on U.userid=B.userid;
end $$
delimiter ;

call  add_age();

use classicmodels;
select * from employees;



-- -------------------
-- 인자 2개  
-- -------------------

delimiter $$
create procedure proc6(in arg1 int , in arg2 int)
begin
	select * from usertbl where height between arg1 and arg2;
end $$;
delimiter ;

call proc6(170,180);



select 
*,
case 
	when amount>=10 then 'VIP'
    when amount>=5 then '우수'
    when amount>=1 then '일반'
    else '구매없음'
end as 'GRADE'
from buytbl;



delimiter $$
create procedure proc7(in arg1 int , in arg2 int,in arg3 int)
begin
	select 
	*,
	case 
		when amount>=arg1 then 'VIP'
		when amount>=arg2 then '우수'
		when amount>=arg3 then '일반'
		else '구매없음'
	end as 'GRADE'
	from buytbl;

end $$;
delimiter ;

call proc7(5,3,1);



-- -------------------
-- 프로시저 + 반복문
-- -------------------
-- i=1; //반복탈출용 변수 선언
-- while(i<=10) //반복 조건식
-- {
--   select "helloworld";
--   i=i+1; //반복탈출을 위한 연산작업
-- }

drop procedure proc_while_01;
delimiter $$
create procedure proc_while_01()
begin
	declare i int;
    set i = 1;
	while i<=10 do
		select "HELLO WORLD";
        set i=i+1;
    end while;    
    
end $$;
delimiter ;

call proc_while_01();

drop procedure proc_while_02;
delimiter $$
create procedure proc_while_02(in n int)
begin
	declare i int;
    set i = 1;
	while i<=n do
		select "HELLO WORLD";
        set i=i+1;
    end while;    
    
end $$;
delimiter ;

call proc_while_02(3);

-- 1-10합
drop procedure proc_while_03;
delimiter $$
create procedure proc_while_03()
begin
	declare i int;
    declare sum int;
    set i=1;
    set sum=i;
    
    while i<=10 do
		set sum = sum+i;
		set i=i+1;
    end while;
    select sum;
end $$;
delimiter ;

call proc_while_03();


-- 1-N합

-- N-M합(N<M)

-- 구구단 2단 출력
-- 구구단 N단 출력(N<=9)












