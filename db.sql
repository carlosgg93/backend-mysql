/*
PADELHUB
padelhub.io

COLORS:
--color-secondary: #bf1660;
--color-light-pink: #ec5990;
--color-primary: #0e101c;
--color-blue: #1e2a4a;
--color-button-blue: #191d3a;
--color-light-blue: #516391;
--color-link: #ff7aa8;
--color-medium-blue: #4f6294;
--color-black: #2d2d2d;
--color-purple: #0f111b;
--color-grey: #333;
--color-light-grey: #ccc;

body #081229
navbar #191d3a
pink #ec5990
dark pink #bf1650
white
black
*/

/*Create new database padelhub with hist tables, inserts and his relations:

TOURNAMENT
- id
- title
- description
- initial_data
- final_data
- is_premium
- image
- price
- id_circuit
- id_city ??
- id_club
- id_welcomePack

CATEGORIES
- id
- name (1a, 2a, 3a, 4a etc..)

TOURNAMENT-CATEGORIES
- id
- tournament_id
- categories_id

USER
- id
- name
- surname
- age
- date_of_birth
- nationality
- email
- password
- phone
- image
- id_genre
- id_country
- id_city

PLAYER
- id
- id_user
- position

MANAGER
- id
- id_user
- id_club

TOURNAMENT-PLAYER
- id
- tournament_id
- player_id

CIRCUIT
- id
- name
- description
- phone
- email
- web
- instagram
- facebook 

CITY
- id
- name
- id_province

PROVINCE
- id
- name
- id_comunity

COMUNITY
- id
- name (Cataluña, Andalucia etc..)
- id_country

COUNTRY
- id
- name (Spain, France, Italy etc..)

GENRE
- id
- type

CLUB
- id
- name
- email
- phone
- direction
- type (indoor, outdoor)
- logo
- number_of_courts
- web
- services (idServices)
- schedules (idSchedules)
- instagram
- facebook
- is_premium
- id_city
- id_comunity

WELCOME PACK
- id
- name
- description

*/

DROP DATABASE IF EXISTS padelhub;
CREATE DATABASE padelhub;

USE padelhub;

CREATE TABLE IF NOT EXISTS country (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS comunity (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    id_country INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_country) REFERENCES country(id)
);

CREATE TABLE IF NOT EXISTS province (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    id_comunity INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_comunity) REFERENCES comunity(id)
);

CREATE TABLE IF NOT EXISTS city (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    id_province INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_province) REFERENCES province(id)
);

CREATE TABLE IF NOT EXISTS genre (
    id INT NOT NULL AUTO_INCREMENT,
    type VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS club (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    direction VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL,
    logo VARCHAR(100) NOT NULL,
    number_of_courts INT NOT NULL,
    web VARCHAR(100) NOT NULL,
    services VARCHAR(100) NOT NULL,
    schedules VARCHAR(100) NOT NULL,
    instagram VARCHAR(100) NOT NULL,
    facebook VARCHAR(100) NOT NULL,
    is_premium BOOLEAN NOT NULL,
    id_city INT NOT NULL,
    id_comunity INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_city) REFERENCES city(id),
    FOREIGN KEY (id_comunity) REFERENCES comunity(id)
);

CREATE TABLE IF NOT EXISTS welcomePack (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tournaments (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    initial_date DATE NOT NULL,
    final_date DATE NOT NULL,
    is_premium BOOLEAN NOT NULL,
    image VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    id_circuit INT NOT NULL,
    id_city INT NOT NULL,
    id_club INT NOT NULL,
    id_welcomePack INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_circuit) REFERENCES circuit(id),
    FOREIGN KEY (id_city) REFERENCES city(id),
    FOREIGN KEY (id_club) REFERENCES club(id),
    FOREIGN KEY (id_welcomePack) REFERENCES welcomePack(id)
);

CREATE TABLE IF NOT EXISTS categories (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*create relation m-n table tournament with caterogories*/
CREATE TABLE IF NOT EXISTS tournaments_categories (
    id INT NOT NULL AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    categories_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id),
    FOREIGN KEY (categories_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    date_of_birth DATE,
    nationality VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    image VARCHAR(100) NOT NULL,
    id_genre INT NOT NULL,
    id_country INT NOT NULL,
    id_city INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_genre) REFERENCES genre(id),
    FOREIGN KEY (id_country) REFERENCES country(id),
    FOREIGN KEY (id_city) REFERENCES city(id)
);

CREATE TABLE IF NOT EXISTS players (
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    position VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS managers (
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_club INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_club) REFERENCES club(id)
);

/*create relation m-n table tournament with player*/
CREATE TABLE IF NOT EXISTS tournament_player (
    id INT NOT NULL AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    player_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tournament_id) REFERENCES tournament(id),
    FOREIGN KEY (player_id) REFERENCES player(id)
);

CREATE TABLE IF NOT EXISTS circuit (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    web VARCHAR(100) NOT NULL,
    instagram VARCHAR(100) NOT NULL,
    facebook VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);