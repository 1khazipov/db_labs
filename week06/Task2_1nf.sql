-- 1NF
CREATE TABLE loan_books (
    loan_id INT PRIMARY KEY,
    school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    class VARCHAR(5),
    section VARCHAR(10),
    title VARCHAR(90),
    publisher VARCHAR(90),
    loan_date DATE
);

INSERT INTO loan_books 
VALUES 
	(1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09'),
	(2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01', 'Preschool, N56', 'Taylor & Francis Publishing', '2010-05-05'),
	(3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-05'),
	(4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01', 'Early Childhood Education N9', 'Prentice Hall', '2010-05-06'),
	(5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06'),
	(6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09'),
	(7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-05-05'),
	(8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-12-18'),
	(9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');


-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT school, publisher, COUNT(*) as num_loans
FROM loan_books
GROUP BY school, publisher;


-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it
SELECT school, title, teacher, loan_date, DATEDIFF(NOW(), loan_date) AS days_on_loan
FROM loan_books
WHERE (school, loan_date) IN (
	SELECT school, MAX(loan_date)
	FROM loan_books
	GROUP BY school
)
ORDER BY days_on_loan DESC;