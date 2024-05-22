Create database reseaux_sociaux;

\ c reseaux_sociaux;

create table "user"(
    user_id serial primary key,
    first_name varchar NOT null,
    last_name varchar not null,
    age int NOT null,
    email varchar,
    number_of_post int,
    adress varchar,
    gender varchar check (gender in ('M', 'F', 'O'))
);

create table post(
    post_id serial primary key,
    hour_of_post TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    number_of_like int,
    number_of_comments int,
    "type" varchar check ("type" in ('Image', 'Video')),
    bio text,
    user_id serial references "user"(user_id)
);

-- Nous trouvons que la colonne « first_name » de la table « user » est souvent utilisée ;Proposez une solution pour améliorer 
-- les performances des requêtes SELECT qui manipulent cette colonne. Quelle instruction faut-il écrire ?

CREATE INDEX idx_first_name ON users (first_name);

-- Définir une VIEW qui affiche la liste des ”user” dans un tableau contenant les colonnes suivantes : nom, prénom, âge, e-mail, 
-- et le nombre de post posté

CREATE VIEW public_info as SELECT first_name, last_name, age, email, number_of_post from "user";

-- En utilisant cette “VIEW”, affichez la liste des utilisateurs qui ont moins de 20 ans qui ont déjà posté (nombre de post > 0).

SELECT * from public_info WHERE age < 20 AND number_of_post > 0;

-- Sans utiliser de “VIEW”, affichez la liste des utilisateurs qui ont moins de 20 ans qui ont déjà posté

SELECT first_name, last_name, age, email, number_of_post from "user" WHERE age < 20 AND number_of_post > 0;