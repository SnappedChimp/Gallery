USE art_gallery;

SET GLOBAL event_scheduler = ON;

-- Завдання 1.

 CREATE EVENT IF NOT EXISTS add_test_visitor
 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE 
 DO 
 	INSERT INTO visitor (name_visitor, email_visitor, phone_visitor)
 	VALUES ('Тестовий Відвідувач', 'test@gmail.com', '0000000000');
 
 CREATE EVENT IF NOT EXISTS update_hall_capacity
 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 MINUTE
 ON COMPLETION PRESERVE
 DO 
 	UPDATE hall SET capacity = capacity + 10 WHERE id_hall = 1;
 
CREATE EVENT IF NOT EXISTS recurring_visitor_insert
ON SCHEDULE EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO 
	INSERT INTO visitor (name_visitor, email_visitor, phone_visitor)
    VALUES ('Постійний гість', 'guest@gallery.com', '000-000-0000');

-- Завдання 2.

DELIMITER //

CREATE TRIGGER check_picture_price BEFORE INSERT 
ON picture FOR EACH ROW
BEGIN
    IF NEW.price_picture < 0 THEN
        SET NEW.price_picture = 0;
    END IF;
END //

DELIMITER ;

DELIMITER // 

CREATE TRIGGER check_hall_capacity BEFORE UPDATE
ON hall FOR EACH ROW
BEGIN
	IF NEW.capacity < 10 THEN
	SET NEW.capacity = 10;
	END IF;
END

DELIMITER ;

DELIMITER //

-- Завдання 3.

CREATE PROCEDURE get_painters()
BEGIN
    SELECT * FROM painter;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_exhibitions_by_hall(IN hall_id_param INT)
BEGIN 
    SELECT * FROM exhibition WHERE id_hall = hall_id_param;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_max_ticket_price(OUT max_price INT)
BEGIN 	
	SELECT MAX(price_ticket) INTO max_price FROM ticket;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION get_total_halls() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(id_hall) INTO total FROM hall;
    RETURN total;
END //
DELIMITER ;

DELIMITER // 
CREATE FUNCTION get_ticket_discount(price INT)
RETURNS FLOAT 
DETERMINISTIC
BEGIN 
	RETURN price * 0.9;
END

DELIMITER ;

-- Завдання 4.

START TRANSACTION;

UPDATE picture SET id_exhibition = 2 WHERE id_picture = 1;

SELECT name_picture, id_exhibition FROM picture WHERE id_picture = 1;

ROLLBACK;

SELECT name_picture, id_exhibition FROM picture WHERE id_picture = 1;


START TRANSACTION;

INSERT INTO ticket (price_ticket, date_ticket, id_exhibition, id_visitor, id_worker)
VALUES('100', '2026-10-21 18:30:00', '1', '2', '3');

COMMIT;

LOCK TABLES ticket WRITE; 

INSERT INTO ticket (price_ticket, date_ticket, id_exhibition, id_visitor, id_worker)
VALUES(200, NOW(), 1, 3, 3);

UNLOCK TABLES;

LOCK TABLES hall READ;
SELECT * FROM hall;
UNLOCK TABLES;

-- Завдання 5.

START TRANSACTION;


INSERT INTO hall (capacity) VALUES (50);


SAVEPOINT my_point1;


INSERT INTO hall (capacity) VALUES (100);

ROLLBACK TO my_point1;

COMMIT;


START TRANSACTION;

INSERT INTO worker (name_worker, position_worker) 
VALUES('Іван', 'Менеджер');

SAVEPOINT save_worker;

INSERT INTO worker(name_worker, position_worker)
VALUES('Михайло', 'Охоронець');

ROLLBACK TO save_worker;

COMMIT;


 



