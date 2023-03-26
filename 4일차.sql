-- join
select employee_id, first_name, departments.department_id, department_name from employees, departments;

select employee_id, first_name, departments.department_id, department_name from employees, departments
 where employees.department_id = departments.department_id;

select employee_id, first_name, departments.department_id, department_name from employees, departments
 where employees.department_id = departments.department_id
 and employees.salary >=10000;

select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name from employees e, departments d
 where e.department_id = d.department_id
 and e.salary >=10000;

select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name from employees e join departments d
 on e.department_id = d.department_id
 where e.salary >=10000;

select e.employee_id, e.first_name, department_id, d.department_name from employees e join departments d using(department_id)
 where e.salary >=10000;

select e.employee_id, e.first_name, d.department_id, d.department_name from employees e natural join departments d
 where e.salary >=10000;

select e.employee_id, e.first_name, d.department_id, d.department_name, l.city from employees e, departments d, locations l
 where e.department_id = d.department_id and d.location_id = l.location_id;

select e.employee_id, e.first_name, d.department_id, d.department_name, l.city from employees e
 join departments d on e.department_id = d.department_id
 join locations l on d.location_id = l.location_id;

 select e.employee_id, e.first_name, d.department_id, d.department_name from employees e
 left outer join departments d on e.department_id = d.department_id;

 select e.employee_id, e.first_name, d.department_id, d.department_name from employees e
 right outer join departments d on e.department_id = d.department_id;

 select e.employee_id, e.first_name, d.department_id, d.department_name from employees e
 full outer join departments d on e.department_id = d.department_id;

-- 문제1
select e.last_name, e.job_id, d.department_id, d.department_name, l.city from employees e
 join departments d on e.department_id = d.department_id
 join locations l on d.location_id = l.location_id
 where l.location_id = 1800;

select e.last_name, e.job_id, d.department_id, d.department_name, l.city from employees e
 join departments d on e.department_id = d.department_id
 join locations l on d.location_id = l.location_id and l.location_id = 1800;

-- 문제2
select e.employee_id, e.first_name, e.manager_id, e2.first_name from employees e
 left outer join employees e2 on e.manager_id = e2.employee_id
 order by e.employee_id;

---subquery-----------------------------------------------
QUERY 명령어

SELECT column, 단일행함수, 그룹합수, 500, 'hello', (select ...)
FROM  table명 | (select ....)
WHERE column | 단일행함수 비교연산자 값|(select ....)
GROUP BY 
HAVING  그룹함수 비교연산자  값 | (select ....)
ORDER BY column, 단일행함수, 그룹합수, 500, 'hello', (select ...)


select first_name, department_id, salary, (select avg(salary) from employees) avg_sal from employees;

-- pseudo column (허수의 컬럼) : rowid, rownum (oracle에서만 지원)
select first_name, department_id, salary, rowid, rownum from employees;

-- 전체 테이블 스캔
select * from employees where department_id = 10;
select * from employees where department_id = 60 and rownum <= 3;

select department_id, round(avg(salary)) from employees group by department_id order by round(avg(salary)) desc;

select *
from (select department_id, round(avg(salary)) avg_salary from employees group by department_id order by round(avg(salary)) desc)
where rownum <=3;

-- TABLE이름, COLUMN이름
-- 1.첫번째 글자: 영어, 한글
-- 2.두번째 글자: 숫자(0-9), 특수문자(_,$,#)

-- 문제
select first_name, department_id, salary from employees where salary > 사원전체평균급여;

select first_name, department_id, salary from employees where salary > (select avg(salary) from employees);


select first_name, department_id, salary from employees where salary = (select salary from employees where job_id ='ST_MAN');
--   ==> erro

select first_name, department_id, salary from employees where salary in (select salary from employees where job_id ='ST_MAN');
--   ==> ok

select first_name, department_id, salary from employees where salary =any (select salary from employees where job_id ='ST_MAN');
select first_name, department_id, salary from employees where salary =any (7000,8000,9000);           

select * from departments d where exists (select 1 from employees e where e.department_id = d.department_id);
select * from departments d where department_id in (select department_id from employees e);

select * from departments d where not exists (select 1 from employees e where e.department_id = d.department_id);
select * from departments d where department_id not in (select department_id from employees e);  
-- ==> null 이 있는 경우, not in 연산은 항상 false


-- 문제
-- 서브쿼리 <--> 조인
select e.first_name, e.department_id, e.salary 
from employees e, (select department_id, avg(salary) avg_sal from employees group by department_id) d
where e.department_id = d.department_id and e.salary > d.avg_sal;

select e.first_name, e.department_id, e.salary 
from employees e join (select department_id, avg(salary) avg_sal from employees group by department_id) d
on e.department_id = d.department_id and e.salary > d.avg_sal;

select avg(salary) from employees where department_id = 90;

select e.first_name, e.department_id, e.salary 
from employees e
where e.salary > (select avg(salary) from employees e2 where e2.department_id = e.department_id);

select e.department_id, d2.department_name, d.cnt, d.avg_sal
from employees e join (select department_id, count(*) cnt, avg(salary) avg_sal from employees group by department_id) d
on  e.department_id = d.department_id 
and d.cnt = (select min(cnt) from (select count(*) cnt from employees group by department_id))
join departments d2 on e.department_id = d2.department_id;


select min(salary) from employees;















