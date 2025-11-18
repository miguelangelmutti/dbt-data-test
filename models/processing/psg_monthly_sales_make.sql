{{
    config(
        materialized = "table",
        tags = ["processing","sales","carmake"]
    )
}}
select DATE_TRUNC('MONTH', DDATE) AS DDATE,
       SALESPERSON,
       CARMAKE,
       SUM(SALEPRICE - COMEARNED) TOTALSALES,
       SUM(COMEARNED) TOTALCOMMISSION
from {{ref("stg_sales_data")}}
group by DATE_TRUNC('MONTH', DDATE),
         SALESPERSON,
         CARMAKE