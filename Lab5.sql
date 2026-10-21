USE art_gallery;

-- Завдання 1.
SELECT name_picture, price_picture
FROM picture 
WHERE price_picture > (SELECT AVG(price_picture) FROM picture);

SELECT p1.name_picture, p1.id_painter, p1.price_picture
FROM picture AS p1
WHERE p1.price_picture > (SELECT AVG(p2.price_picture)
FROM picture AS p2 
WHERE p1.id_painter = p2.id_painter);

SELECT name_visitor 
FROM visitor 
WHERE id_visitor IN (SELECT price_ticket FROM ticket);

SELECT name_exhibition, (SELECT COUNT(*) FROM ticket WHERE ticket.id_exhibition = exhibition.id_exhibition) AS ticket_sold
FROM  exhibition;
	
SELECT name_
FROM hall 
WHERE EXISTS (SELECT name_exhibition FROM exhibition WHERE exhibition.id_hall = hall.id_hall );

-- Завдання 2. 

SELECT hall.name_, worker.full_name
FROM hall
LEFT JOIN worker ON hall.id_hall = worker.id_hall;

SELECT visitor.name_visitor, exhibition.name_exhibition, ticket.price_ticket
FROM ticket
JOIN visitor ON ticket.id_visitor = visitor.id_visitor
JOIN exhibition ON ticket.id_exhibition = exhibition.id_exhibition;
 
-- Завдання 3.

SELECT name_, capacity,
CASE 
	WHEN capacity >= 100
		THEN 'Велика зала'
	WHEN capacity >= 50
		THEN 'Середня зала'
	ELSE 'Мала зала'
END AS hall_size
FROM hall;
	
SELECT id_exhibition, COUNT(id_ticket) AS ticket_count,
CASE 
	WHEN  COUNT(id_ticket) > 1
		THEN 'Популярна'
	ELSE 'Звичайна'
END AS popularity 
FROM ticket 
GROUP BY id_exhibition;

SELECT full_name, position_,
CASE 
	WHEN position_ = 'Екскурсовод'
		THEN 'Робота з клієнтами'
	WHEN position_ = 'Касир'
		THEN 'Фінанси'
	ELSE 'Адміністрація'
END AS role_type
FROM worker;

-- Завдання 4.

SElECT full_name AS person_name 
FROM painter 
UNION
SELECT name_visitor
FROM visitor;

SELECT full_name AS worker_name
FROM worker 
INTERSECT 
SELECT name_visitor 
FROM visitor;

SELECT id_hall 
FROM hall
EXCEPT 
SELECT id_hall FROM exhibition;

 -- Завдання 5.

ALTER TABLE picture_archive
PARTITION BY HASH(id_picture) PARTITIONS 4;

ALTER TABLE worker_bonus
PARTITION BY RANGE (bonus_amount) (
    PARTITION p0 VALUES LESS THAN (1000),
    PARTITION p1 VALUES LESS THAN (5000),
    PARTITION p2 VALUES LESS THAN (MAXVALUE)
);

ALTER TABLE hall_region
PARTITION BY LIST (region_id) (
    PARTITION west_branch VALUES IN (1, 2, 3),
    PARTITION east_branch VALUES IN (4, 5, 6)
);










	
