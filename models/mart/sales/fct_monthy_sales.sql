with vtas as (
    select DDATE,
        SALESPERSON,
        CARMAKE,
        TOTALSALES,
        TOTALCOMMISSION
    from {{ref("psg_monthly_sales_make")}} 
    )
select v.DDATE,
       dim_carmake.ID_CARMAKE,    
       dim_salesperson.ID_SALESPERSON,
       TOTALSALES,
       TOTALCOMMISSION
from vtas  v 
     left join {{ref("dim_carmake")}} dim_carmake on v.ddate = dim_carmake.ddate and v.carmake = dim_carmake.carmake 
     left join {{ref("dim_salesperson")}} dim_salesperson on v.ddate = dim_salesperson.ddate and v.SALESPERSON = dim_salesperson.SALESPERSON