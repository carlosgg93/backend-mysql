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

TOURNAMENTS
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
- id_welcome_pack

CATEGORIES
- id
- name (1a, 2a, 3a, 4a etc..)

TOURNAMENTS-CATEGORIES
- id
- tournament_id
- categories_id

USERS
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

PLAYERS
- id
- id_user
- position

MANAGERS
- id
- id_user
- id_club

TOURNAMENTS-PLAYERS
- id
- tournament_id
- player_id

CIRCUITS
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

WELCOME_PACK
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
    logo VARCHAR(255) NOT NULL,
    number_of_courts INT NOT NULL,
    web VARCHAR(100) NOT NULL,
    services VARCHAR(100) NOT NULL,
    schedules VARCHAR(100) NOT NULL,
    instagram VARCHAR(100) NOT NULL,
    facebook VARCHAR(100) NOT NULL,
    is_premium BOOLEAN NOT NULL,
    id_city INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_city) REFERENCES city(id)
);

CREATE TABLE IF NOT EXISTS welcome_pack (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
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

CREATE TABLE IF NOT EXISTS tournaments (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    initial_date DATE NOT NULL,
    final_date DATE NOT NULL,
    is_premium BOOLEAN NOT NULL,
    image VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    id_circuit INT NOT NULL,
    id_city INT NOT NULL,
    id_club INT NOT NULL,
    id_welcome_pack INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_circuit) REFERENCES circuit(id),
    FOREIGN KEY (id_city) REFERENCES city(id),
    FOREIGN KEY (id_club) REFERENCES club(id),
    FOREIGN KEY (id_welcome_pack) REFERENCES welcome_pack(id)
);

CREATE TABLE IF NOT EXISTS categories (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*create relation m-n table tournaments with caterogories*/
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
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    image VARCHAR(255) NOT NULL,
    id_genre INT NOT NULL,
    id_city INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_genre) REFERENCES genre(id),
    FOREIGN KEY (id_city) REFERENCES city(id)
);

CREATE TABLE IF NOT EXISTS players (
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    position VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS managers (
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_club INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_club) REFERENCES club(id)
    ON DELETE CASCADE
);

/*create relation m-n table tournaments with players*/
CREATE TABLE IF NOT EXISTS tournaments_players (
    id INT NOT NULL AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    player_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);

/*inserts*/

INSERT INTO country (name) VALUES ('Spain');
INSERT INTO country (name) VALUES ('France');
INSERT INTO country (name) VALUES ('Italy');
INSERT INTO country (name) VALUES ('Portugal');
INSERT INTO country (name) VALUES ('Andorra');
INSERT INTO country (name) VALUES ('Gibraltar');

INSERT INTO comunity (name, id_country) VALUES ('Andalucia', 1);
INSERT INTO comunity (name, id_country) VALUES ('Aragon', 1);
INSERT INTO comunity (name, id_country) VALUES ('Asturias', 1);
INSERT INTO comunity (name, id_country) VALUES ('Baleares', 1);
INSERT INTO comunity (name, id_country) VALUES ('Canarias', 1);
INSERT INTO comunity (name, id_country) VALUES ('Cantabria', 1);
INSERT INTO comunity (name, id_country) VALUES ('Castilla y Leon', 1);
INSERT INTO comunity (name, id_country) VALUES ('Castilla la Mancha', 1);
INSERT INTO comunity (name, id_country) VALUES ('Cataluña', 1);
INSERT INTO comunity (name, id_country) VALUES ('Extremadura', 1);
INSERT INTO comunity (name, id_country) VALUES ('Galicia', 1);
INSERT INTO comunity (name, id_country) VALUES ('La Rioja', 1);
INSERT INTO comunity (name, id_country) VALUES ('Madrid', 1);
INSERT INTO comunity (name, id_country) VALUES ('Murcia', 1);
INSERT INTO comunity (name, id_country) VALUES ('Navarra', 1);
INSERT INTO comunity (name, id_country) VALUES ('Pais Vasco', 1);
INSERT INTO comunity (name, id_country) VALUES ('Valencia', 1);


INSERT INTO province (name, id_comunity) VALUES ('Almeria', 1);
INSERT INTO province (name, id_comunity) VALUES ('Cadiz', 1);
INSERT INTO province (name, id_comunity) VALUES ('Cordoba', 1);
INSERT INTO province (name, id_comunity) VALUES ('Granada', 1);
INSERT INTO province (name, id_comunity) VALUES ('Huelva', 1);
INSERT INTO province (name, id_comunity) VALUES ('Jaen', 1);
INSERT INTO province (name, id_comunity) VALUES ('Malaga', 1);
INSERT INTO province (name, id_comunity) VALUES ('Sevilla', 1);
INSERT INTO province (name, id_comunity) VALUES ('Huesca', 2);
INSERT INTO province (name, id_comunity) VALUES ('Teruel', 2);
INSERT INTO province (name, id_comunity) VALUES ('Zaragoza', 2);
INSERT INTO province (name, id_comunity) VALUES ('Asturias', 3);
INSERT INTO province (name, id_comunity) VALUES ('Baleares', 4);
INSERT INTO province (name, id_comunity) VALUES ('Las Palmas', 5);
INSERT INTO province (name, id_comunity) VALUES ('Santa Cruz de Tenerife', 5);
INSERT INTO province (name, id_comunity) VALUES ('Cantabria', 6);
INSERT INTO province (name, id_comunity) VALUES ('Albacete', 8);
INSERT INTO province (name, id_comunity) VALUES ('Ciudad Real', 8);
INSERT INTO province (name, id_comunity) VALUES ('Cuenca', 8);
INSERT INTO province (name, id_comunity) VALUES ('Guadalajara', 8);
INSERT INTO province (name, id_comunity) VALUES ('Toledo', 8);
INSERT INTO province (name, id_comunity) VALUES ('Barcelona', 9);
INSERT INTO province (name, id_comunity) VALUES ('Girona', 9);
INSERT INTO province (name, id_comunity) VALUES ('Lleida', 9);
INSERT INTO province (name, id_comunity) VALUES ('Tarragona', 9);
INSERT INTO province (name, id_comunity) VALUES ('Badajoz', 10);
INSERT INTO province (name, id_comunity) VALUES ('Caceres', 10);
INSERT INTO province (name, id_comunity) VALUES ('A Coruña', 11);
INSERT INTO province (name, id_comunity) VALUES ('Lugo', 11);
INSERT INTO province (name, id_comunity) VALUES ('Ourense', 11);
INSERT INTO province (name, id_comunity) VALUES ('Pontevedra', 11);
INSERT INTO province (name, id_comunity) VALUES ('La Rioja', 12);
INSERT INTO province (name, id_comunity) VALUES ('Madrid', 13);
INSERT INTO province (name, id_comunity) VALUES ('Murcia', 14);
INSERT INTO province (name, id_comunity) VALUES ('Navarra', 15);
INSERT INTO province (name, id_comunity) VALUES ('Alava', 16);
INSERT INTO province (name, id_comunity) VALUES ('Guipuzcoa', 16);
INSERT INTO province (name, id_comunity) VALUES ('Vizcaya', 16);
INSERT INTO province (name, id_comunity) VALUES ('Alicante', 17);
INSERT INTO province (name, id_comunity) VALUES ('Castellon', 17);
INSERT INTO province (name, id_comunity) VALUES ('Valencia', 17);

INSERT INTO city (name, id_province) VALUES ('LHospitalet de Llobregat', 22);
INSERT INTO city (name, id_province) VALUES ('Cornella de Llobregat', 22);
INSERT INTO city (name, id_province) VALUES ('Esplugues de Llobregat', 22);
INSERT INTO city (name, id_province) VALUES ('Sant Feliu de Llobregat', 22);
INSERT INTO city (name, id_province) VALUES ('Sant Joan Despi', 22);
INSERT INTO city (name, id_province) VALUES ('Barcelona', 22);

INSERT INTO genre (type) VALUES ('Masculino');
INSERT INTO genre (type) VALUES ('Femenino');

INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Laieta ', 'info@laieta.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 4, 'https://www.clubpadelbarcelona.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Real Club de Polo', 'info@polo.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 4, 'https://www.clubpadelbarcelona.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Club de Padel La Salut', 'lasalut@gmail.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 4, 'https://www.clubpadelbarcelona.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Aurial Padel', 'info@aurial.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 4, 'https://www.clubpadelbarcelona.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 2);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Indoor Padel Hospitalet', 'info@indoorpadelhospitalet.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 4, 'https://www.clubpadelbarcelona.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 0, 1);

INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 1', 'Welcome Pack 1');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 2', 'Welcome Pack 2');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 3', 'Welcome Pack 3');

INSERT INTO circuit (name, description, phone, email, web, instagram, facebook) VALUES ('Circuit 1', 'Circuit 1', '934 56 78 90', 'info@circuit1.com', 'https://www.circuit1.com/', 'https://www.instagram.com/circuit1/', 'https://www.facebook.com/circuit1/');
INSERT INTO circuit (name, description, phone, email, web, instagram, facebook) VALUES ('Circuit 2', 'Circuit 2', '934 56 78 90', 'info@circiut2.com', 'https://www.circuit2.com/', 'https://www.instagram.com/circuit2/', 'https://www.facebook.com/circuit2/');
INSERT INTO circuit (name, description, phone, email, web, instagram, facebook) VALUES ('Circuit 3', 'Circuit 3', '934 56 78 90', 'info@circuit3.com', 'https://www.circuit3.com/', 'https://www.instagram.com/circuit3/', 'https://www.facebook.com/circuit3/');

INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcome_pack) VALUES ('Torneo 1', 'Torneo 1', '2021-01-01', '2021-01-02', 1, 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcome_pack) VALUES ('Torneo 2', 'Torneo 2', '2021-01-01', '2021-01-02', 1, 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcome_pack) VALUES ('Torneo 3', 'Torneo 3', '2021-01-01', '2021-01-02', 1, 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcome_pack) VALUES ('Torneo 4', 'Torneo 4', '2021-01-01', '2021-01-02', 1, 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcome_pack) VALUES ('Torneo 5', 'Torneo 5', '2021-01-01', '2021-01-02', 1, 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 10, 1, 1, 1, 1);

INSERT INTO categories (name) VALUES ('1a');
INSERT INTO categories (name) VALUES ('2a');
INSERT INTO categories (name) VALUES ('3a');
INSERT INTO categories (name) VALUES ('4a');

INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (1, 1);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (1, 2);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (1, 3);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (1, 4);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (2, 1);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (2, 2);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (3, 3);
INSERT INTO tournaments_categories (tournament_id, categories_id) VALUES (3, 4);

INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Carlos', 'Garcia', 30, '1990-01-01', 'cgarciagarcia1993@gmail.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 1);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 1', 'Player 1', 60, '1990-01-01', 'info@player1.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 2', 'Player 2', 60, '1990-01-01', 'info@player2.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 3', 'Player 3', 60, '1990-01-01', 'info@player3.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 4', 'Player 4', 60, '1990-01-01', 'info@player4.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 5', 'Player 5', 60, '1990-01-01', 'info@player5.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 6', 'Player 6', 60, '1990-01-01', 'info@player6.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 7', 'Player 7', 60, '1990-01-01', 'info@player7.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 8', 'Player 8', 60, '1990-01-01', 'info@player8.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 9', 'Player 9', 60, '1990-01-01', 'info@player9.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 10', 'Player 10', 60, '1990-01-01', 'info@player10.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 11', 'Player 11', 60, '1990-01-01', 'info@player11.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 12', 'Player 12', 60, '1990-01-01', 'info@player12.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 13', 'Player 13', 60, '1990-01-01', 'info@player13.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 14', 'Player 14', 60, '1990-01-01', 'info@player14.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 15', 'Player 15', 60, '1990-01-01', 'info@player15.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 16', 'Player 16', 60, '1990-01-01', 'info@player16.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 17', 'Player 17', 60, '1990-01-01', 'info@player17.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 18', 'Player 18', 60, '1990-01-01', 'info@player18.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 19', 'Player 19', 60, '1990-01-01', 'info@player19.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 20', 'Player 20', 60, '1990-01-01', 'info@player20.com','123456', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);

INSERT INTO players (id_user, position) VALUES (2, 'Drive');
INSERT INTO players (id_user, position) VALUES (3, 'Drive');
INSERT INTO players (id_user, position) VALUES (4, 'Drive');
INSERT INTO players (id_user, position) VALUES (5, 'Drive');
INSERT INTO players (id_user, position) VALUES (6, 'Drive');
INSERT INTO players (id_user, position) VALUES (7, 'Drive');
INSERT INTO players (id_user, position) VALUES (8, 'Drive');
INSERT INTO players (id_user, position) VALUES (9, 'Drive');
INSERT INTO players (id_user, position) VALUES (10, 'Drive');
INSERT INTO players (id_user, position) VALUES (11, 'Reves');
INSERT INTO players (id_user, position) VALUES (12, 'Reves');
INSERT INTO players (id_user, position) VALUES (13, 'Reves');
INSERT INTO players (id_user, position) VALUES (14, 'Reves');
INSERT INTO players (id_user, position) VALUES (15, 'Reves');
INSERT INTO players (id_user, position) VALUES (16, 'Reves');
INSERT INTO players (id_user, position) VALUES (17, 'Reves');
INSERT INTO players (id_user, position) VALUES (18, 'Reves');
INSERT INTO players (id_user, position) VALUES (19, 'Reves');
INSERT INTO players (id_user, position) VALUES (20, 'Reves');

INSERT INTO managers (id_user, id_club) VALUES (1, 1);

INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 2);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 3);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 4);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 5);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 6);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 7);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 8);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 9);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 10);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 11);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 12);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 13);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 14);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 15);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 16);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 17);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 18);
INSERT INTO tournaments_players (tournament_id, player_id) VALUES (1, 19);