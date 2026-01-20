-- Überlegung Bestellungen und Bestellzeilen entsprechend zu modellieren - wäre von der Modellierung und DWH practices sauberer. Die Frage ist, ob das nicht schon zu viel ist.
    -- Je nach finalen Übungen würde ich die Sets auch so anpassen, dass wir nur die für uns relevanten Spalten haben, sodass die SELECTS kürzer und übersichtlicher werden - dann dürfte das passen.


WITH orders AS (
	SELECT
		*
	FROM {{ ref('stg__orders') }}
),

lines AS (
	SELECT
		*
	FROM {{ ref('stg__lineitem') }}
)

SELECT
	lines.orderkey,
	lines.linenumber,
	orders.custkey,
	
	orders.orderdate,
	lines.shipdate,
	lines.commitdate,
	lines.receiptdate,
	
	orders.orderstatus,
	orders.orderpriority,
	
	lines.returnflag,
	lines.linestatus,
	lines.shipmode,
	
	lines.quantity,
	lines.extendedprice,
	lines.discount,
	lines.tax,
	
	lines.extendedprice * (1 - lines.discount) AS net_amount,
    lines.extendedprice * (1 - lines.discount) AS discount_amount,
    (lines.extendedprice * (1 - lines.discount)) * (1 + lines.tax) AS net_amount_incl_tax,

    CASE 
	    WHEN lines.shipdate > lines.commitdate 
    		THEN true 
		ELSE false 
	END AS is_late_shipment,

    (lines.shipdate - orders.orderdate) AS days_to_ship,
    (lines.receiptdate - orders.orderdate ) AS days_to_receive
	
FROM lines
	INNER JOIN orders
		ON lines.orderkey  = orders.orderkey