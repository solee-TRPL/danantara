import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
  // Jika validasi form diperlukan, tetap jalankan ini:
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);

    // Simulasi delay login jika mau
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    // Tampilkan snackbar berhasil
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: const Text('Login berhasil!'),
    //     backgroundColor: Colors.green[700],
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // Langsung navigasi ke halaman home
    Navigator.pushReplacementNamed(context, '/home');
  }
}


  // Yang lama --> 
  // Future<void> _handleLogin() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => _isLoading = true);
      
  //     final result = await _authService.login(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text,
  //     );
      
  //     setState(() => _isLoading = false);
      
  //     if (result['success']) {
  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text('Login berhasil!'),
  //           backgroundColor: Colors.green[700],
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //       );
  //       // Navigate to home
  //       Navigator.pushReplacementNamed(context, '/home');
  //     } else {
  //       // Show error
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(result['message'] ?? 'Login gagal'),
  //           backgroundColor: Colors.red[700],
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            // Main content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Back button
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(
                    //     icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
                    //     onPressed: () => Navigator.pop(context),
                    //   ),
                    // ),
                    
                    const SizedBox(height: 20),
                    
                    // App logo or image
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.lock_open_rounded,
                          size: 70,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Text(
                      'Masuk ke akun untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email field
                          Material(
                            elevation: 5,
                            shadowColor: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Masukkan email anda',
                                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                                prefixIcon: Icon(Icons.email_outlined, color: Colors.blue),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Email tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password field
                          Material(
                            elevation: 5,
                            shadowColor: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Masukkan password anda',
                                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to forgot password screen
                                Navigator.pushNamed(context, '/forgot-password');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              ),
                              child: Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Login button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.blue.withOpacity(0.8)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              // _isLoading ? null : _handleLogin
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'MASUK',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Register option
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum punya akun?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to register screen
                                  Navigator.pushNamed(context, '/register');
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                ),
                                child: Text(
                                  'Daftar Sekarang',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}