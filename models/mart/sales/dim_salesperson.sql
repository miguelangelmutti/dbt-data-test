with salesperson_unique as (
select distinct a.DDATE, a.SALESPERSON
from {{ref("psg_monthly_sales_make")}} a
)
select row_number() over(order by spu.DDATE, spu.SALESPERSON) as ID_SALESPERSON,spu.DDATE,spu.SALESPERSON
from salesperson_unique spu