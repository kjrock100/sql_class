1. sql 함수 유형
-- 단일행 함수: 행당 하나의 결과 반환
-- 다중행 함수: 행 집합당 하나의 결과 반환

2. 단일행 함수
-- 데이터 조작
-- 행당 하나의 결과 반환
-- selec, where, order by 절에 사용

3. 단일행 함수 유형
-- 문자함수
-- 숫자함수
-- 날짜함수
-- 변환함수
-- 기타함수

4. 문자함수
-- lower : 소문자 변환
-- upper : 대문자 변환
-- initcap : 첫 글자를 대문자로
-- concat : 문자열 결합
-- substr : 문자열 추출
-- length : 문자열 길이
-- instr : 특정 문자열 위치
-- lpad | rpad : 문자열 채움
-- replace : 문자열 교체

5. 대소문자 변환
-- lower('SQL Course') -> sql cource
-- upper('SQL Course') -> SQL COURCE
-- inicap('SQL Course') -> Sql Cource

select employee_id, upper(last_name), department_id from employees where initcap(last_name) = 'Higgins';

6. 문자 조작 함수
-- concat('Hello','World') -> HelloWorld
-- substr('HelloWorld', 1,5) -> Hello
-- length('HelloWorld') -> 10
-- instr('HelloWorld','W') -> 6
-- lpad('Hello', 10, '*') -> *****Hello
-- rpad('Hello', 10, '*') -> Hello*****
-- replace('Jack and Jue','J','Bl') -> Black and Blue

select salary, lpad(salary,10,'*'), rpad(salary,10,'*') from employees;
select first_name, replace(first_name, 'en', '?!') from employees;

7. 숫자 함수
-- round : 반올림
-- trunc : 지정된 자리수 이하 절삭
-- mod(m,n) : 나머지
-- sign : 양수(1), 음수(-1), 영(0)
-- abs : 절대값
-- floor : 지정 수보다 크지않은 가장 큰 정수
-- ceil : 지정 수보다 작지않은 가장 작은 정수

select round(45.923,2), round(45.923,0), round(45.923,-1) from dual;
--    45.92              46               50

select trunc(45.923,2), trunc(45.923,0), trunc(45.923,-1) from dual;
--    45.92              45               40

select last_name, salary, mod(salary, 5000) from employees where job_id = 'SA_REP';

select last_name, salary, sign(salary - 5760) from employees where department_id = 60;

select abs(-30), abs(10), floor(6.7), ceil(6.7) from dual;
--     30         10          6          7


8. 날짜 데이터
-- 세기, 년, 월, 일, 시, 분, 초 데이터 저장
-- 기본 날짜 표시 형식
--  - RR/MM/DD  : 한글 OS
--  - DD-MON-RR : 영문 OS
--  - RR 표시 형식은 Y2K를 고려 (00~49: 2000년, 50~99: 1900년)

9. 날짜 데이터 연산
-- date + number : 일수 더한 날짜 반환
-- date - number : 일수 뺀 날짜 반환
-- date - date  :  일수 반환
-- date + number/24 : number  시간 더하기
-- date + number/1440 : number  분 더하기

10. 날짜 함수
-- sysdate : 현재 날짜
-- systimestamp : 현재 시간을 timestamp with time zone 형식으로
-- current_date : 현재 session의 날짜
-- current_timestamp : 현재 session의 날짜를 timestamp with time zone 형식으로

select sysdate, systimestamp, current_date, current_timestamp from dual;
-- 23/03/23        23/03/23 20:58:51.275000 +09:00          23/03/23        23/03/23 20:58:51.000000 +09:00


11. 날짜 조작 함수
-- months_between(d1, d2) : d1, d2 두 날짜간의 개월 수
-- add_months(d1, n) : d1 + n 개월
-- next_day(d1,'CHAR') : d1이후의 요일의 날짜
-- last_day(d1) : d1 날짜 월의 마지막 날짜
-- round : 날짜 반올림
-- trunc : 날짜 TRUNCATE

select months_between('22/09/01','22/01/11'), add_months('22/01/31',3), 
next_day('22/08/15','금요일'), last_day('22/02/01'), 
round(sysdate,'MONTH'), trunc(sysdate,'MONTH')
  from dual;
--   7.67741935   22/04/30 
--   22/08/19     22/02/28 
--   23/04/01     23/03/01


12. 변환 함수
-- 암시적 데이터 변환
-- 명시적 데이터 변환

13. 암시적 데이터 변환
-- varchar2 or char -> number
-- varchar2 or char -> date 

-- number -> varchar2 or char
-- date -> varchar2 or char

select last_name, first_name, salary, department_id from employees where department_id = '20';
select last_name, first_name, hire_date from employees where hire_date > '05/12/15';
select employee_id, last_name, first_name, salary, department_id from employees where employee_id like '11%';

14. 명시적 데이터 변환
-- to_number : char -> number
-- to_date : char -> date 
-- to_char : number -> char
--           date -> char

15. 날짜 데이터에 to_char 함수 사용
-- to_char(date [, 'format_model'])
-- [ 날짜 format_model ]
--   YYYY : 년도
--   YEAR : 년도
--   MM :   월
--   MONTH / MON : 월 이름 / 3글자 월 이름
--   DAY / DY : 일 이름 / 3글자 일 이름
--   Q : 분기
--   WW / W : 일년 중 주 / 월 중 주
--   DD : 월간 일
--   HH or HH24 : 시간
--   MI : 분
--   SS : 초
--   D : 일주일 중의 몇번째 날
--   DDD : 일년 중의 몇번째 날

select employee_id, to_char(hire_date,'MM/YY') month_hired from employees where last_name = 'Higgins';
--  205 06/02

-- fm 포맷 사용시, 숫자 앞의0을 제거하고 표시
select last_name, to_char(hire_date, 'fmDD Month YYYY') from employees;

16. 숫자 데이터에 to_char 함수 사용
-- to_char(number [, 'format_model'])
-- [숫자 format]
--  9 : 숫자
--  0 : 0
--  $ : 달러 기호
--  L : 로컬 통화 기호
--  , / G : 천 단위 구분자 ( , ) 
--  . / D : 소수점 구분자 ( . )

select first_name, to_char(salary,'$99,999.00') from employees where last_name = 'Ernst';
select first_name, to_char(salary,'$99G999D00') from employees where last_name = 'Ernst';
--     Bruce     $6,000.00

17. to_number, to_date 함수

to_number(char[,'format_model'])
to_date(char[,'format_model'])

select last_name, to_char(hire_date,'DD-Mon-YYYY') from employees where hire_date < to_date('01-1월-02','DD-MON-RR');

18. nvl 함수 
-- null값을 실제 값으로 변환
-- nvl(expr1, expr2)
--  : expr1이 null이면 expr2 반환

select last_name, salary, nvl(commission_pct,0), (salary*12)+(salary*12nvl(commission_pct,0)) from employees where hire_date < to_date('2003/01/01','yyyy/mm/dd');

19. nvl2 함수
-- nvl2(expr1, expr2, expr3)
--  : expr1 != null ? exptr2 : exptr3 

select last_name, salary, commission_pct, nvl2(commission_pct, 'SAL+COMM','SAL') from employees where department_id in (50, 80);

20. nullif 함수
-- nullif(expr1, expr2)
-- 두 식이 같으면 null 반환
-- 두 식이 다름면 exptr1 반환
-- exptr1은 not null 

select first_name n1, length(first_name) l1, last_name n2, length(last_name) l2, nullif(length(first_name),length(last_name)) r from employees;

21. coalesce 함수
-- 최초 null이 아닌 표현식 반환
-- 리스트의모든 표현식은 동일한 데이터 유헝
-- coalesce(expr1, expr2,...,exprn)

select manager_id, commission_pct, coalesce(to_char(commission_pct), to_char(manager_id), 'No commission and no manager') coalesce_nm from employees;

22. 조건부 표현식
-- if-then-else 논리 사용
-- case 식
-- decode 함수

23. decode 함수
-- decode( col | expression, search1, result1 
--                           [, search2, result2] 
--                           [, search3, result3]
--                            ..
--                           [, default])

select last_name, job_id, salary, decode( job_id,'SH_CLERK', 1.10*salary,'MK_MAN', 1.15*salary,'HR_REP', 1.20*salary, salary) revised_salary from employees;


24. case 식
-- case expr when comparion2 then return1
--               [when comparion2 then return2]
--               ...
--               [else default]
-- end


select last_name, job_id, salary, case when job_id = 'SH_CLERK' then 1.10*salary 
when job_id = 'MK_MAN' then 1.15*salary 
when job_id = 'HR_REP' then 1.20*salary
else salary end "revised_salary" from employees;

select last_name, job_id, salary, case job_id when 'SH_CLERK' then 1.10*salary 
when 'MK_MAN' then 1.15*salary 
when 'HR_REP' then 1.20*salary
else salary end "revised_salary" from employees;

select last_name, job_id, salary, case when salary < 5000 then 'Low'
when salary < 10000 then 'Medium'
when salary < 20000 then 'Good'
else 'Excellent' end qualified_salary from employees;



