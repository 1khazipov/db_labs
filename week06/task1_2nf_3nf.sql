--NF2 and NF3 they have the same tables with same queries solutions:

CREATE TABLE order_item (
    orderId INT,
    itemId INT,
    quantity INT,
    PRIMARY KEY (orderId, itemID)
);

INSERT INTO order_item 
VALUES 
    ('2301', '3786', '3'),
    ('2301', '4011', '6'),
    ('2301', '9132', '8'),
    ('2302', '5794', '4'),
    ('2303', '4011', '2'),
    ('2303', '3141', '2');
 
CREATE TABLE item_price(
    itemId INT,
    itemName VARCHAR(15),
    price REAL,
    PRIMARY KEY (itemID)
);

INSERT INTO item_price 
VALUES 
('3786', 'Net', '35.00'),
    ('4011', 'Racket', '65.00'),
    ('9132', 'Pack-3', '4.75'),
    ('5794', 'Pack-6', '5.00'),
    ('3141', 'Cover', '10.00');

CREATE TABLE customer_city (
    customerId INT,
    customerName VARCHAR(15),
    city VARCHAR(15),
    PRIMARY KEY (customerId)
);

INSERT INTO customer_city 
VALUES 
    ('101', 'Martin', 'Prague'),
    ('107', 'Herman', 'Madrid'),
    ('110', 'Pedro', 'Moscow');
 
CREATE TABLE order_customer (
    orderId INT,
    customerId INT,
    date DATE,
    PRIMARY KEY(orderId)
);

INSERT INTO order_customer 
VALUES 
    ('2301', '101', '2011-02-23'),
    ('2302', '107', '2011-02-25'),
    ('2303', '110', '2011-02-27');

-- Queries: 
--1 Calculate the total number of items per order and the total amount to pay for the order
SELECT 
    oi.orderId, 
    SUM(oi.quantity) AS total_items, 
    SUM(ip.price * oi.quantity) AS total_amount
FROM order_item oi JOIN item_price ip ON oi.itemId = ip.itemId
GROUP BY oi.orderId;


-- 2- Obtain the customer whose purchase in terms of money has been greater than the others
SELECT cc.customerId, cc.customerName, SUM(ip.price * oi.quantity) AS total_spent
FROM order_customer oc
    JOIN customer_city cc ON oc.customerId = cc.customerId
    JOIN order_item oi ON oc.orderId = oi.orderId
    JOIN item_price ip ON oi.itemId = ip.itemId
GROUP BY cc.customerId, cc.customerName
ORDER BY total_spent DESC
LIMIT 1;
