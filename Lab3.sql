DROP SCHEMA IF EXISTS art_gallery;
CREATE SCHEMA art_gallery;
USE art_gallery;

CREATE TABLE painter (
    id_painter INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(60) NOT NULL,
    country VARCHAR(60) NOT NULL,
    birth_date DATE NOT NULL

);

CREATE TABLE hall (
 id_hall INT AUTO_INCREMENT PRIMARY KEY, 
 name_ VARCHAR(50) NOT NULL,
 floor_ INT NOT NULL,
 capacity INT NOT NULL
);

CREATE TABLE worker (
    id_worker INT AUTO_INCREMENT PRIMARY KEY, 
    full_name VARCHAR(50) NOT NULL,
    position_ VARCHAR(50) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    id_hall INT NOT NULL
);

CREATE TABLE picture (
    id_picture INT AUTO_INCREMENT PRIMARY KEY,
    name_picture VARCHAR(50) NOT NULL,
    price_picture INT NOT NULL,
    creation_year SMALLINT NOT NULL,
    id_painter INT NOT NULL,
    id_exhibition INT NOT NULL 
);

CREATE TABLE exhibition (
    id_exhibition INT AUTO_INCREMENT PRIMARY KEY,
    name_exhibition VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    id_hall INT NOT NULL 

);

CREATE TABLE visitor (
    id_visitor INT AUTO_INCREMENT PRIMARY KEY,
    name_visitor VARCHAR(50) NOT NULL,
    email_visitor VARCHAR(50) NOT NULL,
    phone_visitor VARCHAR(30) NOT NULL
);

CREATE TABLE ticket (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY, 
    price_ticket INT NOT NULL,
    date_ticket DATETIME NOT NULL,
    id_exhibition INT NOT NULL, 
    id_visitor INT NOT NULL,
    id_worker INT NOT NULL
);

-- 1. Картина посилається на художника
ALTER TABLE picture
    ADD CONSTRAINT fk_picture_painter
    FOREIGN KEY (id_painter) REFERENCES painter(id_painter)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- 2. Картина посилається на виставку 
ALTER TABLE picture 
    ADD CONSTRAINT fk_picture_exhibition 
    FOREIGN KEY(id_exhibition) REFERENCES exhibition(id_exhibition)
    ON UPDATE CASCADE ON DELETE RESTRICT;
  
-- 3. Виставка посилається на зал 
ALTER TABLE exhibition
    ADD CONSTRAINT fk_exhibition_hall
    FOREIGN KEY (id_hall) REFERENCES hall(id_hall)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- 4. Квиток посилається на відвідувача
ALTER TABLE ticket 
    ADD CONSTRAINT fk_ticket_visitor
    FOREIGN KEY(id_visitor) REFERENCES visitor(id_visitor)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- 5. Працівник посилається на зал
ALTER TABLE worker 
    ADD CONSTRAINT fk_worker_hall
    FOREIGN KEY(id_hall) REFERENCES hall(id_hall)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- 6. Квиток посилається на виставку
ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_exhibition
    FOREIGN KEY (id_exhibition) REFERENCES exhibition(id_exhibition)
    ON UPDATE CASCADE ON DELETE RESTRICT;

-- 7. Квиток посилається на працівника
ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_worker
    FOREIGN KEY (id_worker) REFERENCES worker(id_worker)
    ON UPDATE CASCADE ON DELETE RESTRICT;
 

INSERT INTO painter (id_painter, full_name, country, birth_date) VALUES
(1, 'Тарас Шевченко', 'Україна', '1814-03-09'),
(2, 'Казимир Малевич', 'Україна', '1879-02-23'),
(3, 'Іван Марчук', 'Україна', '1936-05-12'),
(4, 'Марія Примаченко', 'Україна', '1909-01-12'),
(5, 'Клод Моне', 'Франція', '1840-11-14'),
(6, 'Вінсент ван Гог', 'Нідерланди', '1853-03-30'),
(7, 'Пабло Пікассо', 'Іспанія', '1881-10-25'),
(8, 'Сальвадор Далі', 'Іспанія', '1904-05-11'),
(9, 'Леонардо да Вінчі', 'Італія', '1452-04-15'),
(10, 'Густав Клімт', 'Австрія', '1862-07-14');


INSERT INTO hall (id_hall, name_, floor_, capacity) VALUES
(1, 'Зала Ренесансу', 1, 60),
(2, 'Зала Модерну', 1, 80),
(3, 'Авангардна зала', 2, 50),
(4, 'Барокова світлиця', 2, 45),
(5, 'Галерея Імпресіонізму', 2, 70),
(6, 'Центральний атріум', 1, 150),
(7, 'Зала Сюрреалізму', 3, 40),
(8, 'Камерна експозиція', 3, 30),
(9, 'Зала Графіки', 2, 55),
(10, 'Велика виставкова зала', 1, 120);

INSERT INTO visitor (id_visitor, name_visitor, email_visitor, phone_visitor) VALUES
(1, 'Андрій Мельник', 'andriy.melnyk@gmail.com', '0991110001'),
(2, 'Юлія Романюк', 'yulia.rom@ukr.net', '0982220002'),
(3, 'Олег Сидоренко', 'oleg.syd@gmail.com', '0673330003'),
(4, 'Ірина Бойко', 'iryna.boyko@meta.ua', '0504440004'),
(5, 'Максим Демчук', 'max.demchuk@gmail.com', '0935550005'),
(6, 'Христина Козак', 'khrystyna.k@ukr.net', '0686660006'),
(7, 'Денис Яворський', 'den.yavor@gmail.com', '0957770007'),
(8, 'Оксана Рудик', 'oxana.rudyk@gmail.com', '0978880008'),
(9, 'Володимир Кушнір', 'vlad.kushnir@ukr.net', '0639990009'),
(10, 'Тетяна Марченко', 'tanya.m@gmail.com', '0501234567');

INSERT INTO worker (id_worker, full_name, position_, phone, id_hall) VALUES
(1, 'Ковальчук Олена Іванівна', 'Куратор виставок', '0671112233', 1),
(2, 'Мельник Дмитро Сергійович', 'Екскурсовод', '0502223344', 2),
(3, 'Бондаренко Ольга Петрівна', 'Касир', '0633334455', 3),
(4, 'Шевченко Богдан Юрійович', 'Охоронець', '0974445566', 4),
(5, 'Ткаченко Анна Романівна', 'Адміністратор залів', '0665556677', 5),
(6, 'Кравченко Ігор Миколайович', 'Реставратор', '0936667788', 6),
(7, 'Мороз Наталія Василівна', 'Мистецтвознавець', '0987778899', 7),
(8, 'Лисенко Віктор Олегович', 'Менеджер квитків', '0508889900', 8),
(9, 'Савчук Марія Андріївна', 'Екскурсовод', '0679990011', 9),
(10, 'Павленко Сергій Володимирович', 'Головний хранитель', '0630001122', 10);

INSERT INTO exhibition (id_exhibition, name_exhibition, description, start_date, end_date, id_hall) VALUES
(1, 'Український Авангард', 'Експозиція класиків українського модерного мистецтва', '2026-01-15 10:00:00', '2026-03-15 18:00:00', 3),
(2, 'Магія Природи', 'Виставка пейзажів та наївного мистецтва', '2026-02-01 10:00:00', '2026-04-01 19:00:00', 5),
(3, 'Сни та Реалії', 'Шедеври світового сюрреалізму', '2026-03-10 11:00:00', '2026-05-20 20:00:00', 7),
(4, 'Епоха Відродження', 'Класичний живопис та анатомічні студії', '2026-04-01 09:00:00', '2026-06-30 18:00:00', 1),
(5, 'Золотий Вік', 'Золоті мотиви у портретному живописі', '2026-05-05 10:00:00', '2026-07-15 19:00:00', 2),
(6, 'Світло і Тінь', 'Імпресіоністичні етюди та відкриті простори', '2026-06-01 10:00:00', '2026-08-01 19:00:00', 4),
(7, 'Голос Землі', 'Ретроспектива народної творчості', '2026-07-10 10:00:00', '2026-09-10 18:00:00', 6),
(8, 'Кольорові Мелодії', 'Абстрактне мистецтво сьогодення', '2026-08-01 11:00:00', '2026-10-01 20:00:00', 8),
(9, 'Лінії Долі', 'Академічний малюнок та офорти', '2026-09-15 10:00:00', '2026-11-15 18:00:00', 9),
(10, 'Шедеври Води', 'Французький імпресіонізм у всій красі', '2026-10-01 10:00:00', '2026-12-31 18:00:00', 10);


INSERT INTO picture (id_picture, name_picture, price_picture, creation_year, id_painter, id_exhibition) VALUES
(1, 'Катерина', 150000, 1840, 1, 7),
(2, 'Чорний квадрат', 500000, 1915, 2, 1),
(3, 'Пробудження', 85000, 1992, 3, 8),
(4, 'Звірі в саду', 65000, 1978, 4, 2),
(5, 'Водяні лілії', 420000, 1916, 5, 10),
(6, 'Зоряна ніч', 750000, 1889, 6, 6),
(7, 'Герніка', 900000, 1937, 7, 9),
(8, 'Постійність пам’яті', 620000, 1931, 8, 3),
(9, 'Мона Ліза', 1200000, 1503, 9, 4),
(10, 'Поцілунок', 480000, 1908, 10, 5);


INSERT INTO ticket (id_ticket, price_ticket, date_ticket, id_exhibition, id_visitor, id_worker) VALUES
(1, 150, '2026-02-10 12:30:00', 1, 1, 3),
(2, 200, '2026-02-12 14:15:00', 2, 2, 3),
(3, 180, '2026-03-15 11:00:00', 3, 3, 8),
(4, 250, '2026-04-05 16:45:00', 4, 4, 8),
(5, 150, '2026-05-12 13:20:00', 5, 5, 3),
(6, 170, '2026-06-20 15:10:00', 6, 6, 8),
(7, 120, '2026-07-15 17:00:00', 7, 7, 3),
(8, 160, '2026-08-05 10:40:00', 8, 8, 8),
(9, 140, '2026-09-20 12:00:00', 9, 9, 3),
(10, 220, '2026-10-10 18:30:00', 10, 10, 8);





