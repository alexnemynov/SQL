/* если не удалить ограничения FK, то будет возбуждена ошибка удаления таблиц*/
ALTER TABLE book
DROP FOREIGN KEY book_ibfk_1, 
DROP FOREIGN KEY book_ibfk_2;
/* Если имена FK не задавались через CONSTRAINT, то их SQL имена для запроса нужно смотреть через команду SHOW CREATE TABLE book; */

/* reset author */

DROP TABLE IF EXISTS author;
CREATE TABLE IF NOT EXISTS author (
      author_id INT PRIMARY KEY AUTO_INCREMENT, 
      name_author VARCHAR(50) 
      );
INSERT INTO author (name_author) VALUES
('Булгаков М.А.'),
('Достоевский Ф.М.'),
('Есенин С.А.'),
('Пастернак Б.Л.'),
('Лермонтов М.Ю.');

/* reset genre */

DROP TABLE IF EXISTS genre;
CREATE TABLE IF NOT EXISTS genre (
      genre_id INT PRIMARY KEY AUTO_INCREMENT, 
      name_genre VARCHAR(50) 
      );
INSERT INTO genre (name_genre) VALUES
('Роман'),
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
INSERT INTO book (title, author_id, genre_id, price, amount) VALUES
("Мастер и Маргарита", 1, 1, 670.99, 3),
("Белая гвардия", 1, 1, 540.50, 5),
("Идиот", 2, 1, 460.00, 10),
("Братья Карамазовы", 2, 1, 799.01, 3),
("Игрок", 2, 1, 480.50, 10),
("Стихотворения и поэмы", 3, 2, 650.00, 15),
("Черный человек", 3, 2, 570.20, 6),
("Лирика", 4, 2, 518.99, 2);

/* reset supply */

DROP TABLE IF EXISTS supply;
CREATE TABLE IF NOT EXISTS supply (
  supply_id INT AUTO_INCREMENT,
  title VARCHAR(50),
  `author` VARCHAR(30),
  price DECIMAL(8,2),
  amount INT(11) ,
  PRIMARY KEY (supply_id)
);

INSERT INTO supply (title, `author`, price, amount) VALUES
    ("Доктор Живаго", "Пастернак Б.Л.", 380.80, 4),    
    ('Черный человек', 'Есенин С.А.', 570.20, 6),
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    ('Идиот', 'Достоевский Ф.М.', 360.80, 3),
    ("Стихотворения и поэмы", "Лермонтов М.Ю.", 255.90, 4),
    ("Остров сокровищ","Стивенсон Р.Л.", 599.99, 5);
    
SELECT * FROM author;
SELECT * FROM genre;
SELECT * FROM book;
SELECT * FROM supply;