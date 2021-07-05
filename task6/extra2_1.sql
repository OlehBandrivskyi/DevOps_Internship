CREATE TABLE `Internship`.`Students` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Student` VARCHAR(45) NULL,
    `StudentId` INT NOT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE INDEX `ID_UNIQUE` (`StudentId` ASC))
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8;


CREATE TABLE `Internship`.`Result` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `StudentId` INT NOT NULL,
    `Task1` VARCHAR(45) NULL,
    `Task2` VARCHAR(45) NULL,
    `Task3` VARCHAR(45) NULL,
    `Task4` VARCHAR(45) NULL,
    PRIMARY KEY (`ID`),
    UNIQUE INDEX `ID_UNIQUE` (`StudentId` ASC));


INSERT INTO `Internship`.`Students` (`Student`, `StudentId`)
VALUES ('Винник', '1'),
    ('Рекун', '2'),
    ('Бандрівський', '3'),
    ('Бурдыко', '4'),
    ('Марков', '5'),
    ('Войтух', '7'),
    ('Мошна', '8'),
    ('Козловский', '9'),
    ('Еленский', '10'),
    ('Зинченко', '11'),
    ('Костюков', '14'),
    ('Лактюшин', '16'),
    ('Лопаев', '18'),
    ('Мостыка', '19'),
    ('Новогродский', '20'),
    ('Сазонова', '21'),
    ('Соловей', '22'),
    ('Фортунатов', '23'),
    ('Хоменко', '24'),
    ('Шутов', '26'),
    ('Щербина', '27');

INSERT INTO `Internship`.`Result` (`StudentId`, `Task1`, `Task2`, `Task3`, `Task4`) 
VALUES ('1', 'done', 'done+', 'done+', 'done+'),
    ('2', 'done+', 'done+', 'done+', 'done+'),
    ('3', 'done', 'done+', 'done+', 'done+'),
    ('4', 'done+', 'done+', 'done', 'done'),
    ('5', 'done', 'done', 'done', 'done'),
    ('7', 'done+', 'done+', 'done+', 'done+'),
    ('8', 'done', 'not completed', 'done', 'done'),
    ('9', 'done', 'done+', 'done', 'done'),
    ('10', 'done+', 'done+', 'done+', 'done'),
    ('11', 'done', 'done', 'done', 'done'),
    ('14', 'done', 'done+', 'done+', 'done+'),
    ('16', 'done', 'done+', 'done', 'done'),
    ('18', 'done', 'done+', 'done+', 'done+'),
    ('19', 'done', 'done+', 'done+', 'done+'),
    ('20', 'done', 'done+', 'done+', 'done+'),
    ('21', 'done+', 'done+', 'done+', 'done+'),
    ('22', 'done+', 'done+', 'done+', 'done+'),
    ('23', 'done', 'done', 'done+', 'done+'),
    ('24', 'done', 'done', 'done', 'done'),
    ('26', 'done', 'done+', 'done+', 'done+'),
    ('27', 'done+', 'done+', 'done+', 'done+');