/* если не удалить ограничения FK, то будет возбуждена ошибка удаления таблиц*/
-- ALTER TABLE book
-- DROP FOREIGN KEY book_ibfk_1, 
-- DROP FOREIGN KEY book_ibfk_2;
/* Если имена FK не задавались через CONSTRAINT, то их SQL имена для запроса нужно смотреть через команду SHOW CREATE TABLE book; */
-- ALTER TABLE `client`
-- DROP FOREIGN KEY client_ibfk_1;

-- ALTER TABLE buy
-- DROP FOREIGN KEY buy_ibfk_1;

-- ALTER TABLE buy_step
-- DROP FOREIGN KEY buy_step_ibfk_1, 
-- DROP FOREIGN KEY buy_step_ibfk_2;

/* reset author */
DROP TABLE IF EXISTS author;
CREATE TABLE IF NOT EXISTS author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.'),
       ('Лермонтов М.Ю.');

/* reset genre */
DROP TABLE IF EXISTS genre;
CREATE TABLE IF NOT EXISTS genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

INSERT INTO genre (name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

/* reset book */
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8, 2),
    amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL
);

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES  ('Мастер и Маргарита', 1, 1, 670.99, 3),
        ('Белая гвардия ', 1, 1, 540.50, 5),
        ('Идиот', 2, 1, 460.00, 10),
        ('Братья Карамазовы', 2, 1, 799.01, 2),
        ('Игрок', 2, 1, 480.50, 10),
        ('Стихотворения и поэмы', 3, 2, 650.00, 15),
        ('Черный человек', 3, 2, 570.20, 6),
        ('Лирика', 4, 2, 518.99, 2);

/* reset city */
DROP TABLE IF EXISTS city;
CREATE TABLE IF NOT EXISTS city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30),
    days_delivery INT
);

INSERT INTO city (name_city, days_delivery)
VALUES ('Москва', 5),
       ('Санкт-Петербург', 3),
       ('Владивосток', 12);

/* reset client */
DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    name_client VARCHAR(50),
    city_id INT,
    email VARCHAR(30),
    FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE SET NULL
);

INSERT INTO `client` (name_client, city_id, email)
VALUES ('Баранов Павел', 3, 'baranov@test'),
       ('Абрамова Катя', 1, 'abramova@test'),
       ('Семенонов Иван', 2, 'semenov@test'),
       ('Яковлева Галина', 1, 'yakovleva@test');

/* reset buy */
DROP TABLE IF EXISTS buy;
CREATE TABLE IF NOT EXISTS buy (
    buy_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_description VARCHAR(100),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES `client` (client_id) ON DELETE CASCADE
);

INSERT INTO buy (buy_description, client_id)
VALUES ('Доставка только вечером', 1),
       (NULL, 3),
       ('Упаковать каждую книгу по отдельности', 2),
       (NULL, 1);

/* reset buy_book */
DROP TABLE IF EXISTS buy_book;
CREATE TABLE IF NOT EXISTS buy_book (
    buy_book_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    book_id INT,
    amount INT,
    FOREIGN KEY (buy_id) REFERENCES buy (buy_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE
);

INSERT INTO buy_book (buy_id, book_id, amount)
VALUES (1, 1, 1),
       (1, 7, 2),
       (1, 3, 1),
       (2, 8, 2),
       (3, 3, 2),
       (3, 2, 1),
       (3, 1, 1),
       (4, 5, 1);

/* reset step */
DROP TABLE IF EXISTS step;
CREATE TABLE IF NOT EXISTS step (
    step_id INT PRIMARY KEY AUTO_INCREMENT,
    name_step VARCHAR(30)
);

INSERT INTO step (name_step)
VALUES ('Оплата'),
       ('Упаковка'),
       ('Транспортировка'),
       ('Доставка');

/* reset buy_step */
DROP TABLE IF EXISTS buy_step;
CREATE TABLE IF NOT EXISTS buy_step (
    buy_step_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    step_id INT,
    date_step_beg DATE,
    date_step_end DATE,
    FOREIGN KEY (buy_id) REFERENCES buy (buy_id) ON DELETE CASCADE,
    FOREIGN KEY (step_id) REFERENCES step (step_id) ON DELETE SET NULL
);

INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
VALUES (1, 1, '2020-02-20', '2020-02-20'),
       (1, 2, '2020-02-20', '2020-02-21'),
       (1, 3, '2020-02-22', '2020-03-07'),
       (1, 4, '2020-03-08', '2020-03-08'),
       (2, 1, '2020-02-28', '2020-02-28'),
       (2, 2, '2020-02-29', '2020-03-01'),
       (2, 3, '2020-03-02', NULL),
       (2, 4, NULL, NULL),
       (3, 1, '2020-03-05', '2020-03-05'),
       (3, 2, '2020-03-05', '2020-03-06'),
       (3, 3, '2020-03-06', '2020-03-10'),
       (3, 4, '2020-03-11', NULL),
       (4, 1, '2020-03-20', NULL),
       (4, 2, NULL, NULL),
       (4, 3, NULL, NULL),
       (4, 4, NULL, NULL);
    
SELECT * FROM author;
SELECT * FROM genre;
SELECT * FROM book;
SELECT * FROM city;
SELECT * FROM `client`;
SELECT * FROM buy;
SELECT * FROM buy_book;
SELECT * FROM step;
SELECT * FROM buy_step;