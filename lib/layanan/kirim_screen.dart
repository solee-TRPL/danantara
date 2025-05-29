import 'package:flutter/material.dart';

class KirimScreen extends StatefulWidget {
  const KirimScreen({super.key});

  @override
  _KirimScreenState createState() => _KirimScreenState();
}

class _KirimScreenState extends State<KirimScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  final List<Map<String, dynamic>> _recentContacts = [
    {
      'name': 'Budi Santoso',
      'phone': '081234567890',
      'avatar': 'B',
      'color': Colors.blue,
    },
    {
      'name': 'Ani Wijaya',
      'phone': '089876543210',
      'avatar': 'A',
      'color': Colors.green,
    },
    {
      'name': 'Deni Prakoso',
      'phone': '087812345678',
      'avatar': 'D',
      'color': Colors.orange,
    },
    {
      'name': 'Sari Indah',
      'phone': '082198765432',
      'avatar': 'S',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Uang'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kontak Terakhir
            Text(
              'Kontak Terakhir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildRecentContacts(),
            SizedBox(height: 24),
            
            // Form Kirim Uang
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kirim ke',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    // Nomor telepon penerima
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    
                    // Jumlah uang
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Jumlah (Rp)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    
                    // Catatan (opsional)
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: 'Catatan (Opsional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Tombol Kirim
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Lakukan validasi dan proses pengiriman
                          _showConfirmationDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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

  Widget _buildRecentContacts() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recentContacts.length,
        itemBuilder: (context, index) {
          final contact = _recentContacts[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _phoneController.text = contact['phone'];
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: contact['color'],
                    child: Text(
                      contact['avatar'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    contact['name'],
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog() {
    if (_phoneController.text.isEmpty || _amountController.text.isEmpty) {
      // Tampilkan error jika ada field yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nomor telepon dan jumlah harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Pengiriman'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kirim ke: ${_phoneController.text}'),
            SizedBox(height: 8),
            Text('Jumlah: Rp ${_amountController.text}'),
            if (_noteController.text.isNotEmpty) ...[
              SizedBox(height: 8),
              Text('Catatan: ${_noteController.text}'),
            ],
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
              // Proses pengiriman
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Konfirmasi',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pengiriman Berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            SizedBox(height: 16),
            Text('Dana telah berhasil dikirim ke ${_phoneController.text}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Kembali ke home screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Selesai',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}