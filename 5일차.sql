
select prod_id, sum(amt) 
from sales
where to_char(slaes_dt, 'yyyy/mm') = '2023/03'
group by prod_id
having sum(amt) > (selec)


select d.department_id, d.department_name, count(*), round(avg(e.salary))






