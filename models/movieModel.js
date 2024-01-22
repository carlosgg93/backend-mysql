import connection from "../db.js";

export class MovieModel {
  static async getAllMovies() {
    const [rows] = await connection.query(
      'SELECT * FROM movies'
    );
    return rows;
  }

  static async getMovieById(id) {
    const [rows] = await connection.query(
      'SELECT * FROM movies WHERE id = ?',
      [id]
    );
    return rows[0];
  }

  static async deleteMovieById(id) {
    const [rows] = await connection.query(
      'DELETE FROM movies WHERE id = ?',
      [id]
    );
    return rows;
  }

  static async addMovie(movie) {
    const [rows] = await connection.query(
      'INSERT INTO movies (title, director, year, rating) VALUES (?, ?, ?, ?)',
      [movie.title, movie.director, movie.year, movie.rating]
    );
    return rows;
  }

  static async updateMovieById(id, movie) {
    const [rows] = await connection.execute(
      'UPDATE movies SET title = ?, director = ?, year = ?, rating = ? WHERE id = ?',
      [movie.title, movie.director, movie.year, movie.rating, id]
    );
    return rows;
  }
}
