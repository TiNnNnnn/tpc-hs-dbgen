-- $ID$
-- TPC-H/TPC-R Suppliers Who Kept Orders Waiting Query (Q21)
-- Functional Query Definition
-- Approved February 1998
-- From 21
:x
:o
select
	s_name,
	count(*) as numwait
from
	supplier,
	lineitem l1,
	orders,
	nation
where
	l1.l_suppkey = s_suppkey
	and l1.l_orderkey = o_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey = l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey = l1.l_suppkey
			and l3.l_receiptdate = l3.l_commitdate
	)
	and s_nationkey = n_nationkey
group by
	s_name
order by
	numwait desc,
	s_name
LIMIT 100;