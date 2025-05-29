import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
import 'dart:ui';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  // final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
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
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Future<void> _handleRegister() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => _isLoading = true);
      
  //     final result = await _authService.register(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text,
  //       fullName: _fullNameController.text.trim(),
  //       phoneNumber: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
  //     );
      
  //     setState(() => _isLoading = false);
      
  //     if (result['success']) {
  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text('Registrasi berhasil!'),
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
  //           content: Text(result['message'] ?? 'Registrasi gagal'),
  //           backgroundColor: Colors.red[700],
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //       );
  //     }
  //   }
  // }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    bool isObscureToggle = false,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Material(
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: primaryColor),
          suffixIcon: isObscureToggle
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: primaryColor,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
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
            borderSide: BorderSide(color: primaryColor, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -120,
              right: -120,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
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
                    const SizedBox(height: 20),
                    
                    // Back button
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(
                    //     icon: Icon(Icons.arrow_back_ios, color: primaryColor),
                    //     onPressed: () => Navigator.pop(context),
                    //   ),
                    // ),
                    
                    const SizedBox(height: 15),
                    
                    // App logo or image
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
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
                          Icons.person_add_rounded,
                          size: 60,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Title
                    Text(
                      'Buat Akun Baru',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Text(
                      'Daftarkan diri anda untuk memulai',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Full name field
                          _buildFormField(
                            controller: _fullNameController,
                            label: 'Nama Lengkap',
                            hint: 'Masukkan nama lengkap anda',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama lengkap tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Email field
                          _buildFormField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Masukkan email anda',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
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
                          
                          const SizedBox(height: 20),
                          
                          // Phone field (optional)
                          _buildFormField(
                            controller: _phoneController,
                            label: 'Nomor Telepon (Opsional)',
                            hint: 'Masukkan nomor telepon anda',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password field
                          _buildFormField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Masukkan password anda',
                            icon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            isObscureToggle: true,
                            onToggleObscure: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              if (value.length < 6) {
                                return 'Password minimal 6 karakter';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Confirm password field
                          _buildFormField(
                            controller: _confirmPasswordController,
                            label: 'Konfirmasi Password',
                            hint: 'Masukkan ulang password anda',
                            icon: Icons.lock_outline,
                            obscureText: _obscureConfirmPassword,
                            isObscureToggle: true,
                            onToggleObscure: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Konfirmasi password tidak boleh kosong';
                              }
                              if (value != _passwordController.text) {
                                return 'Password tidak cocok';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Register button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [primaryColor, primaryColor.withOpacity(0.8)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              // _isLoading ? null : _handleRegister
                              onPressed: () {},
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
                                      'DAFTAR',
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
                          
                          // Login option
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sudah punya akun?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to login screen
                                  Navigator.pushNamed(context, '/login');
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                ),
                                child: Text(
                                  'Masuk Sekarang',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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