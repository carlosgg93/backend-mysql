import connection from '../db.js';

export class TournamentModel {
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
    const [rows] = await connection.query(
      'INSERT INTO tournaments (title, description, initial_date, final_date, is_premium, image, price, id_circuit, id_club, id_welcome_pack) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        tournament.title,
        tournament.description,
        tournament.initial_date,
        tournament.final_date,
        tournament.is_premium,
        tournament.image,
        tournament.price,
        tournament.id_circuit,
        tournament.id_club,
        tournament.id_welcome_pack,
      ],
    );
    return rows;
  }

  static async updateTournamentById(id, tournament) {
    const [rows] = await connection.query(
      'UPDATE tournaments SET title = ?, description = ?, initial_date = ?, final_date = ?, is_premium = ?, image = ?, price = ?, id_circuit = ?, id_city = ?, id_club = ?, id_welcome = ? WHERE id = ?',
      [
        tournament.title,
        tournament.description,
        tournament.initial_date,
        tournament.final_date,
        tournament.is_premium,
        tournament.image,
        tournament.price,
        tournament.id_circuit,
        tournament.id_city,
        tournament.id_club,
        tournament.id_welcome,
        id,
      ],
    );
  }

  static async getTournamentsByCity(id) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE id_city = ?', [id]);
    return rows;
  }

  static async getTournamentsByClub(id) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE id_club = ?', [id]);
    return rows;
  }

  static async getTournamentsByCircuit(id) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE id_circuit = ?', [id]);
    return rows;
  }

  static async getTournamentsByWelcome(id) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE id_welcome = ?', [id]);
    return rows;
  }

  static async getTournamentsByDate(date) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE initial_date = ?', [date]);
    return rows;
  }

  static async getTournamentsByPrice(price) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE price = ?', [price]);
    return rows;
  }

  static async getTournamentsByPremium(premium) {
    const [rows] = await connection.query('SELECT * FROM tournaments WHERE is_premium = ?', [premium]);
    return rows;
  }
}
