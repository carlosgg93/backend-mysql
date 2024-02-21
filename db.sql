/*
PADELHUB
padelhub.io
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


-- MYSQL
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
    logo VARCHAR(255) NOT NULL,
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
    id_club INT NOT NULL,
    id_welcome_pack INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_circuit) REFERENCES circuit(id),
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
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE,
    FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE
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
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS managers (
    id INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_club INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (id_club) REFERENCES club(id) ON DELETE CASCADE
    
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

INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Laieta ', 'info@laieta.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://laieta.cat/wp-content/uploads/2022/05/logolaieta150.png', 4, 'https://laieta.cat/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Real Club de Polo', 'info@polo.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://rcpolo.com/sfiles/img/logo.png', 4, 'https://rcpolo.com/es', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Club de Padel La Salut', 'lasalut@gmail.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://ctlasalut.com/wp-content/uploads/2021/11/cropped-ctlasalut_logo-1.png', 4, 'https://ctlasalut.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Aurial Padel', 'info@aurial.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.aurialpadel.com/assets/aurial_logo-ac2b7f2af6cf5c21d60908d42ec38e7052d85cbfa39e2d080f9b669fe07c3254.png', 4, 'https://www.aurialpadel.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 1, 2);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Indoor Padel Hospitalet', 'info@indoorpadelhospitalet.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Indoor', 'https://www.padelindoorhospitalet.com/PadelIndoorHospitaletNueva/img/logo.png', 4, 'https://www.padelindoorhospitalet.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', 0, 1);

INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 1', 'Paletilla de Jamon');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 2', 'Surtido de caldos aneto');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 3', 'Agua, Barrita Energetica y Cerveza');

INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Publidep', 'Circuito Padel Barcelona', 'https://www.publidep.com/wp-content/uploads/2022/10/Logos_publidep.svg', '690 39 45 78', 'info@publidep.com', 'https://www.publidep.com/', 'https://www.instagram.com/circuit1/', 'https://www.facebook.com/circuit1/');
INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Barcelona Padel Tour', 'Circuito Padel Barcelona', 'https://barcelonapadeltour.com/wp-content/uploads/2018/12/cropped-logo-bpt-ok3.png', '663945880', 'ejackson@barcelonapadeltour.com', 'https://barcelonapadeltour.com/', 'https://www.instagram.com/circuit2/', 'https://www.facebook.com/circuit2/');
INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Open Padel Series (OPS)', 'Circuito Padel Barcelona', 'https://www.opensportseries.com/media/7/7b/7b5/7b5dbf2712ded549191685c4a5a292ed_1659106220.png', '934 56 78 90', 'info@opensportseries.com', 'https://www.opensportseries.com/', 'https://www.instagram.com/circuit3/', 'https://www.facebook.com/circuit3/');

INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('I PRUEBA EN EL ARTÓS SPORTS CLUB', 'Primer torneo del año del Circuito Publidep by TQ Investments en el Artós Sports Club', '2021-01-01', '2021-01-02', 1, 'https://www.publidep.com/wp-content/uploads/2024/01/artos-1.jpg', 35, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('1º torneo Barcelona Padel Tour Xpress by NACEX 2024', '1er torneo by barcelona padel tour', '2021-01-01', '2021-01-02', 0, 'https://barcelonapadeltour.com/wp-content/uploads/2024/01/cartel-A4-1torneo24-sin-pronto-pago-copia-724x1024.jpg', 25, 2, 2, 2);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('IV PRUEBA EN LA MORALEJA SPORTS CLUB', 'Cuarto torneo del año del Circuito Publidep by TQ Investments en la Moraleja Sports Club', '2021-01-01', '2021-01-02', 1, 'https://circuitopublidepmadrid.com/wp-content/uploads/2023/09/4_PRUEBA_SOMONTES_Madrid_Mesa-de-trabajo-1-copia-2-768x961.jpeg', 30, 3, 3, 3);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('Segundo OPEN OPS en Aurial Cornellà', '¡Tercera prueba de la nueva temporada OPENPADELSERIES!', '2021-01-01', '2021-01-02', 1, 'https://www.opensportseries.com/media/7/7b/7b1/7b1a33bbbe06eb7cdefd47c64bb0fb8f_1697649004_248x354.jpg', 30, 1, 4, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('Tercer Gran Slam OPS en Padel Indoor Hospitalet', '¡Sexta prueba de la nueva temporada OPENPADELSERIES!', '2021-01-01', '2021-01-02', 1, 'https://www.opensportseries.com/media/e/ee/ee6/ee681811b153c4060bad3b47dadfff21_1706098065.jpg', 35, 3, 5, 3);

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

INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Carlos', 'Garcia', 30, '1990-01-01', 'cgarciagarcia1993@gmail.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 1);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 1', 'Player 1', 60, '1990-01-01', 'info@player1.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 2', 'Player 2', 60, '1990-01-01', 'info@player2.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 3', 'Player 3', 60, '1990-01-01', 'info@player3.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 4', 'Player 4', 60, '1990-01-01', 'info@player4.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 5', 'Player 5', 60, '1990-01-01', 'info@player5.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 6', 'Player 6', 60, '1990-01-01', 'info@player6.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 7', 'Player 7', 60, '1990-01-01', 'info@player7.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 8', 'Player 8', 60, '1990-01-01', 'info@player8.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 9', 'Player 9', 60, '1990-01-01', 'info@player9.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 10', 'Player 10', 60, '1990-01-01', 'info@player10.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 11', 'Player 11', 60, '1990-01-01', 'info@player11.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 12', 'Player 12', 60, '1990-01-01', 'info@player12.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 13', 'Player 13', 60, '1990-01-01', 'info@player13.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 14', 'Player 14', 60, '1990-01-01', 'info@player14.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 15', 'Player 15', 60, '1990-01-01', 'info@player15.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 16', 'Player 16', 60, '1990-01-01', 'info@player16.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 17', 'Player 17', 60, '1990-01-01', 'info@player17.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 18', 'Player 18', 60, '1990-01-01', 'info@player18.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 19', 'Player 19', 60, '1990-01-01', 'info@player19.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 20', 'Player 20', 60, '1990-01-01', 'info@player20.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);

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



-- POSTGRESQL
DROP DATABASE IF EXISTS padelhub;
CREATE DATABASE padelhub;

USE padelhub;

CREATE TABLE IF NOT EXISTS country (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS comunity (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    id_country INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_country) REFERENCES country(id)
);

CREATE TABLE IF NOT EXISTS province (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    id_comunity INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_comunity) REFERENCES comunity(id)
);

CREATE TABLE IF NOT EXISTS city (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    id_province INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_province) REFERENCES province(id)
);

CREATE TABLE IF NOT EXISTS genre (
    id SERIAL NOT NULL,
    type VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS club (
    id SERIAL NOT NULL,
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
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS circuit (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    logo VARCHAR(255) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    web VARCHAR(100) NOT NULL,
    instagram VARCHAR(100) NOT NULL,
    facebook VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tournaments (
    id SERIAL NOT NULL,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    initial_date DATE NOT NULL,
    final_date DATE NOT NULL,
    is_premium BOOLEAN NOT NULL,
    image VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    id_circuit INT NOT NULL,
    id_club INT NOT NULL,
    id_welcome_pack INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_circuit) REFERENCES circuit(id),
    FOREIGN KEY (id_club) REFERENCES club(id),
    FOREIGN KEY (id_welcome_pack) REFERENCES welcome_pack(id)
);

CREATE TABLE IF NOT EXISTS categories (
    id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*create relation m-n table tournaments with caterogories*/
CREATE TABLE IF NOT EXISTS tournaments_categories (
    id SERIAL NOT NULL,
    tournament_id INT NOT NULL,
    categories_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE,
    FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL NOT NULL,
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
    id SERIAL NOT NULL,
    id_user INT NOT NULL,
    position VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS managers (
    id SERIAL NOT NULL,
    id_user INT NOT NULL,
    id_club INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (id_club) REFERENCES club(id) ON DELETE CASCADE
    
);

/*create relation m-n table tournaments with players*/
CREATE TABLE IF NOT EXISTS tournaments_players (
    id SERIAL NOT NULL,
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

INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Laieta ', 'info@laieta.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://laieta.cat/wp-content/uploads/2022/05/logolaieta150.png', 4, 'https://laieta.cat/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', true, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Real Club de Polo', 'info@polo.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://rcpolo.com/sfiles/img/logo.png', 4, 'https://rcpolo.com/es', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', true, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Club de Padel La Salut', 'lasalut@gmail.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://ctlasalut.com/wp-content/uploads/2021/11/cropped-ctlasalut_logo-1.png', 4, 'https://ctlasalut.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', true, 6);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Aurial Padel', 'info@aurial.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Outdoor', 'https://www.aurialpadel.com/assets/aurial_logo-ac2b7f2af6cf5c21d60908d42ec38e7052d85cbfa39e2d080f9b669fe07c3254.png', 4, 'https://www.aurialpadel.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', true, 2);
INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES ('Indoor Padel Hospitalet', 'info@indoorpadelhospitalet.com', '934 56 78 90', 'Carrer de la Mare de Déu de la Salut, 78', 'Indoor', 'https://www.padelindoorhospitalet.com/PadelIndoorHospitaletNueva/img/logo.png', 4, 'https://www.padelindoorhospitalet.com/', 'Bar', '9:00-22:00', 'https://www.instagram.com/clubpadelbarcelona/', 'https://www.facebook.com/clubpadelbarcelona/', false, 1);

INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 1', 'Paletilla de Jamon');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 2', 'Surtido de caldos aneto');
INSERT INTO welcome_pack (name, description) VALUES ('Welcome Pack 3', 'Agua, Barrita Energetica y Cerveza');

INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Publidep', 'Circuito Padel Barcelona', 'https://www.publidep.com/wp-content/uploads/2022/10/Logos_publidep.svg', '690 39 45 78', 'info@publidep.com', 'https://www.publidep.com/', 'https://www.instagram.com/circuit1/', 'https://www.facebook.com/circuit1/');
INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Barcelona Padel Tour', 'Circuito Padel Barcelona', 'https://barcelonapadeltour.com/wp-content/uploads/2018/12/cropped-logo-bpt-ok3.png', '663945880', 'ejackson@barcelonapadeltour.com', 'https://barcelonapadeltour.com/', 'https://www.instagram.com/circuit2/', 'https://www.facebook.com/circuit2/');
INSERT INTO circuit (name, description, logo, phone, email, web, instagram, facebook) VALUES ('Open Padel Series (OPS)', 'Circuito Padel Barcelona', 'https://www.opensportseries.com/media/7/7b/7b5/7b5dbf2712ded549191685c4a5a292ed_1659106220.png', '934 56 78 90', 'info@opensportseries.com', 'https://www.opensportseries.com/', 'https://www.instagram.com/circuit3/', 'https://www.facebook.com/circuit3/');

INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('I PRUEBA EN EL ARTÓS SPORTS CLUB', 'Primer torneo del año del Circuito Publidep by TQ Investments en el Artós Sports Club', '2021-01-01', '2021-01-02', true, 'https://www.publidep.com/wp-content/uploads/2024/01/artos-1.jpg', 35, 1, 1, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('1º torneo Barcelona Padel Tour Xpress by NACEX 2024', '1er torneo by barcelona padel tour', '2021-01-01', '2021-01-02', false, 'https://barcelonapadeltour.com/wp-content/uploads/2024/01/cartel-A4-1torneo24-sin-pronto-pago-copia-724x1024.jpg', 25, 2, 2, 2);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('IV PRUEBA EN LA MORALEJA SPORTS CLUB', 'Cuarto torneo del año del Circuito Publidep by TQ Investments en la Moraleja Sports Club', '2021-01-01', '2021-01-02', true, 'https://circuitopublidepmadrid.com/wp-content/uploads/2023/09/4_PRUEBA_SOMONTES_Madrid_Mesa-de-trabajo-1-copia-2-768x961.jpeg', 30, 3, 3, 3);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('Segundo OPEN OPS en Aurial Cornellà', '¡Tercera prueba de la nueva temporada OPENPADELSERIES!', '2021-01-01', '2021-01-02', true, 'https://www.opensportseries.com/media/7/7b/7b1/7b1a33bbbe06eb7cdefd47c64bb0fb8f_1697649004_248x354.jpg', 30, 1, 4, 1);
INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES ('Tercer Gran Slam OPS en Padel Indoor Hospitalet', '¡Sexta prueba de la nueva temporada OPENPADELSERIES!', '2021-01-01', '2021-01-02', true, 'https://www.opensportseries.com/media/e/ee/ee6/ee681811b153c4060bad3b47dadfff21_1706098065.jpg', 35, 3, 5, 3);

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

INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Carlos', 'Garcia', 30, '1990-01-01', 'cgarciagarcia1993@gmail.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 1);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 1', 'Player 1', 60, '1990-01-01', 'info@player1.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 2', 'Player 2', 60, '1990-01-01', 'info@player2.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 3', 'Player 3', 60, '1990-01-01', 'info@player3.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 4', 'Player 4', 60, '1990-01-01', 'info@player4.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 5', 'Player 5', 60, '1990-01-01', 'info@player5.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 6', 'Player 6', 60, '1990-01-01', 'info@player6.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 7', 'Player 7', 60, '1990-01-01', 'info@player7.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 8', 'Player 8', 60, '1990-01-01', 'info@player8.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 9', 'Player 9', 60, '1990-01-01', 'info@player9.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 10', 'Player 10', 60, '1990-01-01', 'info@player10.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 11', 'Player 11', 60, '1990-01-01', 'info@player11.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 12', 'Player 12', 60, '1990-01-01', 'info@player12.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 13', 'Player 13', 60, '1990-01-01', 'info@player13.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 14', 'Player 14', 60, '1990-01-01', 'info@player14.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 15', 'Player 15', 60, '1990-01-01', 'info@player15.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 16', 'Player 16', 60, '1990-01-01', 'info@player16.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 17', 'Player 17', 60, '1990-01-01', 'info@player17.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 18', 'Player 18', 60, '1990-01-01', 'info@player18.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 19', 'Player 19', 60, '1990-01-01', 'info@player19.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);
INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES ('Player 20', 'Player 20', 60, '1990-01-01', 'info@player20.com','$10$8YXmFKQOSnVZ1e4lO/9hp.h4L62xQRWv5QDcRFlaWgQQAdPTWeMry', '934 56 78 90', 'https://www.clubpadelbarcelona.com/wp-content/uploads/2019/10/club-padel-barcelona-club-padel-la-salut-1.jpg', 1, 6);

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