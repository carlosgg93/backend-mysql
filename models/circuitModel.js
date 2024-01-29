import connection from '../db.js';

export class CircuitModel {
  static async getAllCircuits() {
    const [rows] = await connection.query('SELECT * FROM circuit');
    return rows;
  }

  static async getCircuitById(id) {
    const [rows] = await connection.query('SELECT * FROM circuit WHERE id = ?', [id]);
    return rows[0];
  }

  static async deleteCircuitById(id) {
    const [rows] = await connection.query('DELETE FROM circuit WHERE id = ?', [id]);
    return rows;
  }

  static async addCircuit(circuit) {
    const [rows] = await connection.query('INSERT INTO circuit (name, description, image, id_city) VALUES (?, ?, ?, ?)', [
      circuit.name,
      circuit.description,
      circuit.image,
      circuit.id_city,
    ]);
    return rows;
  }

  static async updateCircuitById(id, circuit) {
    const [rows] = await connection.query('UPDATE circuit SET name = ?, description = ?, image = ?, id_city = ? WHERE id = ?', [
      circuit.name,
      circuit.description,
      circuit.image,
      circuit.id_city,
      id,
    ]);
  }

  static async getCircuitsByCity(id) {
    const [rows] = await connection.query('SELECT * FROM circuit WHERE id_city = ?', [id]);
    return rows;
  }

  static async getCircuitsByClub(id) {
    const [rows] = await connection.query('SELECT * FROM circuit WHERE id_club = ?', [id]);
    return rows;
  }

  static async getCircuitsByTournament(id) {
    const [rows] = await connection.query('SELECT * FROM circuit WHERE id_tournament = ?', [id]);
    return rows;
  }
}
