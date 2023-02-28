CREATE TABLE loans(
	loan_id INT PRIMARY KEY,
	loan_date DATE
);

CREATE TABLE loan_details (
	loan_id INT,
	teacher VARCHAR(30),
	course VARCHAR(40),
	room VARCHAR(10),
	class VARCHAR(5),
	section VARCHAR(10),
	PRIMARY KEY (loan_id),
	FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE books (
	book_id INT PRIMARY KEY,
	title VARCHAR(90),
	publisher VARCHAR(90)
);

CREATE TABLE loan_books
(
loan_id INT,
book_id INT,
PRIMARY KEY (loan_id, book_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE loans_by_school (
	loan_id INT,
	school VARCHAR(50),
	PRIMARY KEY (loan_id, school),
	FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

INSERT INTO loans 
VALUES
	(1, '2010-09-09'),
	(2, '2010-05-05'),
	(3, '2010-05-05'),
	(4, '2010-05-06'),
	(5, '2010-05-06'),
	(6, '2010-09-09'),
	(7, '2010-05-05'),
	(8, '2010-12-18'),
	(9, '2010-05-06');

INSERT INTO loan_details 
VALUES 
	(1, 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01'),
	(2, 'Chad Russell', 'Writing', '1.A01', '1', 'A01'),
	(3, 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01'),
	(4, 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01'),
	(5, 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01'),
	(6, 'Jones Smith', 'Writing', '1.A01', '2', 'A01'),
	(7, 'Jones Smith', 'English', '1.A01', '2', 'A01'),
	(8, 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01'),
	(9, 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01');

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

INSERT INTO loans_by_school
VALUES 
	(1, 'Horizon Education Institute'),
	(2, 'Horizon Education Institute'),
	(3, 'Horizon Education Institute'),
	(4, 'Horizon Education Institute'),
	(5, 'Horizon Education Institute'),
	(6, 'Horizon Education Institute'),
	(7, 'Horizon Education Institute'),
	(8, 'Bright Institution'),
	(9, 'Bright Institution');

-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT l.school, b.publisher, COUNT(*) AS num_books_loaned
FROM loans_by_school l
	JOIN loan_details ld ON l.loan_id = ld.loan_id
	JOIN loan_books lb ON l.loan_id = lb.loan_id
	JOIN books b ON lb.book_id = b.book_id
GROUP BY l.school, b.publisher;


-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it
SELECT l.school, lb.book_id, b.title, ld.teacher, DATEDIFF(CURRENT_DATE, lo.loan_date) AS days_on_loan
FROM loans_by_school l
	JOIN loan_details ld ON l.loan_id = ld.loan_id
	JOIN loan_books lb ON l.loan_id = lb.loan_id
	JOIN books b ON lb.book_id = b.book_id
	JOIN loans lo ON l.loan_id = lo.loan_id
WHERE (l.school, lb.book_id, lo.loan_date) IN (
	SELECT l.school, lb.book_id, MIN(lo.loan_date)
	FROM loans_by_school l
		JOIN loan_books lb ON l.loan_id = lb.loan_id
		JOIN loans lo ON l.loan_id = lo.loan_id
	GROUP BY l.school, lb.book_id
	)
ORDER BY l.school;