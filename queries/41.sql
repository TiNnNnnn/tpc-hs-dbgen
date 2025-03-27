-- $ID$
-- TPC-H/TPC-R Small-Quantity-Order Revenue Query (Q17)
-- Functional Query Definition
-- Approved February 1998
-- From q17
:x
:o
select
	sum(l_extendedprice) / 7.0 as avg_yearly
from
	lineitem,
	part,
	(SELECT l_partkey AS agg_partkey, 0.2 * avg(l_quantity) AS avg_quantity FROM lineitem WHERE l_linenumber > ':1' GROUP BY l_partkey) part_agg
where
	l_partkey = p_partkey
	and agg_partkey = l_partkey
	and l_quantity < avg_quantity
LIMIT 1;
