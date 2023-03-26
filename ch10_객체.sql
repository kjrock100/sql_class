1. 데이터베이스 객체
-- table : 기본 저장 단위, 행으로 구성
-- view : table 에 있는 데이터의 부분 집합
-- sequence :  순차적으로 증가하는 숫자 값을 생성
-- index : table 의 행 검색을 빠르게 함
-- synonym : 객체에 다른 이름을 부여

2. table 이름 지정 규칙
-- 문자로 시작
-- 길이는 1 ~ 30 사이
-- a ~ z, A ~ Z, 0 ~ 9, _, $, # 만 포함
-- 동일 user 소유한 다른 객체와 중복되면 안됨
-- 예약어 안됨


1. table 생성
-- create table table명 (column datatype(size), [...]);

-- 데이터 유형
--   varchar2(size) : 가변 길이 문자 데이터
--   char(size) : 고정 길이 문자 데이터
--   number(p,s) : 가변 길이 숫자 데이터
--   date : 날짜 및 시간 값
--   long : 가변 길이 문자 데이터 (max 2GB)
--   raw 및 long rwa : raw binary data 
--   clob : 문자 데이터, 최대 크기는 (4GB - 1) * DB_BLOCK_SIZE 
--   blob : 바이터리 데이터, 최대 크기는 (4GB - 1) * DB_BLOCK_SIZE 
--   bfile : 외부 파일에 저장된 바이너리 데이터 (max 4GB)
--   rowid : 테이블에 있는 행의 고유한 주소를 나타내는 base-64 숫자 체계

create table dept (deptno number(2), dname varchar2(14), loc varchar2(13), create_date date default sysdate);

2. 제약 조건
-- 테이블 레벨에서 규칙을 강제 적용
-- 데이터베이스의 일관성 및 무결성을 보장
-- table 또는 열 레벨에 제약 조건 정의
-- tabble 생성되는 시점이나 table 생성 후 지정 가능

3. 제약 조건 유형
-- primary key : null 허용 안함. 각 행을 유일하게 구분
-- unique : null 허용, 각 행을 유일하게 구분
-- not null : null 허용 안함
-- foreign key : 참조하는 table에 값이 존재하는지 검사
-- check : 특정 조건을 만족하는 값만 존재하는지 검사

4. 제약 조건 정의
-- 구문
--   create table table명 (column datatype(size)  [column_constraint], ..., [table_constraint])
-- 열 레벨 제약 조건 정의 구문
--   column [constraint constraint_name]
-- 테이블 레벨 제약 조건 정의 구문
--   column, ..., [constraint constraint_name] constraint_type 

-- not null 제약 조건은 열 레벨에서 정의
-- 두개 이상의 열에 적용되는 제약 조건은 테이블 레벨에서 정의

-- primary key 제약 조건을 열 레벨 정의
create table emp ( employee_id number(6)  constraint emp_id_pk primary key, ...);

-- primary key 제약 조건을 테이블 레벨 정의
create table emp
( employee_id number(6),
  first_name varchar2(20),
  last_name varchar2(20),
  email varchar2(20),
  job_id varchar2(10) not null,
  salary number(2),
  constraint emp_id_pk primary key(employee_id)
);


-- check 제약 조건을 열 레벨에 정의
create table emp ( salary number(2) constraint emp_salary_ch check(salary > 0), ...);


5. table 변경
-- alter table 문을 이용
--  새 열 추가
--  기존 열 정의 수정
--  새 열에 기본값 정의
--  열 삭제
--  열 이름 바꾸기
--  읽기 전용 상태로 변경

-- 열 추가
alter table emp add (email2  varchar2(30));

-- 기존 열 수정
-- 데이터 유형, 자릿수, default값 변경 가능
alter table emp modify (last_name varchar2(3));

-- 열 삭제 (1개 삭제)
alter table emp drop (job_id);

-- 열 삭제 (2개이상 삭제)
alter table emp set unused column job_id;
alter table emp set unused column email;
alter table emp drop unused columns;

-- 읽기 전용 table로 변경
alter table emp read only;


6. table 삭제
-- purge 키워드: 완전히 제거

-- 형식
--   drop table emp_new [purge];

7. view 
-- 테이블의 view를 생성하여 데이터의 논리적 하위 집합 또는 조합을 나타낸다.
-- view는 테이블 혹은 다른 view를 기반으로하는 논리적 테이블이다.
-- view는 자체적으로 데이터를 갖고 있지 않지만, 테이블의 데이터를 보거나 변경하는 vindow와 같다.
-- 기본 테이블 : view의 기반 테이블

-- view 생성
--   create [or replace] [force | noforce] view view as subquery 
--   [with check option [constraint constraint]]
--   [with read only [constraint constraint]]

-- or replace : view가 이미 있는 경우, 새로 생성함
-- force : 기본 테이블이 없어도 생성
-- noforce : 기본 테이블이 있는 경우에만 view 생성 (기본값)
-- with check option : view에서access/갱신할수 있도록 지정
-- with read only : DML 작업 금지

create view sales_v50
as
select employee_id, last_name, salary*12 ann_salary from employees where department_id = 50;


8. sequence
-- 사용자가 생성한 데이터베이스 객체
-- 여러 사용자가 공유할수 있다.
-- sequence 번호는 테이브과 별도로 저장되고 생성된다.

-- 형식
--   create sequence sequence
--     [increment by n]
--     [start with n]
--     [{maxvalue n | nomaxvalue}]
--     [{minvalue n | nominvalue}]
--     [{cache n | nocache}]
--     [{cycle | nocycle}]

-- increment by n : 시퀀스 번호 사이의간격
-- start with n : 생성할 첫번째 시퀀스 번호 
-- maxvalue n : 최대값 지정
-- nomaxvalue : 최대값 10^27
-- minvalue n : 최소값 지정
-- nominvalue : 최소값 -10^27

-- sequence 생성
create sequence dept_deptno_seq
                increment by 10
                start with 100
                maxvalue 9999
                nocache
                nocycle;

-- sequence 사용
insert into dept (deptno, dname, loc) values (dept_deptno_seq.nextval, 'Support', 'NY');

-- sequence 현재 값 확인
select dept_deptno_seq.currval from dual;


9. synonym
-- 다른 유저가 소유한 테이블을 쉽게 참조 
-- 긴 객체 이름을 짧게 만듬

-- synonym 생성
create public synonym emp for userA.employees;

-- synonym 사용 (user b)
select * from emp


10. index 
-- table 행 검색 속도를 높이기 위해 사용

-- 하나 이상의 열에 index 생성
create [unique][bitmap] index index_name on table (column [, columnn]...)

-- employees table의 first_name 열에 인덱스 생성
create index emp_first_name_idx on employees(first_name)




