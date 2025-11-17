select try_cast(car_sales.DDATE as date) as DDATE,
       SALESPERSON,
       CUSTOMERNAME,
       CARMAKE,
       CARMODEL,
       cast(CARYEAR AS varchar) as CARYEAR,
       SALEPRICE,
       COMMISSIONRATE as COMRATE,
       COMMISSIONEARNED AS COMEARNED
from {{source("raw_car_sales","car_sales")}} car_sales
where try_cast(car_sales.DDATE as date) >= '2020-01-01'