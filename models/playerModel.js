import connection from '../db.js';

export class PlayerModel {
  static async getAllPlayers() {
    const [rows] = await connection.query('SELECT * FROM players');
    return rows;
  }

  static async getPlayerById(id) {
    const [rows] = await connection.query('SELECT * FROM players WHERE id = ?', [id]);
    return rows[0];
  }

  static async deletePlayerById(id) {
    const [rows] = await connection.query('DELETE FROM players WHERE id = ?', [id]);
    return rows;
  }

  static async addPlayer(player) {
    const [rows] = await connection.query('INSERT INTO players (name, surname, birthdate, image, id_city, id_club) VALUES (?, ?, ?, ?, ?, ?)', [
      player.name,
      player.surname,
      player.birthdate,
      player.image,
      player.id_city,
      player.id_club,
    ]);
    return rows;
  }

  static async updatePlayerById(id, player) {
    const [rows] = await connection.query(
      'UPDATE players SET name = ?, surname = ?, birthdate = ?, image = ?, id_city = ?, id_club = ? WHERE id = ?',
      [player.name, player.surname, player.birthdate, player.image, player.id_city, player.id_club, id],
    );
  }

  static async getPlayersByCity(id) {
    const [rows] = await connection.query('SELECT * FROM players WHERE id_city = ?', [id]);
    return rows;
  }

  static async getPlayersByClub(id) {
    const [rows] = await connection.query('SELECT * FROM players WHERE id_club = ?', [id]);
    return rows;
  }

  static async getPlayersByTournament(id) {
    const [rows] = await connection.query('SELECT * FROM players WHERE id_tournament = ?', [id]);
    return rows;
  }

  // static async getPlayersByMatch(id) {
  //   const [rows] = await connection.query('SELECT * FROM players WHERE id_match = ?', [id]);
  //   return rows;
  // }
}
