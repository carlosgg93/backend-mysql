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

/*create new database moviesdb with a movies and genre table*/

-- DROP DATABASE IF EXISTS moviesdb;
-- CREATE DATABASE moviesdb;

-- USE moviesdb;

-- CREATE TABLE IF NOT EXISTS users (
--     id INT NOT NULL AUTO_INCREMENT,
--     username VARCHAR(100) NOT NULL,
--     password VARCHAR(100) NOT NULL,
--     PRIMARY KEY (id)
-- );

-- INSERT INTO users (username, password) VALUES ('carlosgg93', '123456');

-- CREATE TABLE IF NOT EXISTS movies (
--     id INT NOT NULL AUTO_INCREMENT,
--     title VARCHAR(100) NOT NULL,
--     genre VARCHAR(100) NOT NULL,
--     release_year INT NOT NULL,
--     poster VARCHAR(100) NOT NULL,
--     rating INT NOT NULL,
--     PRIMARY KEY (id)
-- );

-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Shawshank Redemption', 'Drama', 1994, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Godfather', 'Drama', 1972, 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Dark Knight', 'Action', 2008, 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Godfather: Part II', 'Drama', 1974, 'https://image.tmdb.org/t/p/w500/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Lord of the Rings: The Return of the King', 'Adventure', 2003, 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('Pulp Fiction', 'Thriller', 1994, 'https://image.tmdb.org/t/p/w500/dM2w364MScsjFf8pfMbaWUcWrR.jpg', 9);
-- INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('Schindler''s List', 'Drama', 1993, 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', 9);

-- CREATE TABLE IF NOT EXISTS genre (
--     id INT NOT NULL AUTO_INCREMENT,
--     genre VARCHAR(100) NOT NULL,
--     PRIMARY KEY (id)
-- );

-- INSERT INTO genre (genre) VALUES ('Action');
-- INSERT INTO genre (genre) VALUES ('Adventure');
-- INSERT INTO genre (genre) VALUES ('Animation');
-- INSERT INTO genre (genre) VALUES ('Comedy');
-- INSERT INTO genre (genre) VALUES ('Crime');
-- INSERT INTO genre (genre) VALUES ('Documentary');
-- INSERT INTO genre (genre) VALUES ('Drama');
-- INSERT INTO genre (genre) VALUES ('Family');
-- INSERT INTO genre (genre) VALUES ('Fantasy');
-- INSERT INTO genre (genre) VALUES ('History');
-- INSERT INTO genre (genre) VALUES ('Horror');
-- INSERT INTO genre (genre) VALUES ('Music');
-- INSERT INTO genre (genre) VALUES ('Mystery');
-- INSERT INTO genre (genre) VALUES ('Romance');
-- INSERT INTO genre (genre) VALUES ('Science Fiction');
-- INSERT INTO genre (genre) VALUES ('TV Movie');
-- INSERT INTO genre (genre) VALUES ('Thriller');
-- INSERT INTO genre (genre) VALUES ('War');
-- INSERT INTO genre (genre) VALUES ('Western');

-- CREATE TABLE movies_genre (
--     id INT NOT NULL AUTO_INCREMENT,
--     movie_id INT NOT NULL,
--     genre_id INT NOT NULL,
--     PRIMARY KEY (id),
--     FOREIGN KEY (movie_id) REFERENCES movies(id),
--     FOREIGN KEY (genre_id) REFERENCES genre(id)
-- );

-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (1, 7);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (2, 7);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (3, 1);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (4, 7);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (5, 2);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (6, 17);
-- INSERT INTO movies_genre (movie_id, genre_id) VALUES (7, 7);

/*
Create new database padelhub with hist tables, inserts and his relations:

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

PLAYER
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
- position
- id_genre
- id_country
- id_city

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
- id_comunity

COMUNITY
- id
- name (Cataluña, Andalucia etc..)

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

CREATE TABLE IF NOT EXISTS tournament (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    initial_date DATE NOT NULL,
    final_date DATE NOT NULL,
    is_premium BOOLEAN NOT NULL,
    image VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    id_circuit FOREIGN KEY REFERENCES circuit(id),
    id_city FOREIGN KEY REFERENCES city(id),
    id_club FOREIGN KEY REFERENCES club(id),
    id_welcomePack FOREIGN KEY REFERENCES welcomePack(id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS categories (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*create relation m-n table tournament with caterogories*/
CREATE TABLE IF NOT EXISTS tournament_categories (
    id INT NOT NULL AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    categories_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tournament_id) REFERENCES tournament(id),
    FOREIGN KEY (categories_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS player (
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
    position VARCHAR(100) NOT NULL,
    id_genre FOREIGN KEY REFERENCES genre(id),
    id_country FOREIGN KEY REFERENCES country(id),
    id_city FOREIGN KEY REFERENCES city(id),
    PRIMARY KEY (id)
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

CREATE TABLE IF NOT EXISTS city (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    id_comunity FOREIGN KEY REFERENCES comunity(id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS comunity (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS country (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
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
    id_city FOREIGN KEY REFERENCES city(id),
    id_comunity FOREIGN KEY REFERENCES comunity(id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS welcomePack (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*inserts*/
INSERT INTO tournament (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcomePack) VALUES ('Torneo 1', 'Torneo de prueba 1', '2021-01-01', '2021-01-02', 0, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournament (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcomePack) VALUES ('Torneo 2', 'Torneo de prueba 2', '2021-01-01', '2021-01-02', 0, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 10, 1, 1, 1, 1);
INSERT INTO tournament (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_city, id_club, id_welcomePack) VALUES ('Torneo 3', 'Torneo de prueba 3', '2021-01-01', '2021-01-02', 0, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 10, 1, 1, 1, 1);

INSERT INTO categories (name) VALUES ('1a');
INSERT INTO categories (name) VALUES ('2a');
INSERT INTO categories (name) VALUES ('3a');
INSERT INTO categories (name) VALUES ('4a');

INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (1, 1);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (1, 2);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (1, 3);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (1, 4);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (2, 1);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (2, 2);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (3, 3);
INSERT INTO tournament_categories (tournament_id, categories_id) VALUES (3, 4);

/* insert players*/
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
    position VARCHAR(100) NOT NULL,
    id_genre FOREIGN KEY REFERENCES genre(id),
    id_country FOREIGN KEY REFERENCES country(id),
    id_city FOREIGN KEY REFERENCES city(id),

INSERT INTO players (id, surname, age, date_of_birth, nationality, email, password, phone, image, position, id_genre, id_country, id_city) VALUES
()