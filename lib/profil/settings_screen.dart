import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _darkMode = false;
  bool _biometricAuth = false;
  String _selectedLanguage = 'Indonesian';
  double _fontScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Account Settings Section
          _buildSectionHeader('Pengaturan Akun'),
          _buildListTile(
            title: 'Edit Profil',
            subtitle: 'Ubah nama, foto, dan info lainnya',
            leading: Icons.person_outline,
            onTap: () {
              // Navigate to edit profile
              _showEditProfileSheet(context);
            },
          ),
          _buildListTile(
            title: 'Alamat Tersimpan',
            subtitle: 'Kelola alamat tersimpan Anda',
            leading: Icons.location_on_outlined,
            onTap: () {
              // Navigate to saved addresses
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedAddressesScreen()),
              );
            },
          ),
          _buildListTile(
            title: 'Privasi Akun',
            subtitle: 'Atur siapa yang dapat melihat info Anda',
            leading: Icons.lock_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacySettingsScreen()),
              );
            },
          ),

          Divider(height: 32),

          // App Settings Section
          _buildSectionHeader('Pengaturan Aplikasi'),
          _buildSwitchTile(
            title: 'Notifikasi Push',
            subtitle: 'Terima pemberitahuan dari aplikasi',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          if (_notificationsEnabled) ...[
            _buildSwitchTile(
              title: 'Notifikasi Email',
              subtitle: 'Terima info melalui email',
              value: _emailNotifications,
              onChanged: (value) {
                setState(() => _emailNotifications = value);
              },
              indent: true,
            ),
            _buildSwitchTile(
              title: 'Notifikasi SMS',
              subtitle: 'Terima info melalui SMS',
              value: _smsNotifications,
              onChanged: (value) {
                setState(() => _smsNotifications = value);
              },
              indent: true,
            ),
          ],
          _buildListTile(
            title: 'Suara & Getaran',
            subtitle: 'Atur nada dan getaran notifikasi',
            leading: Icons.volume_up_outlined,
            onTap: () {
              _showSoundSettingsDialog(context);
            },
          ),

          Divider(height: 32),

          // Display Settings Section
          _buildSectionHeader('Tampilan'),
          _buildSwitchTile(
            title: 'Mode Gelap',
            subtitle: 'Aktifkan tema gelap',
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              // Apply theme change
            },
          ),
          _buildListTile(
            title: 'Bahasa',
            subtitle: _selectedLanguage,
            leading: Icons.language,
            onTap: () {
              _showLanguageSelector(context);
            },
          ),
          _buildListTile(
            title: 'Ukuran Teks',
            subtitle: 'Atur ukuran font',
            leading: Icons.text_fields,
            onTap: () {
              _showFontSizeDialog(context);
            },
          ),

          Divider(height: 32),

          // Security Settings Section
          _buildSectionHeader('Keamanan'),
          _buildSwitchTile(
            title: 'Autentikasi Biometrik',
            subtitle: 'Gunakan sidik jari atau Face ID',
            value: _biometricAuth,
            onChanged: (value) {
              setState(() => _biometricAuth = value);
              // Configure biometric auth
            },
          ),
          _buildListTile(
            title: 'Aktivitas Login',
            subtitle: 'Lihat riwayat login Anda',
            leading: Icons.history,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginActivityScreen()),
              );
            },
          ),
          _buildListTile(
            title: 'Perangkat Terpercaya',
            subtitle: 'Kelola perangkat yang diizinkan',
            leading: Icons.devices,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrustedDevicesScreen()),
              );
            },
          ),

          Divider(height: 32),

          // Data & Storage Section
          _buildSectionHeader('Data & Penyimpanan'),
          _buildListTile(
            title: 'Hapus Cache',
            subtitle: '328 MB terpakai',
            leading: Icons.cleaning_services_outlined,
            onTap: () {
              _showClearCacheDialog(context);
            },
          ),
          _buildListTile(
            title: 'Unduh Data Saya',
            subtitle: 'Dapatkan salinan data Anda',
            leading: Icons.download_outlined,
            onTap: () {
              // Handle data download request
            },
          ),
          _buildListTile(
            title: 'Hapus Akun',
            subtitle: 'Hapus permanen akun Anda',
            leading: Icons.delete_forever_outlined,
            onTap: () {
              _showDeleteAccountDialog(context);
            },
            trailing: Icon(Icons.warning_amber_rounded, color: Colors.red),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData leading,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(leading, color: Theme.of(context).colorScheme.primary),
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    bool indent = false,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: indent ? EdgeInsets.only(left: 72, right: 16) : null,
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Profil',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: 'Ahmad Budi'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: 'ahmad.budi@email.com'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: '0812 3456 7890'),
                enabled: false,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil berhasil diperbarui')),
                    );
                  },
                  child: Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    final languages = [
      'Indonesian',
      'English',
      'Malay',
      'Arabic',
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Pilih Bahasa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...languages.map((language) => ListTile(
              title: Text(language),
              leading: Radio<String>(
                value: language,
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() => _selectedLanguage = value!);
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                setState(() => _selectedLanguage = language);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ukuran Teks'),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contoh Teks',
                style: TextStyle(fontSize: 16 * _fontScale),
              ),
              SizedBox(height: 16),
              Slider(
                value: _fontScale,
                min: 0.8,
                max: 1.5,
                divisions: 7,
                label: '${(_fontScale * 100).round()}%',
                onChanged: (value) {
                  setDialogState(() => _fontScale = value);
                  setState(() => _fontScale = value);
                },
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kecil'),
                  Text('Besar'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Apply font scale
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showSoundSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Suara & Getaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Suara Notifikasi'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Getaran'),
              value: true,
              onChanged: (value) {},
            ),
            ListTile(
              title: Text('Nada Notifikasi'),
              subtitle: Text('Default'),
              onTap: () {
                // Show ringtone picker
              },
            ),
          ],
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

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Cache'),
        content: Text('Ini akan menghapus 328 MB data cache. Aplikasi mungkin akan memuat lebih lambat untuk sementara waktu.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cache berhasil dihapus')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Akun'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anda yakin ingin menghapus akun?'),
            SizedBox(height: 16),
            Text(
              'Tindakan ini akan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Menghapus semua data Anda'),
            Text('• Membatalkan semua transaksi aktif'),
            Text('• Tidak dapat dibatalkan'),
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
              // Show confirmation screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Hapus Akun'),
          ),
        ],
      ),
    );
  }
}

// Additional screens referenced in settings
class SavedAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Tersimpan'),
      ),
      body: ListView(
        children: [
          _buildAddressCard(
            context,
            'Rumah',
            'Jl. Merdeka No. 123, RT 01/RW 02, Kelurahan Sukamaju, Kecamatan Medan Timur, Kota Medan, 20234',
            isDefault: true,
          ),
          _buildAddressCard(
            context,
            'Kantor',
            'Gedung Perkantoran ABC, Lt. 5, Jl. Sudirman No. 45, Medan',
            isDefault: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new address
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, String label, String address, {bool isDefault = false}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
        title: Row(
          children: [
            Text(label),
            if (isDefault) ...[
              SizedBox(width: 8),
              Chip(
                label: Text('Default', style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.green.shade50,
                side: BorderSide(color: Colors.green.shade200),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ],
        ),
        subtitle: Text(address),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Show options menu
          },
        ),
      ),
    );
  }
}

class PrivacySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Privasi'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Profil Publik'),
            subtitle: Text('Izinkan orang lain melihat profil Anda'),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: Text('Riwayat Aktivitas'),
            subtitle: Text('Simpan riwayat aktivitas di aplikasi'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: Text('Personalisasi'),
            subtitle: Text('Gunakan data untuk rekomendasi'),
            value: true,
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('Blokir Pengguna'),
            subtitle: Text('Kelola daftar pengguna yang diblokir'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class LoginActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivitas Login'),
      ),
      body: ListView(
        children: [
          _buildLoginItem(
            'iPhone 14 Pro',
            'Medan, Indonesia',
            'Aktif sekarang',
            isCurrentDevice: true,
          ),
          _buildLoginItem(
            'Samsung Galaxy S23',
            'Jakarta, Indonesia',
            '2 jam yang lalu',
          ),
          _buildLoginItem(
            'Windows PC',
            'Surabaya, Indonesia',
            'Kemarin, 15:30',
          ),
        ],
      ),
    );
  }

  Widget _buildLoginItem(String device, String location, String time, {bool isCurrentDevice = false}) {
    return ListTile(
      leading: Icon(
        isCurrentDevice ? Icons.phone_android : Icons.devices_other,
        color: isCurrentDevice ? Colors.green : null,
      ),
      title: Text(device),
      subtitle: Text('$location • $time'),
      trailing: isCurrentDevice
          ? Chip(
              label: Text('Perangkat ini'),
              backgroundColor: Colors.green.shade50,
            )
          : TextButton(
              onPressed: () {
                // Logout from device
              },
              child: Text('Keluar'),
            ),
    );
  }
}

class TrustedDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perangkat Terpercaya'),
      ),
      body: ListView(
        children: [
          _buildDeviceItem(
            'iPhone 14 Pro',
            'Ditambahkan 3 bulan lalu',
            isCurrentDevice: true,
          ),
          _buildDeviceItem(
            'Samsung Galaxy S23',
            'Ditambahkan 1 bulan lalu',
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(String device, String addedDate, {bool isCurrentDevice = false}) {
    return ListTile(
      leading: Icon(Icons.smartphone),
      title: Text(device),
      subtitle: Text(addedDate),
      trailing: isCurrentDevice
          ? Chip(
              label: Text('Perangkat ini'),
              backgroundColor: Colors.blue.shade50,
            )
          : TextButton(
              onPressed: () {
                // Remove device
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
    );
  }
}