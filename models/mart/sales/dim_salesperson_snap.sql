{{
    config(
        materialized='table'
    )
}}


with snapshot_data as (
    select
		SALESPERSON_ID,
		SALESPERSON_NAME,
		COMISSION_RATE,
		STORE_ID,
		STATUS,
		LAST_UPDATED_TS,
        dbt_scd_id,
        dbt_valid_from,
        dbt_valid_to,
        row_number() over (
            partition by SALESPERSON_ID, cast(dbt_valid_from as date)
            order by dbt_valid_from desc
        ) as rn
      from {{ ref('salesperson_snapshot') }}	  
),

dim_salesperson as (
    select
        dbt_scd_id as id_dim_salesperson,
		SALESPERSON_ID,
		SALESPERSON_NAME,
		COMISSION_RATE,
		STORE_ID,
		STATUS,
		LAST_UPDATED_TS,
        case 
            when row_number() over (partition by SALESPERSON_ID order by dbt_valid_from) = 1 
            then cast(LAST_UPDATED_TS as date)
            else cast(dbt_valid_from as date)
        end as valido_desde,
        case 
            when dbt_valid_to is null then date '9999-12-31'
            else dateadd(day,-1,cast(dbt_valid_to as date))
        end as valido_hasta,
        dbt_valid_to is null as es_actual
    from snapshot_data
    where rn = 1
)
select * from dim_salesperson