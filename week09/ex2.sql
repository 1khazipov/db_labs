CREATE OR REPLACE FUNCTION retrieve_customers(start INTEGER, end_pos INTEGER)
RETURNS TABLE (
  customer_id INTEGER,
  store_id SMALLINT,
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  email VARCHAR(50),
  address_id SMALLINT,
  activebool BOOLEAN,
  create_date DATE,
  last_update TIMESTAMP,
  active INTEGER
)
AS $$
BEGIN
  IF start < 0 OR end_pos  > 600 THEN
    RAISE EXCEPTION 'Invalid start or end parameter. Start and end must be between 0 and 600.';
  END IF;

  RETURN QUERY SELECT *
               FROM customer
               ORDER BY address_id
               OFFSET start
               LIMIT (end_pos  - start + 1);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM retrieve_customers(10, 40);
