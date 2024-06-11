

/*база от данни, свързана със салон за красота. Салонът си има мениджър и клиенти. В салона има работници.
 Има два вида работници масажисти и фризьори. Масажистите си имат определено ниво, от което зависят заплатите им,
 а за фризьорите е важен стажът. Студиото предлага определени услуги. Те си имат име,цена, описание.
 Да може да се прави справка за всички предлагани услуги и да се извеждат работниците,
 които извършват съответните услугите.Допълнете таблиците с необходима информация по ваш избор. */
 
 
CREATE DATABASE salon; 
USE salon;
 CREATE TABLE Manager (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) NOT NULL,
  phone VARCHAR (20) NULL DEFAULT NULL,
  email VARCHAR (255) NULL DEFAULT NULL
);

CREATE TABLE Workers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) NOT NULL,
  phone_w VARCHAR (20) NULL DEFAULT NULL,
  email_w VARCHAR (255) NULL DEFAULT NULL,
  position ENUM ('masseur', 'hairdresser'),
  level INT,  
  experience  INT,
  salary DECIMAL (10,2) NOT NULL,
  manager_id INT,
  CONSTRAINT FOREIGN KEY (manager_id) REFERENCES manager(id)
);

CREATE TABLE services (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (255) NOT NULL,
price DECIMAL (10,2) NOT NULL,
description TEXT NOT NULL
);

CREATE TABLE  workers_services (
workers_id INT NOT NULL,
services_id INT NOT NULL,
constraint foreign key (workers_id) REFERENCES workers(id),
CONSTRAINT FOREIGN KEY (services_id) REFERENCES services(id),
PRIMARY KEY (workers_id,services_id)
);

CREATE TABLE custumers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(10) NOT NULL,
  email VARCHAR(255),
  gender ENUM('male', 'female')
  );

CREATE TABLE custumers_services (
  custumers_id INT ,
  services_id INT ,
  CONSTRAINT foreign key  (custumers_id) REFERENCES custumers (id),
  CONSTRAINT  FOREIGN KEY (services_id) REFERENCES services (id),
  PRIMARY KEY (custumers_id, services_id)
  );

INSERT INTO Manager (name, phone, email) VALUES
('John Smith', '555-1234', 'john@abv.bg'),
('Jane Doe', '555-5678', 'jane@abv.bg'),
('Michael Johnson', '555-2468', 'michael@abv.bg');

INSERT INTO Workers (name, phone_w, email_w, position, level, salary, manager_id) VALUES 
('Иван Иванов', '0899123456', 'ivan@abv.bg', 'masseur', 3, 3000.00, 1),
('Петър Петров', '0888123456', 'petar@abv.bg', 'hairdresser', 2, 2500.00, 2),
('Георги Георгиев', '0877123456', 'georgi@abv.bg', 'masseur', 1, 2000.00, 2),
('Мария Маринова', '0895123456', 'maria@abv.bg', 'hairdresser', 3, 3000.00, 2),
('Стоян Стоянов', '0886111111', 'stoyan@abv.bg', 'masseur', 2, 2500.00, 1),
('Ангел Ангелов', '0896111111', 'angel@abv.bg', 'hairdresser', 1, 2000.00, 3);

INSERT INTO services (name, price, description) VALUES
('Стрижка', 30.00, 'Стрижка на косата от професионален фризьор.'),
('Боядисване', 50.00, 'Боядисване на косата с професионални продукти.'),
('Масаж на гръб', 40.00, 'Релаксиращ масаж на гръб с ароматерапия.'),
('Масаж на цяло тяло', 80.00, 'Релаксиращ масаж на цяло тяло с ароматерапия и масло от лавандула.'),
('Пилинг на тяло', 60.00, 'Почистване на кожата на тялото и премахване на мъртвите клетки.'),
('Фризьорски услуги за мъже', 25.00, 'Стрижка, миене и подстригване на брада.'),
('Фризьорски услуги за жени', 50.00, 'Подстригване и оформяне на косата, миене и изсушаване.');

INSERT INTO custumers (name, phone, email, gender) 
VALUES 
  ('Иван Иванов', '0888123456', 'ivan@abv.bg', 'male'),
  ('Петър Петров', '0899123456', 'petar@abv.bg', 'male'),
  ('Гергана Георгиева', '0877123456', 'gergana@abv.bg', 'female'),
  ('Мария Маринова', '0895123456', 'maria@abv.bg', 'female'),
  ('Стоян Стоянов', '0886111111', 'stoyan@abv.bg', 'male'),
  ('Ангел Ангелов', '0896111111', 'angel@abv.bg', 'male');

INSERT INTO workers_services (workers_id, services_id) VALUES (1, 1);
INSERT INTO workers_services (workers_id, services_id) VALUES (1, 2);
INSERT INTO workers_services (workers_id, services_id) VALUES (2, 3);
INSERT INTO workers_services (workers_id, services_id) VALUES (2, 4);
INSERT INTO workers_services (workers_id, services_id) VALUES (3, 1);

/*заявка,  която демонстрира SELECT с ограничаващо условие. */

SELECT *
FROM custumers
WHERE gender = 'male';

/*заявка,  която използва агрегатна функция и GROUP BY
Тази заявка използва функцията SUM (),
 за да намери общата сума на всички услуги,
 който са били представени от всеки масажист.
 Резултатите са групирани по име на масажиста,
което се прави чрез оператора GROUP BY.*/

SELECT Workers.name as masseur_name, SUM(services.price) as total_services_price
FROM Workers
INNER JOIN workers_services ON Workers.id= workers_services.workers_id
INNER JOIN services ON workers_services.services_id= services.id
WHERE Workers.position= 'masseur'
GROUP BY masseur_name;

/*заявка,  която демонстрирате INNER JOIN.
Тази заявка обединява таблиците Работници,
 работници_услуги и резултатите,
 така че да включват само работници с позиция „фризьор
услуги заедно и избира името на работника, 
името на услугата и цената на услугата за всички фризьори.
 Клаузата INNER JOIN се използва за свързване на таблиците
 въз основа на техните съответни взаимоотношения на външен ключ и
 първичен ключ. Клаузата WHERE се използва за филтриране“. */
 
 SELECT Workers.name,services.name,services.price
 FROM Workers
 INNER JOIN workers_services
 ON Workers.id = workers_services.workers_id
 INNER JOIN services
 ON services.id = workers_services.services_id
 WHERE Workers.position = 'hairdresser';
 
 /*заявка, която демонстрирате OUTER JOIN.
 В тази заявка се избират всички работници (Workers)
 и техните мениджъри(Managers) като 
 ако има работник без мениджър тогава на мястото
 на мениджър се вписва NULL */
 
 SELECT Workers.name,Manager.name AS manager_name
 FROM Workers
 LEFT OUTER JOIN Manager ON Workers.manager_id=Manager.id;
 
 /* Вложен селект
 Тази заявка избира имената и заплатите на всички работници
 с ниво по-голямо от 2 и с заплата по-висока от средната заплата
 на работниците с ниво по-голямо от 2.
 Вложената заявка изчислява средната заплата на тези работници.*/
 
 SELECT name,salary
 FROM workers
 WHERE level > 2 AND salary > (
 SELECT AVG (salary)
 FROM workers
 WHERE level >2
 );
 
 /* JOIN и агрегатна функция.
 Тази заявка ще извлече имената на всички работници 
 и броя на услугите, които те предлагат. Тя използва INNER JOIN,
 за да свърже таблицата workers с таблицата workers_services 
 по идентификатора на работника,
 и след това използва COUNT, за да брои редовете
 в таблицата workers_services за всеки работник.
 GROUP BY се използва, 
 за да групира резултатите по работник. */
 
 SELECT w.name, COUNT(ws.services_id) as num_services
 FROM workers w
 JOIN workers_services ws ON w.id= ws.workers_id
 GROUP BY w.id;
 
 /* тригер
 Този тригер се изпълнява преди вмъкването на нов ред в таблицата
 Workers и изчислява нивото на работника в зависимост от годините му
 на опит, записани в полето years_of_experience.
 Резултатът се записва в полето worker_level.*/
 
 
DELIMITER //

CREATE TRIGGER insert_worker_level
BEFORE INSERT ON Workers
FOR EACH ROW
BEGIN
    DECLARE level INT;
    IF NEW.years_of_experience < 5 THEN
        SET level = 1;
    ELSEIF NEW.years_of_experience >= 5 AND NEW.years_of_experience < 10 THEN
        SET level = 2;
    ELSE
        SET level = 3;
    END IF;
    SET NEW.worker_level = level;
END;
//

DELIMITER ;

  /*ALTER TABLE Workers ADD COLUMN years_of_experience INT;
ALTER TABLE Workers ADD COLUMN worker_level INT;*/


/* процедура,  която демонстрира използване на курсор
използването на курсор в процедура, която ще извлича информация 
за всички работници  в таблицата workers.: */

DELIMITER //

CREATE PROCEDURE `get_workers`()
BEGIN
  DECLARE done INT;
  DECLARE workers_id INT;
  DECLARE workers_name VARCHAR(255);
  DECLARE workers_salary DECIMAL(10,2);
  
  DECLARE cur CURSOR FOR SELECT  workers.id, workers.name, workers.salary FROM workers;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  set done = 0;
  OPEN cur;
  
  read_loop: while (done=0)
	do
    FETCH cur INTO workers_id, workers_name, workers_salary;
    IF (done=1) THEN
      LEAVE read_loop;
    END IF;
    
    SELECT CONCAT('Worker ID: ', workers_id, ', Name: ', workers_name, ', Salary: ', workers_salary) AS worker_info;
  END while;
  
  CLOSE cur;
END //

DELIMITER ;

CALL get_workers();




 
 
 
 
 



