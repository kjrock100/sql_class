0. 단원 내용
-- rollup, cube, grouping sets를 활용하여 소계, 총계 생성

1. rollup
-- rollup은 group by의 확장임
-- grouping colnum의 소계 / 총계 생서
-- ( )를 묶어서 소계 범위 지정 가능

select department_id, job_id, count(*) from employees where department_id in (30, 50, 80) group by department_id, job_id;
select department_id, job_id, count(*) from employees where department_id in (30, 50, 80) group by rollup(department_id, job_id);

select department_id, job_id, sum(salary) from employees where department_id <=30 group by rollup(department_id, job_id);
select department_id, job_id, sum(salary) from employees where department_id <=30 group by rollup((department_id, job_id));

2. cube 
-- 다차원 집계를 생성
-- 모든 경우의 소그룹을 만들어 소계 생성
-- 시스템에 많은 부하 발생

select department_id, job_id, sum(salary) from employees where department_id <=30 group by cube(department_id, job_id);

3. grouping sets 
-- 개별 집계를 구할때 사용

-- rollup(a,b,c) : grouping sets((a,b,c), (a,b),(a),()) 같음
-- cube(a,b,c) : grouping sets ((a,b,c,),(a,b),(a,c), (b,c),(a),(b),(c),()) 같음

select department_id, job_id, count(*) from employees where department_id in (30, 50, 80) group by grouping sets((department_id, job_id), (department_id));

4. 분석함수
-- select문에 사용
-- 가장 마지막에 평가
-- 형태:
-- select analytic_function(arguments)
--           over ( [partition by 컬럼] order by 절
--                                     windowing절)
-- from 테이블명


5. ranking faily
-- rank() : 동율 순위 수 만큼 건너 뜀
-- dense_rank() : 순차적으로 순위
-- row_number()
-- ntile()
-- ratio_to_report
-- listagg


5-1. rank, dense_rank
select first_name, department_id, salary, rank() over (order by salary desc) "rank" from employees;
select first_name, department_id, salary, dense_rank() over (order by salary desc) "dense_rank" from employees;


select first_name, department_id, salary, rank() over (partition by department_id order by salary desc) "rank" from employees;
select first_name, department_id, salary, dense_rank() over (partition by department_id order by salary desc) "dense_rank" from employees;


select job_id, sum(salary), rank() over (order by sum(salary) desc) rk from employees group by job_id;
select job_id, sum(salary) from employees group by job_id;

5-2. row_number
-- rownum 과는 관련없음
-- order by절에 의한 정렬된 순서로 유일한 값

select department_id, department_name, rownum, row_number() over (order by department_name) r_n from departments;

5-3. ntile 
-- 정렬된 데이터에서 세부 구간으로 분류
select employee_id, first_name, department_id, salary, ntile(30) over (order by salary desc) "ntile" from employees;
select  department_id, sum(salary), ntile(5) over (order by sum(salary) desc) "ntile" from employees group by department_id;

5-4. ratio_to_report 
-- 비율 계산
select employee_id, first_name, salary, ratio_to_report(salary) over () "r_t_r" from employees;
select department_id, sum(salary), ratio_to_report(sum(salary)) over () "r_t_r" from employees group by department_id;

5-5. listagg
-- 행을 열로 변환
select listagg(last_name,' : ') within group (order by hire_date, last_name) "Emp_list", min(hire_date), "Earliest" from employees where department_id = 30;

select listagg(last_name,' : ') within group (order by hire_date, last_name) "Emp_list" from employees where department_id = 30;
select last_name, hire_date from employees where department_id = 30 order by hire_date, last_name;

select department_id, listagg(last_name,' : ') within group (order by hire_date) from employees group by department_id;

5-6. window aggregate family
-- window 집계 유형
-- 보고용 집계 유형
-- 가로, 세로 데이터 바꾸기

5-6-1. window 집계
select first_name, department_id, salary, (select avg(salary) from employees) tot_avg_sal, (select avg(salary) from employees e2 where e2.department_id = e1.department_id) dept_avg_sal
from employees e1;

select first_name, department_id, salary, avg(salary) over() tot_avg_sal, avg(salary) over (partition by department_id) from employees;


select employee_id, first_name, department_id, salary, sum(salary) over(), trunc(avg(salary) over()), min(salary) over(), max(salary) over() from employees;

5-6-2. lead / lag family
-- 현재 current row기준으로 위 아래 위치의 값 참조
select employee_id, first_name, department_id, salary, 
 lag(salary,1,0) over (order by department_id) "before salary1",
 lag(salary,1,salary) over (order by department_id) "before salary2"
 from employees;

select employee_id, first_name, department_id, salary, 
 lead(salary,1,0) over (order by department_id) "next salary1",
 lead(salary,1,salary) over (order by department_id) "next salary2"
 from employees;

5-6-3. 기타
select first_name, to_char(hire_date, 'yyyy/mm/dd'), salary, sum(salary) over (order by hire_date rows between unbounded preceding and current row) from employees;

-- between A and B
-- A : unbounded preceding
--     n preceding
--     current row

-- B : current row
--     n following
--     unbounded following




