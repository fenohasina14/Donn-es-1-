Create database magasin_en_ligne;

\c magasin_en_ligne;

create table  "user"(
    user_id serial primary key,
    first_name varchar NOT NULL,
    email varchar not null,
    last_name varchar NOT NULL
);

create table item(
    item_id serial primary key,
    item_name varchar NOT null,
    avalaibility varchar,
    price int
);

create table type(
    type_id serial primary key,
    type_name varchar
);

create table payment_type(
    payment_type_id serial primary key,
    payment_type_name varchar
);


create table "order"(
    order_id serial,
    ordered_items varchar,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    item_id serial references item(item_id),
    user_id serial references "user"(user_id),
    type_id serial references "type"(type_id),
    payment_type_id serial REFERENCES payment_type(payment_type_id)
);

-- INSERT FICTIVES

INSERT INTO "user" (first_name, last_name, email) VALUES 
('Rakoto', 'Ny Aina', 'rakoto.nyaina@example.com'),
('Alice', 'Smith', 'alice.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com'),
('David', 'Wilson', 'david.wilson@example.com');

INSERT INTO item (item_name, avalaibility, price) VALUES 
('Laptop', 'In Stock', 1000),
('Smartphone', 'In Stock', 700),
('Tablet', 'Out of Stock', 400),
('Monitor', 'In Stock', 200),
('Keyboard', 'In Stock', 50),
('Yogurt', 'In Stock', 1);

INSERT INTO type (type_name) VALUES 
('Electronics'),
('Furniture'),
('Clothing'),
('Books'),
('Toys'),
('Groceries');

INSERT INTO payment_type (payment_type_name) VALUES 
('MVola'),
('Airtel Money'),
('Cash'),
('Orange Money');

INSERT INTO "order" (ordered_items, item_id, user_id, type_id, payment_type_id) VALUES 
('5 Yogurts', 
(SELECT item_id FROM item WHERE item_name = 'Yogurt'), 
(SELECT user_id FROM "user" WHERE first_name = 'Rakoto' AND last_name = 'Ny Aina'), 
(SELECT type_id FROM type WHERE type_name = 'Groceries'),
(SELECT payment_type_id FROM payment_type WHERE payment_type_name = 'MVola'));

-- 3.a
SELECT COUNT(*) AS nombre_articles
FROM item;

-- 3.b
SELECT t.type_name, 
       MIN(i.price) AS prix_minimum, 
       MAX(i.price) AS prix_maximum
FROM item i
JOIN "order" o ON i.item_id = o.item_id
JOIN type t ON o.type_id = t.type_id
GROUP BY t.type_name;

-- 3.c
SELECT o.order_id, 
       o.ordered_items, 
       SUM(i.price) AS prix_total
FROM "order" o
JOIN item i ON o.item_id = i.item_id
JOIN "user" u ON o.user_id = u.user_id
WHERE u.first_name = 'Rakoto' AND u.last_name = 'Ny Aina'
GROUP BY o.order_id, o.ordered_items;

-- 3.d
SELECT i.item_name, 
       SUM(CAST(SPLIT_PART(o.ordered_items, ' ', 1) AS INTEGER)) AS quantite_totale
FROM "order" o
JOIN item i ON o.item_id = i.item_id
GROUP BY i.item_name
ORDER BY quantite_totale DESC;

-- 3.e
SELECT SUM(i.price) AS total_gagne
FROM "order" o
JOIN item i ON o.item_id = i.item_id
WHERE EXTRACT(YEAR FROM o.payment_date) = EXTRACT(YEAR FROM CURRENT_DATE);

-- STD23090, STD23027, STD23081, STD23046, STD23058
