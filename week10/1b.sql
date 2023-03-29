ALTER TABLE accounts ADD COLUMN bank_name VARCHAR(255);

UPDATE accounts 
SET bank_name = 'SberBank' 
WHERE id = 1;

UPDATE accounts 
SET bank_name = 'SberBank' 
WHERE id = 3;

UPDATE accounts 
SET bank_name = 'Tinkoff' 
WHERE id = 2;

INSERT INTO accounts 
VALUES (4, 'FeeStorage', 0, 'RUB');

CREATE OR REPLACE FUNCTION send_money_fee(id_from INT, id_to INT, amount float)
returns boolean
AS
$$
declare
    balance float;
    fee INT;
    bank_name1 VARCHAR(255);
    bank_name2 VARCHAR(255);

BEGIN
    SELECT bank_name into bank_name1 
    FROM accounts
    WHERE id = id_from;

    SELECT bank_name into bank_name2 
    FROM accounts 
    WHERE id = id_to;

    if bank_name1 = bank_name2 then
        SELECT 30 into fee;
    else
        SELECT 0 into fee;
    end if;

    SELECT credit into balance 
    FROM accounts 
    WHERE id = id_from;

    if balance < amount then
        return false;
    end if;

    UPDATE accounts 
    SET credit = balance - amount
    WHERE id = id_from;

    UPDATE accounts 
    SET credit = balance + amount 
    SET id = id_to;

    UPDATE accounts 
    SET credit = credit + fee 
    SET id = 4;

    return true;
END;
$$ language plpgsql;

BEGIN;
    savepoint sp1;

    SELECT send_money_fee(1, 3, 500);

    SELECT * 
    FROM accounts 
    ORDER BY id;

    ROllBACK to sp1;

    savepoint sp2;

    SELECT send_money_fee(2, 1, 700);

    SELECT * 
    FROM accounts 
    ORDER BY id;

    ROllBACK to sp2;

    savepoint sp3;
    
    SELECT send_money_fee(2, 3, 100);

    SELECT * 
    FROM accounts 
    ORDER BY id;

    ROllBACK to sp3;
COMMIT;
