const pool = require('../config/database');

class User {
  static async create(userData) {
    const { email, password, full_name, phone_number } = userData;
    const query = `
      INSERT INTO users (email, password, full_name, phone_number)
      VALUES ($1, $2, $3, $4)
      RETURNING id, email, full_name, phone_number, created_at
    `;
    const values = [email, password, full_name, phone_number];
    
    try {
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByEmail(email) {
    const query = 'SELECT * FROM users WHERE email = $1';
    try {
      const result = await pool.query(query, [email]);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async createWallet(userId) {
    const query = `
      INSERT INTO wallets (user_id)
      VALUES ($1)
      RETURNING id, user_id, balance
    `;
    try {
      const result = await pool.query(query, [userId]);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }
}

module.exports = User;