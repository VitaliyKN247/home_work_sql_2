CREATE DATABASE IF NOT EXISTS home_work_2;
USE home_work_2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `manufacturer` VARCHAR(45) NOT NULL,  -- производитель
    `product` VARCHAR(45) NOT NULL, -- продукт
    `count_product` INT, -- кол-во
    `price` INT   -- цена
);

-- 1. Создание и заполнение таблицы sales
INSERT INTO sales (manufacturer, product, count_product, price)
VALUES
	("BMW","1-series",154,12000),
	("BMW","3-series",12,18000),
	("Audi","A3",13,13000),
	("BMW","5-series",22,12000),
	("BMW","X5M",10,40000),
	("BMW","7-series",8,36000),
	("KIA","Rio",314,6000),
	("KIA","Rio-X",176,7000),
    ("Audi","Q5",140,13000);
    
SELECT manufacturer, product, count_product, price
FROM sales;
    

-- добавление столбца по общему кол-ву автомобилей

ALTER TABLE sales
ADD total_count INT DEFAULT 0;
SELECT  manufacturer, product, count_product, price
FROM sales;

-- получение кол-ва товара от каждого производителя
SELECT manufacturer, SUM(count_product) as total_count
FROM sales
GROUP BY manufacturer;

-- 2. Группировка значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT
	id,
    manufacturer,
    count_product,
CASE
	WHEN count_product < 100
		THEN "меньше 100"
	WHEN count_product <= 300
		THEN "100-300"
	ELSE "больше 300"
END AS total_count
FROM sales;

-- второй вариант
SELECT
    manufacturer,
    count_product,
    IF(count_product < 100, "меньше 100",
		IF(count_product <=300, "100-300", "больше 300"))
	AS "total_count"
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `customer` VARCHAR(45) NOT NULL, -- покупатель
    `phone` VARCHAR(15) NOT NULL,  -- номер телефона
    `email` VARCHAR(45),  -- электронная почта
    `order_status` INT -- статус заказа
);

INSERT INTO orders (customer, phone, email, order_status)
VALUES
	("RockStar","+79991457896","12@gmail.com", 1),
	("MailGroupp","+79996666666","mail@gmail.com",0),
	("GB","+79991400000","ooo@mail.com",2),
	("SBER","+79997777777","sber@mail.com",1),
	("SBER","+79997777777","sber@mail.com",NULL);
    
SELECT customer, phone, email
FROM orders;

SELECT 
	customer,
    order_status,
CASE
	WHEN order_status = 0
		THEN "not processed"
	WHEN order_status = 1
		THEN "in progress"
	WHEN order_status = 2
		THEN "ready for delivery"
	ELSE "order not created yet"
END AS "complete order status"
FROM orders;
    