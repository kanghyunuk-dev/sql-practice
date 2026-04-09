-- ------------------
-- 01 변수
-- ------------------
-- 변하는 수 
-- 수(Data,자료)는 기본 선저장 , 후처리를 원칙으로 한다
-- 저장된 수가 특정상황에 있어 바뀔가능성이 있는경우 이 수를 변수라고 한다
use shopdb;
set @var1 = 5;
set @var2 = 4.56;
set @var3 = "가수이름=>";

select @var1;
select @var2;
select @var3;
select @var1+@var2;

select @var3 as 'TITLE',name,addr from usertbl; 

-- LIMIT 에서 변수 사용
set @rowcnt = 5;
prepare sqlQuery01
from 'select * from usertbl order by height limit ?';
--
--
--
execute sqlQuery01 using @rowcnt;
-- ------------------
-- 형변환
-- ------------------
-- 연산작업시(ex 대입연산,비교연산...) 자료형(Data Type)이 불일치시 자료형을 일치시키는 작업
-- 자동형변환(암시적형변환)	: 시스템에 의한 형변환(데이터 손실을 최소화 방향)
-- 강제형변환(명시적형변환)	: 프로그래머에 의한 형변환(프로그램 제작 목적에 따른->데이터 손실 우려가 비교적 큼)
select mdate from usertbl;
select cast('2024$01$01' as date );
select cast('2024@01@01' as date );

select 
num, 
concat(cast(price as char(10)),' X ',cast(amount as char(10)),"=") as '가격x수량',
price*amount as '결과값'

from buytbl;
select 100 + 200;
select '100' + 200;
select '100' + '200';
select '100a' + '200'+'300';
-- 숫자 비교연산의 결과(참 : 1, 거짓 : 0 )
select 1 < 2;
select 2 > '1a1bcd';
select 0 = 'mega';


