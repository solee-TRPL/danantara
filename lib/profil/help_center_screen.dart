import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // List of FAQ categories
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Akun & Profil',
      'icon': Icons.person,
      'color': Colors.blue,
    },
    {
      'title': 'Pembayaran',
      'icon': Icons.payment,
      'color': Colors.green,
    },
    {
      'title': 'Keamanan',
      'icon': Icons.security,
      'color': Colors.orange,
    },
    {
      'title': 'Transaksi',
      'icon': Icons.receipt,
      'color': Colors.purple,
    },
    {
      'title': 'Layanan',
      'icon': Icons.design_services,
      'color': Colors.red,
    },
    {
      'title': 'Lainnya',
      'icon': Icons.more_horiz,
      'color': Colors.teal,
    },
  ];

  // List of FAQ items
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'Bagaimana cara mengubah nomor telepon?',
      'answer': 'Untuk mengubah nomor telepon, silakan buka menu Profil > Keamanan > Pilih opsi "Ubah Nomor Telepon". Anda perlu memverifikasi identitas dengan kode OTP yang dikirimkan ke nomor lama sebelum menambahkan nomor baru.',
      'category': 'Akun & Profil',
      'isExpanded': false,
    },
    {
      'question': 'Metode pembayaran apa saja yang tersedia?',
      'answer': 'Kami mendukung berbagai metode pembayaran termasuk kartu kredit/debit, transfer bank, e-wallet seperti GoPay, OVO, DANA, dan pembayaran melalui minimarket. Untuk melihat daftar lengkap, silakan kunjungi halaman Metode Pembayaran di aplikasi.',
      'category': 'Pembayaran',
      'isExpanded': false,
    },
    {
      'question': 'Bagaimana cara mengaktifkan verifikasi dua langkah?',
      'answer': 'Untuk mengaktifkan verifikasi dua langkah, buka menu Profil > Keamanan > Verifikasi Dua Langkah. Anda dapat memilih metode verifikasi melalui SMS atau aplikasi autentikator seperti Google Authenticator.',
      'category': 'Keamanan',
      'isExpanded': false,
    },
    {
      'question': 'Berapa lama waktu yang dibutuhkan untuk proses verifikasi akun?',
      'answer': 'Proses verifikasi akun biasanya membutuhkan waktu 1-3 hari kerja setelah semua dokumen yang dibutuhkan diunggah dengan benar. Anda akan menerima notifikasi saat proses verifikasi selesai.',
      'category': 'Akun & Profil',
      'isExpanded': false,
    },
    {
      'question': 'Bagaimana jika transaksi saya gagal tetapi saldo terpotong?',
      'answer': 'Jika transaksi Anda gagal tetapi saldo terpotong, biasanya dana akan otomatis dikembalikan dalam waktu 24 jam. Jika setelah 24 jam dana belum kembali, silakan hubungi tim dukungan kami dengan menyertakan bukti transaksi dan detail lengkap.',
      'category': 'Transaksi',
      'isExpanded': false,
    },
    {
      'question': 'Apa yang harus dilakukan jika lupa kata sandi?',
      'answer': 'Jika Anda lupa kata sandi, klik opsi "Lupa Kata Sandi" pada halaman login. Ikuti petunjuk untuk melakukan reset kata sandi melalui email atau nomor telepon yang terdaftar pada akun Anda.',
      'category': 'Keamanan',
      'isExpanded': false,
    },
  ];

  List<Map<String, dynamic>> _filteredFaqs = [];
  String _selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    _filteredFaqs = List.from(_faqs);
  }

  void _filterFaqs(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory == 'Semua') {
        _filteredFaqs = List.from(_faqs);
      } else {
        _filteredFaqs = _faqs.where((faq) {
          final matchesQuery = query.isEmpty || 
                              faq['question'].toLowerCase().contains(query.toLowerCase()) ||
                              faq['answer'].toLowerCase().contains(query.toLowerCase());
          
          final matchesCategory = _selectedCategory == 'Semua' || 
                                faq['category'] == _selectedCategory;
          
          return matchesQuery && matchesCategory;
        }).toList();
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterFaqs(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with search
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai, ada yang bisa kami bantu?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterFaqs,
                    decoration: InputDecoration(
                      hintText: 'Cari pertanyaan atau topik',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Categories
          Container(
            height: 100,
            color: Colors.grey.shade100,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryItem('Semua', Icons.grid_view, Colors.grey.shade700),
                ..._categories.map((category) => _buildCategoryItem(
                  category['title'],
                  category['icon'],
                  category['color'],
                )),
              ],
            ),
          ),
          
          // FAQs
          Expanded(
            child: _filteredFaqs.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _filteredFaqs.length,
                    itemBuilder: (context, index) {
                      final faq = _filteredFaqs[index];
                      return _buildFaqItem(faq, index);
                    },
                  ),
          ),
          
          // Contact support button
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showContactOptions();
                    },
                    icon: Icon(Icons.support_agent),
                    label: Text('Hubungi Tim Dukungan'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    final isSelected = _selectedCategory == title;
    
    return GestureDetector(
      onTap: () => _selectCategory(title),
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(Map<String, dynamic> faq, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: faq['isExpanded'] as bool,
        onExpansionChanged: (expanded) {
          setState(() {
            _filteredFaqs[index]['isExpanded'] = expanded;
          });
        },
        title: Text(
          faq['question'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            faq['category'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  faq['answer'],
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Apakah jawaban ini membantu?',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up, size: 16),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Terima kasih atas umpan balik Anda!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(8),
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_down, size: 16),
                          onPressed: () {
                            _showFeedbackDialog();
                          },
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada hasil ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba gunakan kata kunci lain atau hubungi dukungan kami',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactOptions() {
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
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pilih metode kontak yang Anda inginkan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            _buildContactOption(
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Biasanya membalas dalam 5 menit',
              onTap: () {
                Navigator.pop(context);
                // Navigate to live chat
              },
            ),
            Divider(),
            _buildContactOption(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'support@example.com',
              onTap: () {
                Navigator.pop(context);
                // Open email app
              },
            ),
            Divider(),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Telepon',
              subtitle: '0800-123-4567 (Gratis)',
              onTap: () {
                Navigator.pop(context);
                // Make phone call
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showFeedbackDialog() {
    final TextEditingController feedbackController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bantu Kami Meningkatkan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Maaf jawaban kami tidak membantu. Mohon beri tahu kami bagaimana kami dapat meningkatkan.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: 'Umpan Balik',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
                  content: Text('Terima kasih atas umpan balik Anda!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }
}