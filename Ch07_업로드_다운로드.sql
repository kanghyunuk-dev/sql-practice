use testdb;
create table tbl_file(
	title varchar(50),
    filedata longblob
);

desc tbl_file;
select * from tbl_file;


delete from tbl_file;
select * from tbl_file;

insert into tbl_file
values('practice.zip',load_file('c:/sql/Microsoft Photos Installer.exe'));

insert into tbl_file
values('practice',load_file('c:\\sql\\a.pdf'));
insert into tbl_file
values('practice3',load_file('c:\\sql\\ab.png'));
insert into tbl_file
values('practice4',load_file('c:\\sql\\VSCodeUserSetup-x64-1.85.1.exe'));


use testdb;
select * from tbl_file;
-- 다운로드
select filedata from tbl_file where title='practice.zip'
into dumpfile 'c:/sql/down4.zip';
