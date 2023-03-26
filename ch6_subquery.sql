-- 문제

select d.department_id, d.department_name, count(*), round(avg(e.salary))
from   employees e   join  departments d 
on     e.department_id = d.department_id
group by d.department_id, d.department_name
having count(*) = (select min(count(*))
                   from   employees
                   group by department_id);

1. subquery 정의
-- 하나의 select 문 안에 포함된 또 다른 select 문
-- subquery는 main query 전에 실행
-- subquery 결과는 main query 에서 사용

-- 형식
--   select column1, column2, ...
--   from table
--   where expr operator ( select column,... from table [where ..] [group by ..] [having ..])

2. subquery 사용 규칙
-- subquery 는 괄호로 묶는다.
-- 가독성을 위해 비교 조건의 오른쪽에 subquery 배치
-- single-row subquery 는 단일행 연사자를 사용
-- multiple-row subquery 는 다중행 연사자를 사용
-- single-row subquery : 하나의 행만반환
-- multiple-row subquery : 둘 이상의 행 반환

3. single-row subquery
-- 한 행만 반환
-- 단일 행 비교 연산자를 사용
-- 단일 행 비교 연산자: =, >, >=, <, <=, <>

select last_name, job_id from employees where job_id = (select job_id from employees where employee_id = 141);

select last_name, job_id, salary from employees where job_id = (select job_id from employees where last_name = 'Fox')
and salary > (select salary from employees where last_name = 'Fox');

-- subquery에 group함수 사용
select last_name, job_id, salary from employees where salary = (select min(salary) from employees);

-- having 절에 subquery 사용
select department_id, min(salary) from employees group by department_id having min(salary) > (select min(salary) from employees);


4. multiple-row subquery
-- 두개 이상의 행을 반환
-- 다중 행 비교 연산자를 사용
-- 다중 행 비교 연산자 : in, any, all, exists

-- in 연산자 사용
select last_name, salary, department_id from employees where salary in (2500, 4200, 4400);

-- any 연산자 사용
select employee_id, last_name, job_id, salary from employees where salary < any (select salary from employees where job_id = 'IT_PROG') and job_id <> 'IT_PROG';

-- all 연산자 사용
select employee_id, last_name, job_id, salary from employees where salary < all (select salary from employees where job_id = 'IT_PROG') and job_id <> 'IT_PROG';

-- exists 연산자 사용
select employee_id, salary, last_name from employees m where exists (select employee_id from employees w where w.manager_id = m.employee_id);

5. subquery 의 null 값
-- subquery에서 null 반환시 모든 비교가 null 처리됨
select e.last_name from employees e where e.employee_id not in (select m.manager_id from employees m);

select e.employee_id, e.last_name from employees e where e.employee_id not in (select m.manager_id from employees m where m.manager_id is not null);

-- 문제 1
select first_name, hire_date, salary from employees e where manager_id = 121;
select first_name, hire_date, salary from employees e where manager_id = (select employee_id from employees m where m.first_name like 'Adam');

-- 문제 2
select d.department_id, d.department_name, q.cnt, q.avg_sal 
from departments d join (select department_id, count(*) cnt, avg(salary) avg_sal from employees group by department_id) q 
on d.department_id = q.department_id where q.cnt <= all (select count(*) from employees group by department_id);

