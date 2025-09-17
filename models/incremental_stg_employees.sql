{{
    config (
        materialized = 'incremental',
        unique_key = 'employee_id'
    )
}}
Select 
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME ,
EMAIL,
PHONE_NUMBER,
HIRE_DATE,
JOB_ID,
SALARY,
COMISSION_PCT,
MANAGER_ID,
DEPARTMENT_ID,
current_timestamp as LOAD_TIME
from {{ source('hr','SRC_EMPLOYEES') }}

{% if is_incremental() %}
Where load_time > (
    select coalesce(max(load_time),'1900-01-01 00:00:00')
    from {{this}}
)
{% endif %}