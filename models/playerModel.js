import connection from '../db.js';

export class PlayerModel {
  static async getAllPlayers() {
    const [rows] = await connection.query(
      'SELECT u.name, u.surname, p.position, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN players ' +
        'AS p ON u.id = p.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id',
    );
    return rows;
  }

  static async getPlayerById(id) {
     const [rows] = await connection.query(
      'SELECT u.name, u.surname, p.position, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN players ' +
        'AS p ON u.id = p.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id AND p.id = ?', [id],
    );
    return rows[0];
  }

  static async deletePlayerById(id) {
    //delete player from players table and user from users table with the same id on cascade
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
