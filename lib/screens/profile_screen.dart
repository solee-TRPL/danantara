import 'package:danantara/profil/about_app_screen.dart';
import 'package:danantara/profil/help_center_screen.dart';
import 'package:danantara/profil/payment_method_screen.dart';
import 'package:danantara/profil/referral_screen.dart';
import 'package:danantara/profil/scurity_screen.dart';
import 'package:danantara/profil/verification_screen.dart';
import '../profil/settings_screen.dart'; 
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with gradient
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withBlue(200),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: BackgroundPatternPainter(),
                      ),
                    ),
                    // Profile info
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Ahmad Budi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '0812 3456 7890',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0, 2),
                                  ),
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
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Navigate to settings
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          
          // Profile Stats
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(context, 'Level', 'Gold', Icons.military_tech),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  _buildStatItem(context, 'Poin', '12,500', Icons.star),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  _buildStatItem(context, 'Voucher', '8', Icons.card_giftcard),
                ],
              ),
            ),
          ),
          
          // Menu Items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                    child: Text(
                      'Pengaturan Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Verifikasi Akun',
                    Icons.verified_user,
                    description: 'Status verifikasi identitas Anda',
                    isVerified: true,
                    navigateTo: VerificationScreen(),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Keamanan',
                    Icons.security,
                    description: 'PIN, kata sandi, dan autentikasi',
                    navigateTo: SecurityScreen(),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Metode Pembayaran',
                    Icons.payment,
                    description: 'Kelola metode pembayaran Anda',
                    navigateTo: PaymentMethodScreen(),
                  ),
                  
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                    child: Text(
                      'Bantuan & Informasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Pusat Bantuan',
                    Icons.help,
                    description: 'Pertanyaan umum dan dukungan',
                    navigateTo: HelpCenterScreen(),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Referral',
                    Icons.people,
                    description: 'Undang teman dan dapatkan hadiah',
                    navigateTo: ReferralScreen(),
                  ),
                  _buildProfileMenuItem(
                    context,
                    'Tentang Aplikasi',
                    Icons.info,
                    description: 'Informasi versi dan pengembang',
                    navigateTo: AboutAppScreen(),
                  ),
                  
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Show logout confirmation
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text('Keluar'),
                            content: Text('Anda yakin ingin keluar dari aplikasi?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Batal'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Navigate to login screen
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (route) => false,
                                  );
                                },
                                child: Text('Keluar'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context,
    String title,
    IconData icon, {
    required String description,
    bool isVerified = false,
    Widget? navigateTo,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (navigateTo != null) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => navigateTo),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                isVerified
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green.shade400,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green.shade600,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Terverifikasi',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final double tileSize = 20;
    final int horizontalTileCount = (size.width / tileSize).ceil() + 1;
    final int verticalTileCount = (size.height / tileSize).ceil() + 1;

    for (int i = 0; i < horizontalTileCount; i++) {
      for (int j = 0; j < verticalTileCount; j++) {
        if ((i + j) % 2 == 0) {
          final rect = Rect.fromLTWH(
            i * tileSize,
            j * tileSize,
            tileSize / 2,
            tileSize / 2,
          );
          canvas.drawRect(rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}