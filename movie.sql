/*
  movie.sql
*/

DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS ratings;

CREATE TABLE movies (
  id char(3) PRIMARY KEY,
  name varchar(40) NOT NULL,
  year integer
  );
  
LOAD DATA INFILE 'c:/data/wk2_assign_movies.csv' 
INTO TABLE movies 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE ratings (
  person varchar(10) not null,
  id char(3) not null,
  rating varchar(4)
  );
  
LOAD DATA INFILE 'c:/data/wk2_assign_ratings.csv' 
INTO TABLE ratings 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(person, id, @rating)
SET
rating = nullif(@rating, '');

Update ratings 
SET rating = NULL where rating = 0;

SELECT m.name, avg(rating) FROM movies AS m
INNER JOIN ratings AS r
ON m.id = r.id
GROUP BY m.name;

SELECT m.name, m.year, r.person, r.rating AS output 
INTO OUTFILE 'c:/data/output4r.csv' 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
FROM movies AS m
INNER JOIN ratings AS r
ON m.id = r.id
ORDER BY m.name;