1. 그룹 함수
--  행 집합 연산을 수행하여 그룹별로 하나의 결과를 산출

2. 그룹 합수 유형
-- avg : null 제외, 평균
-- count : null 제외, 행의 수
-- max : 
-- min
-- sum : null 제외, 합계
-- stddev
-- variance
-- 형태 :  select group_function(col), ... from table  [where condition]
-- 모든 그룹함수는 null값 무시
-- distinct : 중복 제거
-- all : 중복 포함, 기본값


select avg(salary), max(salary), min(salary), sum(salary) from employees;
--     6461.83178       24000        2100      691416

3. count 함수
-- count(*) : 모든 행, 중복, null 포함
-- count(expr) : expr에 의해 식별되는 값, null 제거
-- count(distinct expr) : expr에 식별되는 값, null 제거, 중복 제거

select count(*) from employees;
-- 107

select count(commission_pct) from employees;
-- 35

select count(distinct commission_pct) from employees;
-- 7

4. 그룹 함수 및 null 값
-- 그룹 함수는 null 값을 무시

select avg(commission_pct), avg(nvl(commission_pct,0)) from employees;

5. 소그룹 생성: group by 
-- 테이블을 더 작은 그룹으로 나눔
-- 그룹 함수에 속하지 않는 select 절의 열은 group by 절에 반드시 있어야 함
-- where 절을 사용하여 행을 그룹으로 나누기 전에 행을 제외할수 있다
-- group by 절에 열 alias를 사용할수 없다
-- 형식
--   select column, group_function(column) 
--   from table 
--   [where condition]
--   [group by group_by_expression]
--   [order by column]

select department_id, avg(salary) from employees group by department_id;

6. 여러 열을 group by 절에 사용
-- group by 열은 행을 그룹화하지만 결과 집합의 순서를 보장하지 않는다.
-- 그룹화 순서를 지정하려면 order by 절을 사용한다.

select department_id, job_id, sum(salary) from employees where department_id > 40 group by department_id, job_id order by department_id;

7. having 절을 사용하여 그룹 결과 제한 
-- 행이 그룹화됨
-- 그룹 함수가 적용됨
-- having 절과 일치하는 그룹이 표시됨
-- where 절은 행을 제한하는 반면, having 절은 그룹을 제한한다.

-- 형식
--  select column, group_function(column)
--  from table
--  [where condition]
--  [group by group_by_expression]
--  [having group_condition]
--  [order by column]

select department_id, max(salary) from employees group by department_id having max(salary) > 10000;

select job_id, sum(salary) payroll from employees where job_id not like '%REP%' group by job_id having sum(salary) > 13000 order by sum(salary);

-- 문제
select manager_id, min(salary) from employees where manager_id is not null group by manager_id having min(salary) >6000;

select to_char(hire_date,'yyyy'), count(*) from employees group by to_char(hire_date,'yyyy');