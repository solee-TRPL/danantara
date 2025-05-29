import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Membuka Pengaturan'))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 24),
            _buildAccountSection(),
            SizedBox(height: 16),
            _buildPreferencesSection(),
            SizedBox(height: 16),
            _buildSupportSection(),
            SizedBox(height: 24),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Nama Pengguna',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'user@example.com',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            // Edit profile action
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Profil'),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Divider(
              indent: 16,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Akun'),
        _buildMenuItem(
          icon: Icons.credit_card,
          title: 'Informasi Pembayaran',
          subtitle: 'Kelola metode pembayaran Anda',
        ),
        _buildMenuItem(
          icon: Icons.vpn_key,
          title: 'Keamanan',
          subtitle: 'Ubah password dan pengaturan keamanan',
        ),
        _buildMenuItem(
          icon: Icons.verified_user,
          title: 'Verifikasi Identitas',
          subtitle: 'Verifikasi identitas Anda',
          status: 'Terverifikasi',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Preferensi'),
        _buildMenuItem(
          icon: Icons.notifications,
          title: 'Notifikasi',
          subtitle: 'Kelola pengaturan notifikasi',
        ),
        _buildMenuItem(
          icon: Icons.language,
          title: 'Bahasa',
          subtitle: 'Pilih bahasa aplikasi',
          trailing: 'Indonesia',
        ),
        _buildMenuItem(
          icon: Icons.dark_mode,
          title: 'Tema Gelap',
          isSwitch: true,
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Dukungan'),
        _buildMenuItem(
          icon: Icons.help,
          title: 'Pusat Bantuan',
          subtitle: 'Dapatkan jawaban atas pertanyaan Anda',
        ),
        _buildMenuItem(
          icon: Icons.headset_mic,
          title: 'Hubungi Customer Service',
          subtitle: 'Bantuan 24/7',
        ),
        _buildMenuItem(
          icon: Icons.info,
          title: 'Tentang Aplikasi',
          subtitle: 'Informasi versi dan legalitas',
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailing,
    String? status,
    Color? statusColor,
    bool isSwitch = false,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: isSwitch
          ? Switch(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.blue,
            )
          : status != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor?.withOpacity(0.1) ?? Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor ?? Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : trailing != null
                  ? Text(
                      trailing,
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  : Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle menu item tap
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Logout action
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Keluar'),
              content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Perform logout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Ya, Keluar'),
                ),
              ],
            ),
          );
        },
        icon: Icon(Icons.exit_to_app),
        label: Text('Keluar'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}