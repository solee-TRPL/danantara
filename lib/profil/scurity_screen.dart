import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _isPinEnabled = true;
  bool _isBiometricEnabled = true;
  bool _isNotificationEnabled = true;
  bool _isDeviceTrackingEnabled = false;
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keamanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status Keamanan',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'TERLINDUNGI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 8,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tingkat keamanan akun Anda saat ini: Tinggi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Aktifkan semua fitur keamanan untuk perlindungan maksimal',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              Text(
                'Pengaturan Keamanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              
              // Security Settings
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSecurityToggleItem(
                      title: 'PIN Keamanan',
                      subtitle: 'Gunakan PIN 6 digit untuk melindungi akun',
                      icon: Icons.pin,
                      isEnabled: _isPinEnabled,
                      onChanged: (value) => setState(() => _isPinEnabled = value),
                      onTap: () => _showPinChangeDialog(),
                    ),
                    Divider(height: 1),
                    _buildSecurityToggleItem(
                      title: 'Biometrik',
                      subtitle: 'Gunakan sidik jari atau Face ID untuk login',
                      icon: Icons.fingerprint,
                      isEnabled: _isBiometricEnabled,
                      onChanged: (value) => setState(() => _isBiometricEnabled = value),
                    ),
                    Divider(height: 1),
                    _buildSecurityToggleItem(
                      title: 'Notifikasi Login',
                      subtitle: 'Dapatkan peringatan saat akun Anda diakses',
                      icon: Icons.notifications_active,
                      isEnabled: _isNotificationEnabled,
                      onChanged: (value) => setState(() => _isNotificationEnabled = value),
                    ),
                    Divider(height: 1),
                    _buildSecurityToggleItem(
                      title: 'Lacak Perangkat',
                      subtitle: 'Melihat daftar perangkat yang aktif',
                      icon: Icons.devices,
                      isEnabled: _isDeviceTrackingEnabled,
                      onChanged: (value) => setState(() => _isDeviceTrackingEnabled = value),
                      onTap: () => _showDeviceListDialog(),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              Text(
                'Tindakan Keamanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              
              // Security Actions
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSecurityActionItem(
                      title: 'Ubah Kata Sandi',
                      subtitle: 'Perbarui kata sandi akun Anda',
                      icon: Icons.password,
                      onTap: () => _showChangePasswordDialog(),
                    ),
                    Divider(height: 1),
                    _buildSecurityActionItem(
                      title: 'Verifikasi Dua Langkah',
                      subtitle: 'Tambahkan lapisan keamanan ekstra',
                      icon: Icons.verified_user,
                      onTap: () => _showTwoFactorAuthDialog(),
                    ),
                    Divider(height: 1),
                    _buildSecurityActionItem(
                      title: 'Keluarkan Semua Perangkat',
                      subtitle: 'Logout dari semua perangkat yang terhubung',
                      icon: Icons.logout,
                      onTap: () => _showLogoutAllDevicesDialog(),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Security Tips
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber.shade700),
                        SizedBox(width: 8),
                        Text(
                          'Tips Keamanan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Gunakan kata sandi yang kuat dengan kombinasi huruf, angka, dan simbol\n'
                      '• Aktifkan verifikasi dua langkah untuk keamanan ekstra\n'
                      '• Jangan berbagi informasi sensitif dengan siapapun\n'
                      '• Periksa riwayat login secara berkala',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityToggleItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isEnabled,
    required Function(bool) onChanged,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isEnabled
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isEnabled
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  size: 22,
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
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: onChanged,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityActionItem({
    required String title,
    required String subtitle,
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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
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
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
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

  void _showPinChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ubah PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'PIN Saat Ini',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'PIN Baru',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Konfirmasi PIN Baru',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('PIN berhasil diubah'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDeviceListDialog() {
    final devices = [
      {'name': 'Samsung Galaxy S22', 'lastActive': 'Aktif sekarang', 'isCurrentDevice': true},
      {'name': 'iPhone 13 Pro', 'lastActive': 'Aktif 2 jam lalu', 'isCurrentDevice': false},
      {'name': 'Xiaomi Pad 5', 'lastActive': 'Aktif 3 hari lalu', 'isCurrentDevice': false},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Perangkat Aktif'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: devices.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final device = devices[index];
              return ListTile(
                leading: Icon(
                  Icons.smartphone,
                  color: device['isCurrentDevice'] == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                title: Text(
                  device['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(device['lastActive'] as String),
                trailing: device['isCurrentDevice'] == true
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Saat ini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text('Keluarkan'),
                      ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ubah Kata Sandi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Kata Sandi Saat Ini',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Kata Sandi Baru',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Konfirmasi Kata Sandi Baru',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kata sandi berhasil diubah'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showTwoFactorAuthDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Verifikasi Dua Langkah'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 100,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pindai kode QR ini dengan aplikasi autentikator Anda, seperti Google Authenticator atau Authy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Kode Verifikasi',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Verifikasi dua langkah berhasil diaktifkan'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Aktifkan'),
          ),
        ],
      ),
    );
  }

  void _showLogoutAllDevicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Keluarkan Semua Perangkat'),
        content: Text(
          'Apakah Anda yakin ingin mengeluarkan semua perangkat yang terhubung dengan akun Anda? Anda perlu login kembali setelah melakukan ini.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Semua perangkat berhasil dikeluarkan'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(
              'Keluarkan Semua',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}