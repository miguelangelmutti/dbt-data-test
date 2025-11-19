with salesperson_unique as (
select distinct a.DDATE, a.SALESPERSON
from {{ref("psg_monthly_sales_make")}} a
)
select {{ get_row_number_by(['DDATE','SALESPERSON']) }} as ID_SALESPERSON,spu.DDATE,spu.SALESPERSON
from salesperson_unique spu

