CREATE TABLE loans (
loan_id INT PRIMARY KEY,
school VARCHAR(50),
teacher VARCHAR(30),
course VARCHAR(40),
room VARCHAR(10),
class VARCHAR(5),
section VARCHAR(10),
loan_date DATE
);

CREATE TABLE books (
book_id INT PRIMARY KEY,
title VARCHAR(90),
publisher VARCHAR(90)
);

CREATE TABLE loan_books (
loan_id INT,
book_id INT,
PRIMARY KEY (loan_id, book_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO loans 
VALUES 
	(1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01', '2010-09-09'),
	(2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01', '2010-05-05'),
	(3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01', '2010-05-05'),
	(4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01', '2010-05-06'),
	(5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01', '2010-05-06'),
	(6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01', '2010-09-09'),
	(7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01', '2010-05-05'),
	(8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01', '2010-12-18'),
	(9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01', '2010-05-06');

INSERT INTO books 
VALUES 
	(1, 'Learning and teaching in early childhood education', 'BOA Editions'),
	(2, 'Preschool, N56', 'Taylor & Francis Publishing'),
	(3, 'Early Childhood Education N9', 'Prentice Hall'),
	(4, 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

INSERT INTO loan_books 
VALUES 
	(1, 1),
	(2, 2),
	(3, 1),
	(4, 3),
	(5, 1),
	(6, 1),
	(7, 4),
	(8, 4),
	(9, 1);

-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT loans.school, books.publisher, COUNT(*) AS num_loans
FROM loans
	JOIN loan_books ON loans.loan_id = loan_books.loan_id
	JOIN books ON loan_books.book_id = books.book_id
GROUP BY loans.school, books.publisher;

-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it
SELECT loans.school, books.title, loans.teacher, MAX(loans.loan_date) AS loan_date
FROM loans
	JOIN loan_books ON loans.loan_id = loan_books.loan_id
	JOIN books ON loan_books.book_id = books.book_id
GROUP BY loans.school, books.title
HAVING loan_date = MAX(loans.loan_date);