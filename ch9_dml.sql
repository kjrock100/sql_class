1. dml (데이터 조작어)
-- 테이블에 새로운 행 추가
-- 테이블에 기존 행 수정
-- 테이블에 기존 행 제거 

2. 테이블에 새로운 행 추가
-- insert into table [(col1, col2,...)] values (val1, val2,...);

insert into departments (department_id, department_name, manager_id, location_id) values (70, 'Public Relations', 100, 1700);
insert into departments values (280, 'Education', 156, 1700);
insert into departments (department_name, location_id, department_id) values ('Test', 1800,290);
insert into departments values (300, 'IT1', null, null);

-- 변경된 작업 저장
commit; 


3. 다른 테이블에서 행 복사
-- insert 문을 subquery로 작성
-- values 절을 사용하면 안됨
-- insert 절의 열 개수를 subquery의 열 개수와 일치시킴

insert into sales_reps(id, name, salary)
select employee_id, last_name, salary from employees where job_id like '%REP%';

insert into departments
select department_id+5, department_name||'_1', manager_id, location_id from departments where department_id <= 50;


4. 테이블에 기존 값 수정
-- update table
-- set column = value [, column = value,..]
-- [where condition]

-- 잘못 수정
update departments set department_name = 'Shipping_Part1';
-- 되돌리기
rollback;

update departments set department_name = 'Shipping_Part1' where department_id = 50;

-- subquery를 사용하여 열 변경
update employees set (job_id, salary) = (select job_id, salary from employees where employee_id = 205) where employee_id = 103;



alter table employees add (department_name varchar(5));


update employees e 
set department_name = (select department_name from departments d where d.department_id = e.department_id);

5. 테이블에 기존 행 삭제
-- delete [from] table [where condition]

-- table 모드 삭제
delete departments;

-- xx1로 끝나는 부서 삭제
delete departments where department_name like "%1";

delete departments where department_name = 'Finance';

delete employees where department_id in (select department_id from departments where department_name like '%Public%');








