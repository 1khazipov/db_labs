-- 1NF

CREATE TABLE orders
    (orderId INT,
    date DATE,
    customerId INT,
    customerName VARCHAR(15),
    city VARCHAR(15),
    itemId INT,
    itemName VARCHAR(15),
    quantity INT,
    price REAL,
    PRIMARY KEY (orderId, customerId, itemId)
 );

INSERT INTO orders 
VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '3786', 'Net', '3', '35.00');
INSERT INTO orders 
VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '4011', 'Racket', '6', '65.00');
INSERT INTO orders 
VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '9132', 'Pack-3', '8', '4.75');
INSERT INTO orders 
VALUES ('2302', '2012-02-25', '107', 'Herman', 'Madrid', '5794', 'Pack-6', '4', '5.00');
INSERT INTO orders 
VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '4011', 'Racket', '2', '65.00');
INSERT INTO orders 
VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '3141', 'Cover', '2', '10.00');

-- Queries: 

--1 Calculate the total number of items per order and the total amount to pay for the order
SELECT orderId, SUM(quantity) AS total_items, SUM(quantity * price) AS total_amount
FROM orders
GROUP BY orderId;

-- 2- Obtain the customer whose purchase in terms of money has been greater than the others
SELECT customerId, customerName, SUM(quantity * price) AS total_spent
FROM orders
GROUP BY customerId, customerName
ORDER BY total_spent DESC
LIMIT 1;
