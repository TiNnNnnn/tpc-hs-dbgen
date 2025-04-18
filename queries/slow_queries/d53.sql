-- using 1744977929 as a seed to the RNG


select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1997-01-01'
	and l_shipdate < date '1997-01-01' + interval '1' year
	and l_discount >= 0.07 - 0.01 
	and l_discount <= 0.07 + 0.01
	and l_quantity < 24
LIMIT 1;
