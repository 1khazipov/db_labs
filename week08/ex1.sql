-- TIME required for execution without using indexes
EXPLAIN ANALYZE SELECT NAME 
FROM customer 
WHERE address = '2579 Joel Green Suite 253 North Russell, PA 40970';
--"Seq Scan on customer  (cost=0.00..4280.00 rows=1 width=14) (actual time=23.693..23.694 rows=0 loops=1)"

-- TIME required for execution using indexes
CREATE INDEX customer_name_btree ON customer USING btree(name);
CREATE INDEX customer_address_hash ON customer USING hash(address);
EXPLAIN ANALYZE SELECT NAME 
FROM customer 
WHERE address = '2579 Joel Green Suite 253 North Russell, PA 40970';
-- Index Scan using customer_address_hash on customer (cost=0.00..8.02 rows=1 width=14) (actual time=0.329..0.330 rows=0 loops=1)
-- There is a difference because indexes are faster.
