
1. 집합 연산자
-- union:  중복 제거, 합집합
-- union all: 중복 포함, 합집합
-- intersect : 교집합
-- minus : 차집합

2. 집합 연산 규칙
-- select list의 표현식은 개수가 일치
-- select list의 각 열의 데이터 유형 일치
-- 중복은 union all 외에는 자동으로 제거
-- order by는 명령문의 맨 끝에만 올수 있다
-- 첫번째 query의 열 이름이 결과에 나타남
-- 기본적으로 오름차순(union all 제외)

select employee_id, job_id from employees 
union
select employee_id, job_id from job_history;

select department_id, first_name, salary from employees where salary = 2600 
union all
select department_id, first_name, salary from employees where department_id = 30;

select department_id, first_name, salary from employees where salary = 2600 
union
select department_id, first_name, salary from employees where department_id = 30;

select employee_id, job_id from employees 
intersect
select employee_id, job_id from job_history;

select employee_id, job_id from employees 
minus
select employee_id, job_id from job_history;

3. select 문 일치
-- select list의 표현식은 개수가 일치해야함. 더미 열과 데이터 유형 변환 함수를 사용하여 이러한 규칙을 준수한다.

select location_id, department_name "Department", to_char(null) "Warehouse location" from departments 
union
select location_id, to_char(null) "Department", state_province from locations;

select location_id, department_name "Department", to_char(null) "Warehouse location" from departments 
union
select location_id, null, state_province from locations;

select employee_id, first_name, hire_date from employees where department_id in (20, 30, 70)
union all
select department_id, department_name, null from departments;

select employee_id, first_name, hire_date from employees where department_id in (20, 30, 70)
union all
select department_id, department_name, null from departments
order by employee_id;


4. 집한 연산에서 order by 
-- 맨 끝에 한번만 사용 가능
-- 각 개별 query에 order by 사용할수 없음

-- 문제 1
select job_id, department_id from employees where department_id in (10, 50, 20)
union
select job_id, department_id from employees where department_id in (10, 50, 20);

select distinct job_id, department_id from employees where department_id in 10
union all
select distinct job_id, department_id from employees where department_id in 50
union all
select distinct job_id, department_id from employees where department_id in 20;


-- 문제2
select department_id, job_id, count(*) from employees group by department_id, job_id having department_id in (30, 50, 80)
union
select department_id, null, count(*) from employees group by department_id having department_id in (30, 50, 80)
union
select null, null, count(*) from employees where department_id in (30, 50, 80);


select distinct department_id, job_id, count(*) from employees group by department_id, job_id having department_id in (30, 50, 80)
union all
select department_id, null, count(*) from employees group by department_id having department_id in (30, 50, 80)
union all
select null, null, count(*) from employees where department_id in (30, 50, 80)
order by department_id;
-- order by의 열 변수가 null이 2번 이상일때, 오류 발생