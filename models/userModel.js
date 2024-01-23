import connection from '../db.js';

export default class UserModel {
  static async getAllUsers() {
    const [rows] = await connection.query('SELECT * FROM users');
    return rows;
  }

  static async getUserById(id) {
    const [rows] = await connection.query('SELECT * FROM users WHERE id = ?', [id]);
    return rows[0];
  }

  static async getUserByUserName(username) {
    const [rows] = await connection.query('SELECT * FROM users WHERE username = ?', [username]);
    return rows[0];
  }

  static async deleteUserById(id) {
    const [rows] = await connection.query('DELETE FROM users WHERE id = ?', [id]);
    return rows;
  }

  static async addUser(user) {
    const [rows] = await connection.query('INSERT INTO users (username, email, password) VALUES (?, ?, ?)', [
      user.username,
      user.email,
      user.password,
    ]);
    return rows;
  }

  static async updateUserById(id, user) {
    const [rows] = await connection.execute('UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?', [
      user.username,
      user.email,
      user.password,
      id,
    ]);
    return rows;
  }
}
