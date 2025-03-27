-- $ID$
-- TPC-H/TPC-R Customer Distribution Query (Q13)
-- Functional Query Definition
-- Approved February 1998
-- From q13
:x
:o
select
	c_count,
	count(*) as custdist
from
	(
		select
			o_custkey,
			count(o_orderkey)
		from
			customer inner join orders on
				c_custkey = o_custkey
		group by
			o_custkey
	) as c_orders (c_custkey, c_count)
group by
	c_count
order by
	custdist desc,
	c_count desc
LIMIT 1;