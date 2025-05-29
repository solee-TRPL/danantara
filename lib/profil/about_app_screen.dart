import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final String _appVersion = "2.1.0";
  final String _buildNumber = "210";
  final String _releaseDate = "10 April 2025";
  final List<Map<String, dynamic>> _teamMembers = [
    {
      'name': 'Ahmad Budi',
      'role': 'Founder & CEO',
      'avatar': 'A',
      'color': Colors.blue,
    },
    {
      'name': 'Dewi Rahayu',
      'role': 'CTO',
      'avatar': 'D',
      'color': Colors.purple,
    },
    {
      'name': 'Eko Saputra',
      'role': 'Lead Designer',
      'avatar': 'E',
      'color': Colors.orange,
    },
    {
      'name': 'Fiona Wijaya',
      'role': 'Marketing Director',
      'avatar': 'F',
      'color': Colors.green,
    },
  ];
  
  final List<Map<String, dynamic>> _updates = [
    {
      'version': '2.1.0',
      'date': '10 April 2025',
      'highlights': [
        'Fitur baru: Pembayaran tagihan otomatis',
        'Peningkatan keamanan dengan verifikasi dua langkah',
        'Antarmuka pengguna yang disempurnakan',
        'Perbaikan bug dan optimasi kinerja',
      ],
    },
    {
      'version': '2.0.0',
      'date': '15 Maret 2025',
      'highlights': [
        'Desain ulang antarmuka pengguna',
        'Penambahan fitur referral',
        'Dukungan untuk lebih banyak metode pembayaran',
        'Peningkatan stabilitas dan kecepatan aplikasi',
      ],
    },
    {
      'version': '1.5.2',
      'date': '20 Februari 2025',
      'highlights': [
        'Perbaikan bug pada proses checkout',
        'Optimasi penggunaan memori',
        'Peningkatan kompatibilitas dengan perangkat terbaru',
      ],
    },
  ];

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppInfo(),
                  SizedBox(height: 24),
                  _buildMissionSection(),
                  SizedBox(height: 24),
                  _buildTeamSection(),
                  SizedBox(height: 24),
                  _buildFeaturesSection(),
                  SizedBox(height: 24),
                  _buildUpdateSection(),
                  SizedBox(height: 24),
                  _buildLegalSection(),
                  SizedBox(height: 24),
                  _buildContactSection(),
                  SizedBox(height: 32),
                  _buildSocialMediaSection(),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      '© 2025 YourApp. All rights reserved.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: 
        Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background pattern
            CustomPaint(
              painter: BackgroundPatternPainter(
                baseColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
            ),
            // App logo
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.app_shortcut,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'YourApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Aplikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Versi', _appVersion),
            Divider(),
            _buildInfoRow('Build', _buildNumber),
            Divider(),
            _buildInfoRow('Tanggal Rilis', _releaseDate),
            Divider(),
            _buildInfoRow('Platform', 'Android & iOS'),
            Divider(),
            _buildInfoRow('Bahasa', 'Indonesia, English'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Misi Kami',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Text(
                'Menyediakan solusi digital terpadu untuk memudahkan kehidupan sehari-hari dengan teknologi yang inovatif, aman, dan mudah digunakan.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _isExpanded ? null : 0,
                child: Opacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  child: Text(
                    'Didirikan pada tahun 2020, YourApp telah berkomitmen untuk memberikan pengalaman digital terbaik bagi pengguna. Kami percaya bahwa teknologi harus mempermudah kehidupan, bukan mempersulit. Itulah mengapa kami terus berinovasi untuk membuat produk yang tidak hanya fungsional, tetapi juga intuitif dan menyenangkan untuk digunakan.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_isExpanded ? 'Tutup' : 'Baca Selengkapnya'),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tim Kami',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _teamMembers.length,
            itemBuilder: (context, index) {
              final member = _teamMembers[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: member['color'],
                      child: Text(
                        member['avatar'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      member['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      member['role'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Aman',
        'description': 'Keamanan data dan transaksi prioritas utama',
        'icon': Icons.security,
        'color': Colors.blue,
      },
      {
        'title': 'Cepat',
        'description': 'Proses transaksi instan dan responsif',
        'icon': Icons.speed,
        'color': Colors.green,
      },
      {
        'title': 'Mudah',
        'description': 'Antarmuka pengguna yang intuitif dan ramah',
        'icon': Icons.touch_app,
        'color': Colors.orange,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fitur Utama',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: List.generate(features.length, (index) {
            final feature = features[index];
            return Expanded(
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (feature['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: feature['color'] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        feature['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        feature['description'] as String,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildUpdateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pembaruan Terbaru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Versi ${_updates[0]['version']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Terbaru',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rilis: ${_updates[0]['date']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 12),
                ...(_updates[0]['highlights'] as List<String>).map((highlight) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          highlight,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    _showUpdateHistoryDialog();
                  },
                  child: Text('Lihat Semua Pembaruan'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Legal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildLegalItem(
                title: 'Kebijakan Privasi',
                icon: Icons.privacy_tip,
                onTap: () {
                  // Navigate to privacy policy
                },
              ),
              Divider(height: 1),
              _buildLegalItem(
                title: 'Syarat & Ketentuan',
                icon: Icons.assignment,
                onTap: () {
                  // Navigate to terms and conditions
                },
              ),
              Divider(height: 1),
              _buildLegalItem(
                title: 'Lisensi Aplikasi',
                icon: Icons.verified,
                onTap: () {
                  // Navigate to app license
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegalItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Kami',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildContactItem(
                  title: 'Email',
                  value: 'danantara@gmail.com',
                  icon: Icons.email,
                  onTap: () {
                    _copyToClipboard('danantara@gmail.com');
                  },
                ),
                Divider(),
                _buildContactItem(
                  title: 'Telepon',
                  value: '0894-184-0826',
                  icon: Icons.phone,
                  onTap: () {
                    _copyToClipboard('0894-184-0826');
                  },
                ),
                Divider(),
                _buildContactItem(
                  title: 'Website',
                  value: 'www.danantara.com',
                  icon: Icons.language,
                  onTap: () {
                    _copyToClipboard('www.danantara.com');
                  },
                ),
                Divider(),
                _buildContactItem(
                  title: 'Alamat',
                  value: 'Jl. Solo - Purwodadi KM.8, Selokaton, Gondangrejo, Karanganyar, Jawa Tengah.',
                  icon: Icons.location_on,
                  onTap: () {
                    _copyToClipboard('Jl. Solo - Purwodadi KM.8, Selokaton, Gondangrejo, Karanganyar, Jawa Tengah.');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.copy, size: 18),
          onPressed: onTap,
          color: Colors.grey.shade600,
          constraints: BoxConstraints(),
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  Widget _buildSocialMediaSection() {
    final List<Map<String, dynamic>> socialMedia = [
      {'name': 'Facebook', 'icon': Icons.facebook, 'color': Colors.blue.shade800},
      {'name': 'Twitter', 'icon': Icons.snapchat, 'color': Colors.blue.shade400},
      {'name': 'Instagram', 'icon': Icons.camera_alt, 'color': Colors.pink.shade400},
      {'name': 'YouTube', 'icon': Icons.play_circle_fill, 'color': Colors.red.shade600},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Media Sosial',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: socialMedia.map((social) => Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (social['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  social['icon'] as IconData,
                  color: social['color'] as Color,
                  size: 24,
                ),
              ),
              SizedBox(height: 4),
              Text(
                social['name'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          )).toList(),
        ),
      ],
    );
  }

  void _showUpdateHistoryDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Riwayat Pembaruan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: _updates.length,
                  separatorBuilder: (context, index) => Divider(height: 32),
                  itemBuilder: (context, index) {
                    final update = _updates[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Versi ${update['version']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            if (index == 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Terbaru',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Rilis: ${update['date']}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 12),
                        ...List.generate((update['highlights'] as List<String>).length, (highlightIndex) {
                          final highlight = (update['highlights'] as List<String>)[highlightIndex];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$text disalin ke clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// Custom painter for the background pattern
class BackgroundPatternPainter extends CustomPainter {
  final Color baseColor;
  
  BackgroundPatternPainter({required this.baseColor});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final double spacing = 20;
    
    // Draw diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
    
    // Draw circles
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    final random = math.Random(42); // Fixed seed for reproducibility
    
    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 10 + 2;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        circlePaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}