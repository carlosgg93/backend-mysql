import connection from '../db.js';

export class TournamentsModel {
  static async getAllTournaments() {
    const [rows] = await connection.query('SELECT * FROM tournaments');
    return rows;
  }

  static async getTournamentById(id) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE id = ?', [id]);
    return rows[0];
  }

  static async deleteTournamentById(id) {
    const [rows] = await connection.query('DELETE FROM tournaments WHERE id = ?', [id]);
    return rows;
  }

  static async addTournament(tournament) {
    // const [rows] = await connection.query(
    //   'INSERT INTO tournaments (title, director, year, rating) VALUES (?, ?, ?, ?)',
    //   [movie.title, movie.director, movie.year, movie.rating]
    // );
    // return rows;
  }

  static async updateTournamentById(id, tournament) {
    // const [rows] = await connection.execute(
    //   'UPDATE tournaments SET title = ?, director = ?, year = ?, rating = ? WHERE id = ?',
    //   [movie.title, movie.director, movie.year, movie.rating, id]
    // );
    // return rows;
  }
}
