DROP database IF EXISTS shop;
CREATE database shop;

USE shop;


DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id serial primary KEY,
    name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет магазина';

-- INSERT into catalogs values (null, 'Процессоры');
-- INSERT into catalogs (id, name) values (null, 'Мат. платы');

INSERT into catalogs values 
(default, 'Процессоры'),
(default, 'Мат. платы'),
(default, 'Видеокарты');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id serial primary KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp
) COMMENT = 'Покупатели';

INSERT INTO users(id, name, birthday_at) VALUES (1, 'hellow', '1979-01-27');
select * from users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id serial primary KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL (11, 2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp,
	KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

/*create index index_of_catalog_id USING BTREE ON products(catalog_id);
drop index index_of_catalog_id on products; */

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id serial primary KEY,
    user_id INT UNSIGNED,
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp,
    KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id serial primary KEY,
    order_id INT UNSIGNED,
    product_id INT UNSIGNED,
    total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id serial primary KEY,
    user_id INT UNSIGNED,
    product_id INT UNSIGNED,
    discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
    started_at datetime,
    finished_at datetime,
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp,
    KEY index_of_user_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id serial primary KEY,
    name VARCHAR(255) COMMENT 'Название',
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id serial primary KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    crated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 1, 10, NOW());
INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 2, 120, NOW());
INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 4, 140, NOW());
INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 5, 11, NOW());
INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 6, 2, NOW());
INSERT INTO storehouses_products (storehouse_id, product_id, value, crated_at) VALUES ( 1, 7, 0, NOW());
-- Third Task
 -- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля,
 -- если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 -- Однако нулевые запасы должны выводиться в конце, после всех 
 
 SELECT * FROM storehouses_products  ORDER BY value = 0, value ;
 
 
 
-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select u.id, u.name
from users as u
inner join orders as o
on u.id = o.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select p.id,
       p.name,
       p.description,
       catalogs.name as name_catalog
from products as p
left join catalogs 
on p.catalog_id = catalogs.id;
