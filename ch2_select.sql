1. 기본 SELECT 문
select { * | [distinct] column | expression [alias], ... } from table;

2. SELECT 문의 기능
-- 1) PROJECTION : 반환되는 테이블의 열을 선택
-- 2) SELECTION  : 반환되는 테이블의 행을 선택
-- 3) JOIN : 두 테이블을 링크

-- 모든 열 선택
select * from employees;

-- 특정 열 선택
select employee_id, last_name, first_name from employees;

3. SQL 문 작성
-- sql 문은 대소문자를 구분하지 않음.
-- sql 문은 한줄 혹은 여러 줄에 입력가능

4. 산술 연산
-- + - / *
-- from 절을 제외한 sql 문의 모든 절에 사용 가능
-- date나 timestamp 데이터 유형은 + - 만 사용 가능

-- ex)
select last_name, salary, salary + 300 from employees;
select hire_date, hire_date +10, hire_date - 10 from employees;

5. NULL 정의
-- 사용할수 없거나, 할당되지 않았거나, 알수 없거나, 적용할수 없는 값
-- null값을 포함하는 산술식은 null로 계산

6. 열 alias 
-- 머리글은 기본적으로 대소문자
-- 공백이나 특수 문자를 포함하거나 대소몬자를 구분할때 ""로 묶는다
-- as 키워드 혹은 공백을 사용하여 표현

select last_name as name, salary*12 "Annual Salary" from employees;

7. 리터럴
-- select 문에 포함된 문자, 숫자, 날짜 데이터임
-- 날짜, 문자 리터럴 값은 작은 따옴표로 묶는다

select first_name, 'hello', 500 from employees;

8. 연결 연산자 (||)
-- 연산자 좌우에 있는 값을 결합하여 단일 컬럼으로 출력

select last_name || job_id as "Employees" from employees;
select last_name || ': 1 Month salary = ' || salary Monthly from employees;

9. 중복 행 제거 (distinct)
기본적으로 QUERY 결과에는 중복 행을 포함 
distinct 키워드를 사용하여 중복 행 제거
select 키워드 바로 뒤에서 distinct 키워드를 포함 

select distinct department_id, job_id from employees;

10. 선택되는 행 제한 (where)
-- where 절을 사용하여 반환되는 행을 제한
-- from 절 다음에 where 절 사용
-- where 절에서 열 alias를 사용할수 없다

select * | { [distinct] column | expression [alias], ... } from table where logical expression(s);

select employee_id, last_name, job_id, department_id from employees where department_id = 90;

11. 문자열 및 날짜
-- 작은 따옴표로 묶음
-- 문자값은 대소문자 구분
-- 날짜값은 형식을 구분

select last_name, job_id, department_id from employees where last_name = 'Whalen';
select last_name from employees where hire_date = '03/10/17';

12. 비교 연산자
-- =, >, >=, <, <= : 비교
-- <>, !=, ^= : 같지 않음 확인
-- between a and b : 두 값 사이 확인
-- in :  값 리스트 중 일치 확인
-- like : 일치하는 문자 패턴 검색
-- is null : null 값인지 여부

select last_name, salary from employees where salary between 2500 and 3500;
-- 상한 및 하한을 포함

select employee_id, last_name, salary, department_id from employees where department_id in (20, 70, 110);
-- 리스트에 문자나 날짜가 있을 경우 작은 따옴표(' ')로 묶는다

13. Like 연산자
-- % : 0개 이상의 문자값
-- _ : 한개 문자 

select first_name from employees where first_name like 'S%';

14. null 조건
-- = null : null 값은 어떤 값과도 동일한지 여부를 판단할수 없음
-- is null : null 여부 확인 
-- is not null : null 아닌지 확인

select last_name, commission_pct from employees where commission_pct is null;

15. 논리 연산자
-- and, or, not
-- and 연산자가 or 연산자보다 우선순위가 높다.
-- 괄호를 사용하여 실행순서 변경

select employee_id, last_name, job_id, salary from employees where salary >=10000 and job_id like '%MAN%';
select employee_id, last_name, job_id, salary from employees where salary >=10000 or job_id like '%MAN%';
select last_name, first_name, job_id from employees where job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

16. 데이터의 정렬
-- order by : 검색된 행을 정렬
-- asc / desc : 오름 / 내림 정렬, 오름(default)
-- order by 문은 항상 select 문장의 맨 마지막에 위치
-- null 값은 오름차순에서는 마지막에 내림차순에서는 처음에 표시
-- nulls first
-- nulls last 

select last_name, job_id, department_id, hire_date from employees order by hire_date;
select last_name, job_id, department_id, hire_date from employees order by hire_date desc;


17. alias와 열 위치를 사용하여 정렬
-- alisa를 이용하여 정렬
select employee_id, last_name, salary*12 total from employees order by total;

-- 열 순서를 이용하여 정렬
select last_name, job_id, department_id, hire_date from employees order by 3;

18. 여러 열 정렬
select last_name, job_id, department_id, salary from employees order by department_id desc, salary desc;

