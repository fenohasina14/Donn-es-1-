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

create table "order"(
    order_id serial,
    ordered_items varchar,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    item_id serial references item(item_id),
    user_id serial references "user"(user_id),
    type_id serial references "type"(type_id)
);

create table payment_type(
    payment_type_id serial,
    payment_type_name varchar
);