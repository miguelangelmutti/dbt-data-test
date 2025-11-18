with car_make_unique as (
select distinct a.DDATE, a.CARMAKE
from {{ref("psg_monthly_sales_make")}} a
)
select row_number() over(order by cmu.DDATE, cmu.CARMAKE) as ID_CARMAKE,cmu.DDATE,cmu.CARMAKE
from car_make_unique cmu


