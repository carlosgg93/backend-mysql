/*create new database moviesdb with a movies and genre table*/

DROP DATABASE IF EXISTS moviesdb;
CREATE DATABASE moviesdb;

USE moviesdb;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO users (username, password) VALUES ('carlosgg93', '123456');

CREATE TABLE IF NOT EXISTS movies (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    poster VARCHAR(100) NOT NULL,
    rating INT NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Shawshank Redemption', 'Drama', 1994, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Godfather', 'Drama', 1972, 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Dark Knight', 'Action', 2008, 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Godfather: Part II', 'Drama', 1974, 'https://image.tmdb.org/t/p/w500/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('The Lord of the Rings: The Return of the King', 'Adventure', 2003, 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('Pulp Fiction', 'Thriller', 1994, 'https://image.tmdb.org/t/p/w500/dM2w364MScsjFf8pfMbaWUcWrR.jpg', 9);
INSERT INTO movies (title, genre, release_year, poster, rating) VALUES ('Schindler''s List', 'Drama', 1993, 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', 9);

CREATE TABLE IF NOT EXISTS genre (
    id INT NOT NULL AUTO_INCREMENT,
    genre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO genre (genre) VALUES ('Action');
INSERT INTO genre (genre) VALUES ('Adventure');
INSERT INTO genre (genre) VALUES ('Animation');
INSERT INTO genre (genre) VALUES ('Comedy');
INSERT INTO genre (genre) VALUES ('Crime');
INSERT INTO genre (genre) VALUES ('Documentary');
INSERT INTO genre (genre) VALUES ('Drama');
INSERT INTO genre (genre) VALUES ('Family');
INSERT INTO genre (genre) VALUES ('Fantasy');
INSERT INTO genre (genre) VALUES ('History');
INSERT INTO genre (genre) VALUES ('Horror');
INSERT INTO genre (genre) VALUES ('Music');
INSERT INTO genre (genre) VALUES ('Mystery');
INSERT INTO genre (genre) VALUES ('Romance');
INSERT INTO genre (genre) VALUES ('Science Fiction');
INSERT INTO genre (genre) VALUES ('TV Movie');
INSERT INTO genre (genre) VALUES ('Thriller');
INSERT INTO genre (genre) VALUES ('War');
INSERT INTO genre (genre) VALUES ('Western');

CREATE TABLE movies_genre (
    id INT NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

INSERT INTO movies_genre (movie_id, genre_id) VALUES (1, 7);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (2, 7);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (3, 1);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (4, 7);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (5, 2);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (6, 17);
INSERT INTO movies_genre (movie_id, genre_id) VALUES (7, 7);
