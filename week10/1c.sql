CREATE TABLE ledger (
    id SERIAL PRIMARY KEY,
    from_id INT NOT NULL,
    to_id INT NOT NULL,
    fee INT,
    amount float NOT NULL,
    date_time TIMESTAMP NOT NULL);

CREATE OR REPLACE FUNCTION send_money2(id_from INT, id_to INT, amount float)
returns BOOLEAN
AS
$$
declare
    balance float;
BEGIN
    SELECT credit into balance 
    FROM accounts 
    WHERE id = id_from;
    if balance < amount then

        return false;
    end if;

    INSERT INTO ledger (from_id, to_id, amount, date_time) 
    VALUES 
        (id_from, id_to, amount, now());

    UPDATE accounts 
    SET credit = balance - amount 
    SET id = id_from;

    UPDATE accounts 
    SET credit = balance + amount 
    WHERE id = id_to;

    return true;
end;
$$ language plpgsql;

BEGIN;
    savepoint sp1;

    SELECT send_money2(1, 3, 500);

    SELECT * 
    FROM ledger 
    ORDER BY id;

    ROLLBACK to sp1;

    savepoint sp2;

    SELECT send_money2(2, 1, 700);

    SELECT * 
    FROM ledger 
    ORDER BY id;

    ROLLBACK to sp2;

    savepoint sp3;

    SELECT send_money2(2, 3, 100);

    SELECT * 
    FROM ledger 
    ORDER BY id;

    ROLLBACK to sp3;
COMMIT;

-- modified function from the second exercise:
CREATE OR REPLACE FUNCTION send_money_fee2(id_from int, id_to int, amount float)
returns BOOLEAN
as
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

    INSERT INTO ledger 
    VALUES 
        (default, id_from, id_to, fee, amount, now());

    UPDATE accounts 
    SET credit = balance - amount 
    WHERE id = id_from;

    UPDATE accounts 
    SET credit = balance + amount 
    WHERE id = id_to;

    UPDATE accounts 
    SET credit = credit + fee 
    WHERE id = 4;
    return true;
end;
$$ language plpgsql;

BEGIN;
    savepoint sp1;
    SELECT send_money_fee2(1, 3, 500);

    SELECT * 
    FROM ledger 
    ORDER BY id;

    ROLLBACK to sp1;

    savepoint sp2;

    SELECT send_money_fee2(2, 1, 700);

    SELECT * 
    FROM ledger 
    ORDER BY id;

    ROLLBACK to sp2;

    savepoint sp3;

    SELECT send_money_fee2(2, 3, 100);

    SELECT * 
    FROM ledger 
    ORDER BY id;
    
    ROLLBACK to sp3;
COMMIT;
