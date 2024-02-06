import connection from '../db.js';

export class ClubModel {
  static async getAllClubs() {
    const [rows] = await connection.query('SELECT * FROM club');
    return rows;
  }

  static async getClubById(id) {
    const [rows] = await connection.query('SELECT * FROM club WHERE id = ?', [id]);
    return rows[0];
  }

  static async deleteClubById(id) {
    const [rows] = await connection.query('DELETE FROM club WHERE id = ?', [id]);
    return rows;
  }

  static async addClub(club) {
    const [rows] = await connection.query(
      'INSERT INTO club (name, email, phone, direction, type, logo, number_of_courts, web, services, schedules, instagram, facebook, is_premium, id_city) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        club.name,
        club.email,
        club.phone,
        club.direction,
        club.type,
        club.logo,
        club.number_of_courts,
        club.web,
        club.services,
        club.schedules,
        club.instagram,
        club.facebook,
        club.is_premium,
        club.id_city,
      ],
    );
    return rows;
  }

  static async updateClubById(id, club) {
    const [rows] = await connection.query('UPDATE club SET name = ?, description = ?, image = ?, id_city = ? WHERE id = ?', [
      club.name,
      club.description,
      club.image,
      club.id_city,
      id,
    ]);
  }

  static async getClubsByCity(id) {
    const [rows] = await connection.query('SELECT * FROM club WHERE id_city = ?', [id]);
    return rows;
  }
}
