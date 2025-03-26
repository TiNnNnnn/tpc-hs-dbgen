-- $ID$
-- TPC-H/TPC-R Forecasting Revenue Change Query (Q6)
-- Functional Query Definition
-- Approved February 1998
-- From q6
:x
:o
select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date ':1'
	and l_shipdate < date ':1' + interval '2' year
	and l_discount >= :2 - 0.02 
	and l_discount <= :2 + 0.02
	and l_quantity < :3
LIMIT 1;