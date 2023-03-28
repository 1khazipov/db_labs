-- add column with bank names
ALTER TABLE accounts
ADD COLUMN BankName VARCHAR(50);

UPDATE accounts
SET BankName = 'SberBank'
WHERE id = 1 or id = 3;

UPDATE accounts
SET BankName = 'Tinkoff'
WHERE id = 2;


INSERT INTO accounts (id, name, credit, currency, bank_name)
VALUES (3, 'Account 3', 1000, 'RUB', 'SberBank'),
       (4, 'Fees Account', 0, 'RUB', '');

BEGIN;

    UPDATE accounts 
    SET credit = credit + 500 
    WHERE id = 1;

    UPDATE accounts 
    SET credit = credit - 500 
    WHERE id = 3;


    UPDATE accounts 
    SET credit = credit - 700 
    WHERE id = 2;

    UPDATE accounts 
    SET credit = credit + 670 
    WHERE id = 1;

    UPDATE accounts
    SET credit = credit + 30
    WHERE id = 4;


    UPDATE accounts 
    SET credit = credit + 100 
    WHERE id = 2;

    UPDATE accounts 
    SET credit = credit - 130 
    WHERE id = 3;

    UPDATE accounts 
    SET credit = credit + 30 
    WHERE id = 4;

COMMIT;

ROLLBACK;
