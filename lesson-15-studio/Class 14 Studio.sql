CREATE TABLE book (
   book_id INT AUTO_INCREMENT PRIMARY KEY,
   author_id INT,
   title VARCHAR(255),
   isbn INT,
   available BOOL,
   genre_id INT
);

CREATE TABLE author (
   author_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   birthday DATE,
   deathday DATE
);

CREATE TABLE patron (
   patron_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   loan_id INT
);

CREATE TABLE reference_books (
   reference_id INT AUTO_INCREMENT PRIMARY KEY,
   edition INT,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

INSERT INTO reference_books(edition, book_id)
VALUE (5,32);

CREATE TABLE genre (
   genre_id INT PRIMARY KEY,
   genres VARCHAR(100)
);

CREATE TABLE loan (
   loan_id INT AUTO_INCREMENT PRIMARY KEY,
   patron_id INT,
   date_out DATE,
   date_in DATE,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

-- Return the mystery book titles and their ISBNs.
SELECT title, isbn FROM book
WHERE genre_id = (SELECT genre_id FROM genre WHERE genres = "Mystery");

-- Return all of the titles and author’s first and last names for books written by authors who are currently living.
SELECT book.title, author.first_name, author.last_name FROM book
INNER JOIN author ON book.author_id = author.author_id
WHERE author.deathday IS null;

-- CHECK OUT A BOOK
-- Change available to FALSE for the appropriate book.
UPDATE book
SET available = 0
WHERE book_id = 1;

SELECT * FROM book;

-- Add a new row to the loan table with today’s date as the date_out and the ids in the row matching the appropriate patron_id and book_id.
INSERT INTO loan (date_out, book_id, patron_id)
VALUES (CURRENT_DATE(), 1, 1); 

SELECT * FROM loan;

-- Update the appropriate patron with the loan_id for the new row created in the loan table.
UPDATE patron
SET loan_id = 1
WHERE patron_id = 1;

SELECT * FROM patron
WHERE patron_id = 1;


-- CHECK BOOK BACK IN
-- Change available to TRUE for the appropriate book.
UPDATE book
SET available = 1
WHERE book_id = 1;

SELECT * FROM book
WHERE book_id = 1;

-- Update the appropriate row in the loan table with today’s date as the date_in.
UPDATE loan
SET date_in = CURRENT_DATE
WHERE loan_id = 1;

SELECT * FROM loan
WHERE loan_id = 1;

-- Update the appropriate patron changing loan_id back to null.
UPDATE patron
SET loan_id = NULL
WHERE patron_id = 1;

SELECT * FROM patron
WHERE patron_id = 1;

-- Write a query to wrap up the studio. This query should return the names of the patrons with the genre of every book they currently have checked out.
SELECT patron.first_name, patron.last_name, genre.genres FROM patron
INNER JOIN loan ON patron.loan_id = loan.loan_id
INNER JOIN book ON loan.book_id = book.book_id
INNER JOIN genre ON book.genre_id = genre.genre_id;

-- BONUS MISSIONS
-- Return the counts of the books of each genre. Check out the documentation to see how this could be done!
SELECT genre.genres, COUNT(*) FROM book
INNER JOIN genre ON book.genre_id = genre.genre_id
GROUP BY book.genre_id
ORDER BY genre.genres ASC;
