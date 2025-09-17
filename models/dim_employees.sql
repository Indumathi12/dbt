{{
    config (materialized = 'table',
            unique_key = 'employee_id')
}}

Select 
EMPLOYEE_ID,
FIRST_NAME||LAST_NAME as name ,
EMAIL,
PHONE_NUMBER,
HIRE_DATE,
JOB_ID,
SALARY,
COMISSION_PCT,
MANAGER_ID,
DEPARTMENT_ID,
current_timestamp as LOAD_TIME
from {{ ref ('incremental_stg_employees')}}

{% if is_incremental()%}

where load_time > (select coalesce(max(loadtime), '1900-01-01 00:00:00'
from {{ this }}
)

{% endif %}
