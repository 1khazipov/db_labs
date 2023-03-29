CREATE TABLE accounts (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    credit float NOT NULL,
    currency VARCHAR(255) NOT NULL);

INSERT INTO accounts VALUES (1, 'Alice', 1000.00, 'RUB');
INSERT INTO accounts VALUES (2, 'Bob', 1000.00, 'RUB');
INSERT INTO accounts VALUES (3, 'Charlie', 1000.00, 'RUB');

CREATE OR REPLACE FUNCTION send_money(id_from INT, id_to INT, amount float)
returns BOOLEAN
AS
$$
declare
    balance float;
BEGIN
    SELECT credit into balance 
    FROM accounts 
    WHERE id = id_from;

    if balance < amount THEN
        return false;
    END if;

    UPDATE accounts 
    SET credit = balance - amount 
    WHERE id = id_from;

    UPDATE accounts 
    SET credit = balance + amount 
    WHERE id = id_to;

    return true;
END;
$$ language plpgsql;

BEGIN;
    savepoint sp1;

    SELECT send_money(1, 3, 500);

    SELECT credit 
    FROM accounts;

    ROLLBACK to sp1;

    savepoint sp2;

    SELECT send_money(2, 1, 700);

    SELECT credit FROM accounts;

    ROLLBACK to sp2;

    savepoint sp3;
    
    SELECT send_money(2, 3, 100);

    SELECT credit FROM accounts;

    ROLLBACK to sp3;
COMMIT;
