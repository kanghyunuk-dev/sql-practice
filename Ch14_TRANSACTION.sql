-- 중요!! ★★★★★
create table  if not exists  tbl_test(
no	int primary key,
name varchar(20),
age int,
gender char(1)
);

delete from tbl_test;
insert into tbl_test values(1,'aa',66,'W'); -- commit;
insert into tbl_test values(2,'ab',66,'W'); -- commit;
insert into tbl_test values(3,'ac',66,'W'); -- commit;
select * from tbl_test;
commit;

start transaction;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'ab',66,'W');
	insert into tbl_test values(6,'ac',66,'W');
rollback;

start transaction;
	savepoint s1;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'ab',66,'W');
	insert into tbl_test values(6,'ac',66,'W');
    savepoint s2;
	insert into tbl_test values(7,'ac',66,'W');
	insert into tbl_test values(8,'ac',66,'W');
    savepoint s3;
    insert into tbl_test values(9,'ac',66,'W');
    insert into tbl_test values(10,'ac',66,'W');
    rollback to s3;
    rollback to s2;

select * from tbl_test;



-- AUTOCOMMIT 모드 비활성화

drop procedure Tx_Test;
DELIMITER $$
create procedure TX_Test()
begin
	declare continue handler for SQLEXCEPTION
    begin
		show errors;
        rollback;
    end;
    start transaction;
		savepoint sp;
		insert into tbl_test values(4,'aa',66,'W');
		insert into tbl_test values(5,'ab',66,'W');
		insert into tbl_test values(6,'ac',66,'W');    
	commit;
    release savepoint sp;
end $$
DELIMITER ;

call TX_Test();
show procedure status;
select * from tbl_test;
 
 



