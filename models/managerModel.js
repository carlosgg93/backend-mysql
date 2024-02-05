import connection from '../db.js';

export default class ManagerModel {
  static async getAllManagers() {
    const [rows] = await connection.query(
      'SELECT m.id, u.name, u.surname, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, club.name as club, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN managers ' +
        'AS m ON u.id = m.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id JOIN club ON club.id = m.id_club',
    );
    return rows;
  }

  static async getManagerById(id) {
    const [rows] = await connection.query(
      'SELECT m.id, u.name, u.surname, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, club.name as club, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN managers ' +
        'AS m ON u.id = m.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id JOIN club ON club.id = m.id_club AND m.id = ?',
      [id],
    );
    return rows[0];
  }

  static async getManagerByEmail(email) {
    const [rows] = await connection.query(
      'SELECT m.id, u.name, u.surname, u.age, u.date_of_birth, u.email, u.password, u.phone,' +
        ' u.image, g.type as genre, club.name as club, c.name as city, pr.name as province, com.name as comunity, count.name as country FROM users AS u JOIN managers ' +
        'AS m ON u.id = m.id_user JOIN genre AS g ON u.id_genre = g.id JOIN city AS c ON u.id_city = c.id JOIN province AS pr ON c.id_province = pr.id ' +
        'JOIN comunity AS com ON pr.id_comunity = com.id JOIN country AS count ON com.id_country = count.id JOIN club ON club.id = m.id_club AND u.email = ?',
      [email],
    );
    return rows[0];
  }

  static async deleteManagerById(id_manager) {
    const [rows] = await connection.query('SELECT id_user FROM managers WHERE id = ?', [id_manager]);
    const id_user = rows[0].id_user;

    //delete manager from managers table and user from users table with the same id on cascade
    await connection.query('DELETE FROM users WHERE id = ?', [id_user]);
    await connection.query('DELETE FROM managers WHERE id = ?', [id_manager]);
    return rows;
  }

  static async addManager(manager) {
    //insert manager to managers table and user to users table
    const [rows] = await connection.query(
      'INSERT INTO users (name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        manager.name,
        manager.surname,
        manager.age,
        manager.date_of_birth,
        manager.email,
        manager.passwordHash,
        manager.phone,
        manager.image,
        manager.id_genre,
        manager.id_city,
      ],
    );

    const insertId = rows.insertId;

    const [rows2] = await connection.query('INSERT INTO managers (id_user, id_club) VALUES (?, ?)', [insertId, manager.id_club]);
  }
}
