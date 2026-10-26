INSERT INTO Categories (CategoryName)
VALUES
('Fiction'),
('Technology'),
('Business'),
('Science'),
('History'),
('Self Help');
SELECT * FROM Categories;

INSERT INTO Authors (AuthorName)
VALUES
('Robert Kiyosaki'),
('J.K. Rowling'),
('George Orwell'),
('Stephen Hawking'),
('Yuval Noah Harari'),
('James Clear'),
('R.K. Narayan'),
('Dan Brown');
SELECT * FROM Authors;

INSERT INTO Students 
(StudentName, Email, Phone, Department)
VALUES
('Aisha Khan', 'aisha@gmail.com', '9876543210', 'Commerce'),
('Rahul Sharma', 'rahul@gmail.com', '9876543211', 'Science'),
('Zoya Ahmed', 'zoya@gmail.com', '9876543212', 'Commerce'),
('Arjun Mehta', 'arjun@gmail.com', '9876543213', 'IT'),
('Sara Patel', 'sara@gmail.com', '9876543214', 'Management'),
('Kabir Shah', 'kabir@gmail.com', '9876543215', 'IT'),
('Maya Singh', 'maya@gmail.com', '9876543216', 'Science'),
('Omar Khan', 'omar@gmail.com', '9876543217', 'Commerce');
SELECT * FROM Students;
SELECT * FROM Categories;

INSERT INTO Books
(BookTitle, CategoryID, Publisher, Price, TotalCopies, AvailableCopies)
VALUES
('Rich Dad Poor Dad', 3, 'Plata Publishing', 450.00, 5, 4),
('Harry Potter', 1, 'Bloomsbury', 550.00, 6, 5),
('1984', 1, 'Penguin', 400.00, 4, 3),
('A Brief History of Time', 4, 'Bantam Books', 650.00, 5, 5),
('Sapiens', 5, 'HarperCollins', 700.00, 4, 2),
('Atomic Habits', 6, 'Penguin Random House', 500.00, 8, 7),
('The Alchemist', 1, 'HarperCollins', 350.00, 6, 6),
('Digital Fortress', 2, 'St. Martins Press', 600.00, 3, 2);
SELECT*FROM Books;

INSERT INTO BookAuthors (BookID, AuthorID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Borrowings
(StudentID, BookID, IssueDate, DueDate, ReturnDate)
VALUES
(1, 1, '2026-08-01', '2026-08-15', '2026-08-12'),
(2, 4, '2026-08-02', '2026-08-16', NULL),
(3, 6, '2026-08-03', '2026-08-17', '2026-08-15'),
(4, 2, '2026-08-04', '2026-08-18', NULL),
(5, 5, '2026-08-05', '2026-08-19', NULL),
(6, 3, '2026-08-06', '2026-08-20', '2026-08-14'),
(7, 7, '2026-08-07', '2026-08-21', NULL),
(8, 8, '2026-08-08', '2026-08-22', NULL);
SELECT * FROM Books;

# Display only book title and price.
SELECT BookTitle, Price FROM Books;

# Display all students.
Select * from Students;

# Display students from Commerce department.
select * from students where department = "Commerce";

# Find books having price greater than ₹500.
select * from Books where Price >500;

# Find books having price less than or equal to ₹500.
select * from Books where price <=500;

# AND / OR
#Find books above ₹400 and below ₹700.
select * from Books where Price >400 and Price <700;

# Find students from Commerce OR IT.
select * from Students where department = "Commerce" OR department="IT";

#LIKE
#Find students whose name starts with A.
select * from Students where StudentName LIKE "A%";

#Find students whose name ends with a.
select * from Students where StudentName like "%A";

#Find books containing the word "History".
select * from Books where BookTitle like "%History%";

#IN
#Find students from Commerce, IT and Science.
SELECT *FROM Students
WHERE Department IN ('Commerce', 'IT', 'Science');

#BETWEEN
# Find books priced between ₹400 and ₹600.
SELECT *
FROM Books
WHERE Price BETWEEN 400 AND 600;

#ORDER BY
#Display books from lowest to highest price
select * from Books order by Price ASC;

# Display books from highest to lowest price.
SELECT * from Books order by Price DESC;

#LIMIT 
# Display top 3 expensive books.
select * from Books order by Price DESC LIMIT 3;

#OFFSET
# Display 3 books after skipping the first 2.
select * from Books limit 3 offset 2;

#AGGREGATE FUNCTIONS
#COUNT() SUM() AVG() MIN() MAX()
#Count total books.
SELECT COUNT(*) AS TotalBooks FROM Books;

#Find the highest book price.
select max(Price) as HighestPrice from Books;

# Find the lowest book price.
select min(Price) as LowestPrice from Books;

#Find average book price.
select avg(Price) as AvgPrice from Books;

#Find total value of all books.
select sum(Price) as TotalPrice from Books;

#GROUP BY
#Count books in each category
SELECT CategoryID, COUNT(*) AS TotalBooks
FROM Books
GROUP BY CategoryID;

#GROUP BY + HAVING
# Find categories having more than 1 book.
SELECT CategoryID, COUNT(*) 
AS TotalBooks
FROM Books
GROUP BY CategoryID
HAVING COUNT(*) > 1;

#WHERE filters individual rows.
#HAVING filters grouped results.

#Increase the price of Atomic Habits to ₹550.
UPDATE Books
SET Price = 550 where BookID=6;
update Books set Price = 350 where BookID=3;
SELECT* FROM Books;

#DELETE
#Delete a student.
# DELETE FROM Students WHERE StudentID = 8;
#because relationships can exist, deleting records may fail if that student has borrowing records.

#ALTER TABLE
#Let's add a column
ALTER TABLE Students ADD Address VARCHAR(200);
DESC Students;

USE LibraryManagementSystem;
#JOINS
# INNER JOIN 
# Display book name with its category.
SELECT Books.BookTitle,Categories.CategoryName
FROM Books
INNER JOIN Categories
ON Books.CategoryID = Categories.CategoryID;

#Display book title and author name.
SELECT Books.BookTitle,Authors.AuthorName
FROM Books
INNER JOIN BookAuthors
ON Books.BookID = BookAuthors.BookID
INNER JOIN Authors
ON BookAuthors.AuthorID = Authors.AuthorID;

#Display Book, Category and Author.
SELECT Books.BookTitle,Categories.CategoryName,Authors.AuthorName
FROM Books
INNER JOIN Categories
ON Books.CategoryID = Categories.CategoryID
INNER JOIN BookAuthors
ON Books.BookID = BookAuthors.BookID
INNER JOIN Authors
ON BookAuthors.AuthorID = Authors.AuthorID;

#BORROWING REPORT
#Display which student borrowed which book.
SELECT
Students.StudentName,
Books.BookTitle,
Borrowings.IssueDate,
Borrowings.DueDate,
Borrowings.ReturnDate
FROM Borrowings
INNER JOIN Students
ON Borrowings.StudentID = Students.StudentID
INNER JOIN Books
ON Borrowings.BookID = Books.BookID;
#Library Transaction Report.

#FIND CURRENTLY BORROWED BOOKS
SELECT
Students.StudentName,
Books.BookTitle,
Borrowings.IssueDate,
Borrowings.DueDate
FROM Borrowings
INNER JOIN Students
ON Borrowings.StudentID = Students.StudentID
INNER JOIN Books
ON Borrowings.BookID = Books.BookID
WHERE Borrowings.ReturnDate IS NULL;
# NULL MEANS BOOKS HAVE NOT BEEN RETURNED

#FIND RETURNED BOOKS
SELECT
Students.StudentName,
Books.BookTitle,
Borrowings.IssueDate,
Borrowings.ReturnDate
FROM Borrowings
INNER JOIN Students
ON Borrowings.StudentID = Students.StudentID
INNER JOIN Books
ON Borrowings.BookID = Books.BookID
WHERE Borrowings.ReturnDate IS NOT NULL;

#COUNT BORROWINGS
# Find total number of books issued.
SELECT COUNT(*) AS TotalBorrowings
FROM Borrowings;

#MOST BORROWED BOOK
SELECT
Books.BookTitle,
COUNT(Borrowings.BookID) AS TimesBorrowed
FROM Borrowings
INNER JOIN Books
ON Borrowings.BookID = Books.BookID
GROUP BY Books.BookID, Books.BookTitle
ORDER BY TimesBorrowed DESC
LIMIT 1;
USE LibraryManagementSystem;

#MOST ACTIVE STUDENT
SELECT
Students.StudentName,
COUNT(Borrowings.StudentID) AS TotalBorrowings
FROM Borrowings
INNER JOIN Students
ON Borrowings.StudentID = Students.StudentID
GROUP BY Students.StudentID, Students.StudentName
ORDER BY TotalBorrowings DESC
LIMIT 1;

#SUBQUERY
#Find books whose price is greater than the average book price.
SELECT *
FROM Books
WHERE Price > (
SELECT AVG(Price)
FROM Books
);
SELECT AVG(Price)
FROM Books;

#CASE STATEMENT
SELECT
BookTitle,
Price,
CASE
WHEN Price >= 600 THEN 'Expensive'
WHEN Price >= 400 THEN 'Medium'
ELSE 'Affordable'
END AS PriceCategory
FROM Books;

SELECT * FROM BOOKS WHERE BOOKTITLE LIKE "A%";
SELECT * FROM Books WHERE Price BETWEEN 300 AND 700;
SELECT * FROM Books ORDER BY Price DESC LIMIT 3;
SELECT COUNT(*) AS Total_Students
FROM Students;
SELECT Department, COUNT(*) AS Total_Students
FROM Students
GROUP BY Department;
SELECT Department, COUNT(*) AS Total_Students FROM Students
GROUP BY Department HAVING COUNT(*) > 2;
SELECT *
FROM Students
WHERE Department IN ('Commerce', 'IT');

#DELETE vs TRUNCATE vs DROP

# DELETE FROM Books WHERE BookID = 8; #ROWS

# TRUNCATE TABLE Books; #ALL ROWS

# DROP TABLE Books; #COMPLETE TABLE
#SFWGBHOBL
USE librarymanagementsystem;
SHOW TABLES;
SELECT * FROM Students;
SELECT * FROM Books;
SELECT * FROM Authors;
SELECT * FROM Categories;
SELECT * FROM BookAuthors;
SELECT * FROM Borrowings;




















 




















