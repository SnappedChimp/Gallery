USE art_gallery;

-- Завдання 1. 

SELECT DISTINCT country
FROM painter;

SELECT full_name, position_
FROM worker
LIMIT 3;

SELECT *
FROM exhibition 
LIMIT 2, 2;

SELECT name_visitor, email_visitor
FROM visitor 
WHERE phone_visitor IS NOT NULL;

-- Завдання 2.

SELECT name_picture 
FROM picture 
ORDER BY price_picture;


SELECT *
FROM ticket 
ORDER BY date_ticket, price_ticket DESC;

SELECT name_exhibition 
FROM exhibition 
ORDER BY start_date;


 -- Завдання 3. 

SELECT full_name, country
FROM painter
WHERE country IN ('Україна', 'Італія', 'Франція');


SELECT name_picture, price_picture 
FROM picture
WHERE price_picture BETWEEN 10000 AND 50000;

SELECT name_visitor, email_visitor 
FROM visitor 
WHERE email_visitor LIKE '%@gmail.com';

SELECT full_name, position_
FROM worker 
WHERE position_ REGEXP 'Екскурсовод|Охоронець';

SELECT *
FROM ticket 
WHERE price_ticket NOT BETWEEN 150 AND 200;

-- Завдання 4.

SELECT AVG(price_picture)
FROM picture 
WHERE creation_year > 1800;

SELECT MIN(price_ticket)
FROM ticket;

SELECT COUNT(name_picture)
FROM picture;

SELECT SUM(price_ticket)
FROM ticket;

SELECT MAX(price_picture)
FROM picture 
WHERE creation_year < 1900;

-- Завдання 5.

SELECT position_, COUNT(*) AS workers_amount
FROM worker
GROUP BY position_
HAVING COUNT(*) > 1;


SELECT id_exhibition, COUNT(*) AS total
FROM ticket
GROUP BY id_exhibition 
HAVING SUM(price_ticket) > 500;

SELECT id_painter, COUNT(*) AS expensive_pictures
FROM picture
WHERE price_picture > 10000
GROUP BY id_painter
HAVING COUNT(*) >= 2;

-- Завдання 6.

CREATE OR REPLACE VIEW expensive_pictures AS
SELECT name_picture, price_picture 
FROM picture
WHERE price_picture BETWEEN 10000 AND 50000;

CREATE OR REPLACE VIEW painters_stats AS
SELECT id_painter, COUNT(*) AS expensive_pictures
FROM picture
WHERE price_picture > 10000
GROUP BY id_painter
HAVING COUNT(*) >= 2;

