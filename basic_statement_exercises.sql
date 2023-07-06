USE albums_db;
SELECT database();
SHOW TABLES;
DESCRIBE albums;
-- Primary key for the albums table is the "id"
SELECT name FROM albums;
-- the 'name' column is a string representing the name of the album i.e. Thriller, Back in Black...
SELECT sales FROM albums;
-- I think that the sales column is the total revinue for that album. It is a float data type.
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon & The Wall are all the albums by Pink Floyd
SELECT release_date FROM albums WHERE name LIKE '%Pepper%';
-- Sgt. Pepper's Lonely Hearts Club Band was release in 1967
SELECT genre FROM albums WHERE name = 'Nevermind';
-- Nevermind is in the Grunge, Alternative rock genre
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT name AS low_selling_albums FROM albums WHERE sales < 20;
