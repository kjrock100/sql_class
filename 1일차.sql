# 터미널
# su - oracle
# sqlplus hr/hr

# terminal size 조정
set linesize 200;
set pagesize 500;

-- 날짜 표시 변경
alter session set nls_date_format = 'yyyy/mm/dd  hh24:mi:ss';
alter session set nls_date_format = 'rr/mm/dd';
alter session set nls_date_format = 'dd-mon-rr';

select hire_date, count(decode(to_char(hire_date,'yyyy'),'2002',1)) from employees;
select hire_date, to_char(hire_date,'yyyy') from employees;
select count(decode(to_char(hire_date,'yyyy'), '2001',1)) from employees;

-- local PC
sqlplus system/oracle
alter user hr identified by hr account unlock;
@%ORACLE_HOME%\rdbms\admin\utlsampl.sql

sqlplus hr/hr










