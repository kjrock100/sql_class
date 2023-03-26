-- EQUI JOIN : 두 테이블의 공통된 데이터를 갖는 칼럼을 연결하여 결과를 검색하는 방법이다.
--             형식은 [select 컬럼 from 테이블1, 테이블2 where (테이블1의)컬럼명=(테이블2의)컬럼명; ] 이다

-- NON-EQUI JOIN: 테이블 간의 공통 컬럼이 없지만 일정 범위의 조건을 만족할 때 비교 연산자를 이용한 조인 방법이다.
-- SELF JOIN : 1개의 테이블(자기 자신의 테이블)에서 조인하는 방법이다.
--             1개의 테이블에서 조인하기 때문에 별칭을 사용해야 원하는 데이터를 조회할 수 있다.

1. oracle 고유의 테이블 조인
-- 형식
-- select table1.column, table2.column, table3.column
-- from table1, table2, table3
-- where table1.column_name = table2.column_name
-- and table2.column = table3.column_name;

select employee_id, last_name, d.department_id, department_name from employees e, departments d where e.department_id = d.department_id;

2. 모호한 열 이름 구분
-- 테이블 접두어를 사용하여 다중 테이블에 있는 열 이름을 구분
-- 테이블 접두어를 사용하여 분석 속도 향상됨
-- 테이블 이름 대신 테이블 alias 사용 가능

3. ANSI: 1999 표준을 사용한 테이블 조인

SELECT table1.column, table2.column
FROM table1
[natural join table2]
[join table2 using(column_name)]
[join table2 on table1.column_name = table2.column_name]
[left | right | full outer join table2 on table1.column_name = table2.column_name]
[cross join table2]

4. natural join
-- 이름과 데이터 유형이 대응되는 모든 열을 사용하여 join함

select employee_id, last_name, department_id, department_name from employees e natural join departments d;

5. using을 이용한 join
-- 열의 이름은 동일, 데이터 유형이 다른 경우, using을 사용하여 join 가능
-- alia를 이용할수 없다.

select employee_id, last_name, department_id, department_name from employees e join departments d using (department_id);

6. on를 이용한 join
-- equijoin 뿐만 아니라, nonequijoin에서도 사용 가능

select employee_id, last_name, d.department_id, department_name from employees e join departments d on e.department_id = d.department_id;

select employee_id, first_name, city, department_name from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id

7. on절을 사용한 non-equijoin 
select e.last_name, e.salary, j.job_title from employees e join jobs j on e.salary between j.min_salary and j.max_salary;


8. outer join을 사용하여 일치되지 않는 행 반환
-- oracle 방식: + 기호를 사용하여 표현
select e.last_name, e.department_id, d.department_name from employees e, departments d where e.department_id = d.department_id(+);
select e.last_name, e.department_id, d.department_name from employees e, departments d where e.department_id(+) = d.department_id;

9. cartesian product
-- 조인 조건이 잘못되거나 생략된 경우, 결과는 모든 행 조합이 표시 (cartesian product)
-- 즉, 첫번째 테이블의 모든 행이 두번째 테이블의모든 행에 조인된다.

select e.last_name, d.department_name from employees e, departments d;

-- 문제 1
select e.last_name, e.job_id, e.department_id, d.department_name, l.city from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where l.city = 'Toronto';

-- 문제 2
select e.employee_id, e.first_name, e.manager_id, m.first_name from employees e left outer join employees m on e.manager_id = m.employee_id order by e.employee_id;









