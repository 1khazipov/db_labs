CREATE TEBLE relations(
    username varchar(255),
    fullname varchar(255),
    balance int,
    group_id int);

DROP TABLE relations;

INSERT INTO relations 
VALUES
    ('jones', 'Alice Jones', 82, 1),
    ('bitdiddl', 'Ben Bitdiddle', 65, 1),
    ('mike', 'Michael Dole', 73, 2),
    ('alyssa', 'Alyssa P.Hacker', 79, 3),
    ('bbrow', 'Bob Brown', 100, 3);


SELECT * FROM relations;
