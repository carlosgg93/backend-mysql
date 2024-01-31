import connection from '../db.js';

export class PlayerModel {
  static async getAllPlayers() {
    const [rows] = await connection.query(
      'SELECT p.id, u.name, u.surname, p.position, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN players ' +
        'AS p ON u.id = p.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id',
    );
    return rows;
  }

  static async getPlayerById(id) {
    const [rows] = await connection.query(
      'SELECT p.id, u.name, u.surname, p.position, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN players ' +
        'AS p ON u.id = p.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id AND p.id = ?',
      [id],
    );
    return rows[0];
  }

  static async deletePlayerById(id) {
    //delete player from players table and user from users table with the same id on cascade
    const [rows] = await connection.query('DELETE FROM players WHERE id = ?', [id]);
    return rows;
  }

  static async addPlayer(player) {
    //insert player to players table and user to users table
    const [rows] = await connection.query(
      'INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        player.name,
        player.surname,
        player.age,
        player.date_of_birth,
        player.email,
        player.password,
        player.phone,
        player.image,
        player.id_genre,
        player.id_city,
      ],
    );

    const insertId = rows.insertId;

    const [rows2] = await connection.query('INSERT INTO players (position, id_user) VALUES (?, ?)', [player.position, insertId]);
  }

  // static async updatePlayerById(id, player) {
  //   const [rows] = await connection.query(
  //     'UPDATE players SET name = ?, surname = ?, birthdate = ?, image = ?, id_city = ?, id_club = ? WHERE id = ?',
  //     [player.name, player.surname, player.birthdate, player.image, player.id_city, player.id_club, id],
  //   );
  // }

  static async getPlayersByCity(city) {
    const [rows] = await connection.query(
      'SELECT u.name, u.surname, p.position, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN players ' +
        'AS p ON u.id = p.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id AND city = ?',
      [city],
    );
    return rows[0];
  }
}
