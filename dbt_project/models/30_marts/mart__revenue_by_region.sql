with orders as (
    select
        order_id,
        customer_id,
        total_net_amount
    from {{ ref('fact__orders') }}
),

customer as (
    select
        customer_id,
        nation_id
    from {{ ref('dim__customer') }}
),

geo as (
    select
        nation_id,
        region
    from {{ ref('dim__geo') }}
)

select
    g.region,
    count(*) as total_orders,
    sum(o.total_net_amount) as total_revenue,
    round(avg(o.total_net_amount)::numeric, 2) as avg_order_value
from orders o
left join customer c
    on o.customer_id = c.customer_id
left join geo g
    on c.nation_id = g.nation_id
group by
    g.region
order by
    total_revenue desc
