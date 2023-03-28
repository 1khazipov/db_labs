CREATE TABLE IF NOT EXISTS accounts(
  id INT,
  name VARCHAR(50),
  credit REAL,
  currency VARCHAR(10)
);

INSERT INTO accounts (id, name, credit, currency)
VALUES (1, 'Account_1', 1000.00, 'RUB'),
       (2, 'Account_2', 1000.00, 'RUB'),
       (3, 'Account_3', 1000.00, 'RUB');
     
BEGIN;
    SAVEPOINT sp1;

    UPDATE accounts 
    SET credit = credit - 500.00
    WHERE id = 1;

    UPDATE accounts 
    SET credit = credit + 500.00
    WHERE id = 3;


    SAVEPOINT sp2;
    UPDATE accounts 
    SET credit = credit - 700.00
    WHERE id = 2;

    UPDATE accounts 
    SET credit = credit + 700.00
    WHERE id = 1;


    SAVEPOINT sp3;
    UPDATE accounts 
    SET credit = credit - 100.00
    WHERE id = 2;

    UPDATE accounts 
    SET credit = credit + 100.00
    WHERE id = 3;
COMMIT;

SELECT id, credit 
FROM accounts;
