-- List just the titles of all the movies in the database.
SELECT title FROM movies;

-- List the title and year of each movie in the database in DESCENDING order of the year released. (Hint: Combine the SELECT command with the ORDER BY keywords).
SELECT title, year_released FROM movies
ORDER BY year_released DESC;

-- List all columns for all records of the directors table in ASCENDING alphabetical order based on the director’s country of origin.
SELECT * FROM directors
ORDER BY country ASC;

-- ORDER BY can also consider multiple columns. List all columns for all records of the directors table in ASCENDING alphabetical order first by the director’s country of origin and then by the director’s last name.
SELECT * FROM directors
ORDER BY country ASC, last_name ASC;

-- Insert a new record into the directors table for Rob Reiner, an American film director.
INSERT INTO directors (first_name, last_name, country)
VALUES ("Rob", "Renier", "USA");

-- Combine the SELECT and WHERE keywords to list the last_name and director_id for Rob Reiner.
SELECT last_name, director_id FROM directors
WHERE last_name = "Reiner";

-- Insert a new record into the movies table for The Princess Bride, which was released in 1987 and directed by Rob Reiner.
INSERT INTO movies (title, year_released, director_id)
VALUES ("The Princess Bride", 1987, 11);

-- If you list all of the data from the movies table (SELECT * FROM movies;), you will see a column of director ID numbers. This data is not particularly helpful to a user, since they probably want to see the director names instead. Use an INNER JOIN in your SQL command to display a list of movie titles, years released, and director last names.
SELECT movies.title, movies.year_released, directors.last_name FROM movies
INNER JOIN directors ON movies.director_id = directors.director_id;

-- List all the movies in the database along with the first and last name of the director. Order the list alphabetically by the director’s last name.
SELECT movies.title, directors.first_name, directors.last_name FROM movies
INNER JOIN directors ON movies.director_id = directors.director_id
ORDER BY directors.last_name ASC;

-- List the first and last name for the director of The Incredibles. You can do this with either a join or a WHERE command, but for this step please use WHERE.
SELECT directors.first_name, directors.last_name FROM directors
WHERE directors.director_id = (SELECT movies.director_id FROM movies WHERE title = "The Incredibles");

-- List the last name and country of origin for the director of Roma. You can do this with either a join or a WHERE command, but for this step please use a join.
SELECT directors.last_name, directors.country FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id
WHERE movies.title = "Roma";

-- Delete a row from the movies table. What consequence does this have on directors? List the contents of both tables to find out.
DELETE FROM movies WHERE movie_id = 8;

SELECT * FROM movies;

-- Try to delete one person from the directors table. What error results from trying to remove a director?
DELETE FROM directors WHERE director_id = 10;
-- Unable to delete since there is a foreign key in the movies table that references this director

