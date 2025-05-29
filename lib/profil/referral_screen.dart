import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _referralCode = "AHMAD2025";
  
  final List<Map<String, dynamic>> _referralHistory = [
    {
      'name': 'Budi Santoso',
      'date': '20 Apr 2025',
      'status': 'Sukses',
      'reward': 'Rp 50.000',
      'avatar': 'B',
      'color': Colors.blue,
    },
    {
      'name': 'Dewi Lestari',
      'date': '15 Apr 2025',
      'status': 'Sukses',
      'reward': 'Rp 50.000',
      'avatar': 'D',
      'color': Colors.purple,
    },
    {
      'name': 'Eko Prasetyo',
      'date': '10 Apr 2025',
      'status': 'Sukses',
      'reward': 'Rp 50.000',
      'avatar': 'E',
      'color': Colors.green,
    },
    {
      'name': 'Fajar Nugroho',
      'date': '05 Apr 2025',
      'status': 'Dalam Proses',
      'reward': 'Menunggu',
      'avatar': 'F',
      'color': Colors.amber,
    },
  ];

  final List<Map<String, dynamic>> _rewards = [
    {
      'title': 'Bonus Tunai',
      'description': 'Dapatkan Rp 50.000 untuk setiap teman yang bergabung',
      'icon': Icons.attach_money,
      'color': Colors.green,
    },
    {
      'title': 'Kupon Diskon',
      'description': 'Kupon diskon 10% untuk setiap 3 referral sukses',
      'icon': Icons.local_offer,
      'color': Colors.orange,
    },
    {
      'title': 'Poin Loyalitas',
      'description': '500 poin untuk setiap referral sukses',
      'icon': Icons.stars,
      'color': Colors.purple,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Referral'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with stats
          _buildReferralHeader(),
          
          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'Informasi'),
                Tab(text: 'Riwayat Referral'),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(),
                _buildHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.indigo.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Undang Teman, Dapatkan Hadiah',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Bagikan kode referral Anda dan dapatkan bonus',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 24),
          
          // Referral stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Total Referral',
                  value: '4',
                  icon: Icons.people,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Reward Diterima',
                  value: 'Rp 150.000',
                  icon: Icons.card_giftcard,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Referral code
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kode Referral Anda',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _referralCode,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _referralCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kode referral disalin!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.copy),
                  label: Text('Salin'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // How it works
            Text(
              'Cara Kerja Program Referral',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            // Steps
            _buildStep(
              number: '1',
              title: 'Bagikan Kode Referral',
              description: 'Bagikan kode referral Anda kepada teman dan keluarga',
              icon: Icons.share,
            ),
            _buildStepConnector(),
            _buildStep(
              number: '2',
              title: 'Teman Mendaftar',
              description: 'Teman Anda mendaftar dan memasukkan kode referral Anda',
              icon: Icons.app_registration,
            ),
            _buildStepConnector(),
            _buildStep(
              number: '3',
              title: 'Teman Melakukan Transaksi',
              description: 'Teman Anda menyelesaikan transaksi pertama',
              icon: Icons.shopping_cart_checkout,
            ),
            _buildStepConnector(),
            _buildStep(
              number: '4',
              title: 'Dapatkan Hadiah',
              description: 'Anda dan teman Anda masing-masing mendapatkan bonus',
              icon: Icons.redeem,
            ),
            
            SizedBox(height: 32),
            
            // Rewards
            Text(
              'Hadiah yang Bisa Didapatkan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            // Reward cards
            ...List.generate(_rewards.length, (index) => _buildRewardCard(_rewards[index])),
            
            SizedBox(height: 32),
            
            // Share button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showShareOptions();
                },
                icon: Icon(Icons.share),
                label: Text('Bagikan Kode Referral'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Terms
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Syarat & Ketentuan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Teman Anda harus pengguna baru yang belum pernah mendaftar sebelumnya\n'
                    '• Bonus akan diterima setelah teman Anda melakukan transaksi pertama\n'
                    '• Bonus akan dikirim dalam waktu 1-3 hari kerja\n'
                    '• Program referral berlaku hingga 31 Desember 2025\n'
                    '• Perusahaan berhak mengubah syarat & ketentuan sewaktu-waktu',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Colors.grey.shade800,
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

  Widget _buildHistoryTab() {
    return _referralHistory.isEmpty
        ? _buildEmptyHistory()
        : ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: _referralHistory.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final history = _referralHistory[index];
              return _buildHistoryItem(history);
            },
          );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada riwayat referral',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bagikan kode referral Anda untuk mulai mengundang teman',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _showShareOptions();
            },
            icon: Icon(Icons.share),
            label: Text('Bagikan Sekarang'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      height: 30,
      width: 1,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> reward) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: (reward['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (reward['color'] as Color).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              reward['icon'] as IconData,
              color: reward['color'] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  reward['description'] as String,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    final bool isSuccess = history['status'] == 'Sukses';
    
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: history['color'] as Color,
          radius: 20,
          child: Text(
            history['avatar'] as String,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                history['date'] as String,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                history['status'] as String,
                style: TextStyle(
                  color: isSuccess ? Colors.green : Colors.amber.shade800,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              history['reward'] as String,
              style: TextStyle(
                fontWeight: isSuccess ? FontWeight.bold : FontWeight.normal,
                color: isSuccess ? Colors.black : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bagikan Kode Referral',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pilih platform untuk membagikan kode referral Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(
                  icon: Icons.chat,
                  title: 'WhatsApp',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  icon: Icons.mail,
                  title: 'Email',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  icon: Icons.sms,
                  title: 'SMS',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  icon: Icons.more_horiz,
                  title: 'Lainnya',
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Pesan Referral',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Halo! Saya mengundangmu untuk bergabung dengan aplikasi ini. Gunakan kode referral saya $_referralCode untuk mendapatkan bonus Rp 50.000! Unduh sekarang di www.example.com/app',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: 'Halo! Saya mengundangmu untuk bergabung dengan aplikasi ini. Gunakan kode referral saya $_referralCode untuk mendapatkan bonus Rp 50.000! Unduh sekarang di www.example.com/app',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pesan referral disalin!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.copy, size: 16),
                    label: Text('Salin Pesan'),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
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

  Widget _buildShareOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}