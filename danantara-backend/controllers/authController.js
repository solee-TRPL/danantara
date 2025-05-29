const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');

const authController = {
  async register(req, res) {
    try {
      const { email, password, full_name, phone_number } = req.body;

      // Validasi input
      if (!email || !password || !full_name) {
        return res.status(400).json({ message: 'Semua field wajib diisi' });
      }

      // Cek apakah email sudah terdaftar
      const existingUser = await User.findByEmail(emoji);
      if (existingUser) {
        return res.status(400).json({ message: 'Email sudah terdaftar' });
      }

      // Hash password
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);

      // Buat user baru
      const newUser = await User.create({
        email,
        password: hashedPassword,
        full_name,
        phone_number
      });

      // Buat wallet untuk user baru
      await User.createWallet(newUser.id);

      // Generate JWT token
      const token = jwt.sign(
        { id: newUser.id, email: newUser.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.status(201).json({
        message: 'Registrasi berhasil',
        token,
        user: {
          id: newUser.id,
          email: newUser.email,
          full_name: newUser.full_name
        }
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Terjadi kesalahan server' });
    }
  },

  async login(req, res) {
    try {
      const { email, password } = req.body;

      // Validasi input
      if (!email || !password) {
        return res.status(400).json({ message: 'Email dan password wajib diisi' });
      }

      // Cari user berdasarkan email
      const user = await User.findByEmail(email);
      if (!user) {
        return res.status(401).json({ message: 'Email atau password salah' });
      }

      // Verifikasi password
      const isValidPassword = await bcrypt.compare(password, user.password);
      if (!isValidPassword) {
        return res.status(401).json({ message: 'Email atau password salah' });
      }

      // Generate JWT token
      const token = jwt.sign(
        { id: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.status(200).json({
        message: 'Login berhasil',
        token,
        user: {
          id: user.id,
          email: user.email,
          full_name: user.full_name
        }
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Terjadi kesalahan server' });
    }
  }
};

module.exports = authController;