



/* 
need to confirm
*/
with cte as (select *,
        max(salary) over (partition by company_id order by salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) as company_max_salary
        from salaries
)

select company_id,
        employee_id,
        employee_name,
        case when company_max_salary<1000 then round((salary-(salary*0/100)))
            when company_max_salary>=1000 and company_max_salary<=10000 then round((salary-(salary*0.24)))
            when company_max_salary>10000 then round((salary-(salary*0.49)))
            else null end as salary
from cte


/* 
day 57
*/

with first_job as (select employee_id,
        min(start_date) as first_day_job
from job_history
group by 1
)

select b.first_name,
        first_job.first_day_job
from first_job as first_job 
left join employees b on first_job.employee_id=b.employee_id
order by 1


/* 
day 57 - most recent
*/


with first_job as (select employee_id,
        max(start_date) as first_day_job
from job_history
group by 1
)

select b.first_name,
        first_job.first_day_job as recent_job
from first_job as first_job 
left join employees b on first_job.employee_id=b.employee_id
order by 1


/* 
day 57 -First job salary
*/



