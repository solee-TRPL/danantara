// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String baseUrl = 'http://localhost:3000/api/auth';

//   Future<Map<String, dynamic>> register({
//     required String email,
//     required String password,
//     required String fullName,
//     String? phoneNumber,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//           'full_name': fullName,
//           'phone_number': phoneNumber,
//         }),
//       );

//       final data = jsonDecode(response.body);
      
//       if (response.statusCode == 201) {
//         // Simpan token
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', data['token']);
        
//         return {'success': true, 'data': data};
//       } else {
//         return {'success': false, 'message': data['message']};
//       }
//     } catch (e) {
//       return {'success': false, 'message': 'Terjadi kesalahan: $e'};
//     }
//   }

//   Future<Map<String, dynamic>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//       );

//       final data = jsonDecode(response.body);
      
//       if (response.statusCode == 200) {
//         // Simpan token
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', data['token']);
        
//         return {'success': true, 'data': data};
//       } else {
//         return {'success': false, 'message': data['message']};
//       }
//     } catch (e) {
//       return {'success': false, 'message': 'Terjadi kesalahan: $e'};
//     }
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//   }

//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.containsKey('token');
//   }
// }



















import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Ganti dengan base URL API Anda
  final String _baseUrl = 'https://api.example.com';
  
  // Fungsi untuk login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        // Simpan token dan data user ke shared preferences
        await _saveUserData(
          token: responseData['token'],
          userData: responseData['user'],
        );
        
        return {
          'success': true,
          'message': 'Login berhasil',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }
  
  // Fungsi untuk register
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'full_name': fullName,
          'phone_number': phoneNumber,
        }),
      );
      
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        // Simpan token dan data user ke shared preferences
        await _saveUserData(
          token: responseData['token'],
          userData: responseData['user'],
        );
        
        return {
          'success': true,
          'message': 'Registrasi berhasil',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registrasi gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }
  
  // Fungsi untuk logout
  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_token');
      await prefs.remove('user_data');
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Fungsi untuk menyimpan data user ke shared preferences
  Future<void> _saveUserData({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    await prefs.setString('user_data', jsonEncode(userData));
  }
  
  // Fungsi untuk mengambil token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }
  
  // Fungsi untuk mengambil data user
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataStr = prefs.getString('user_data');
    if (userDataStr != null) {
      return jsonDecode(userDataStr) as Map<String, dynamic>;
    }
    return null;
  }
  
  // Fungsi untuk cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}