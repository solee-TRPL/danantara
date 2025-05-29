import 'package:flutter/material.dart';

class BayarScreen extends StatefulWidget {
  const BayarScreen({super.key});

  @override
  _BayarScreenState createState() => _BayarScreenState();
}

class _BayarScreenState extends State<BayarScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0;
  
  final List<Map<String, dynamic>> _merchants = [
    {
      'name': 'PLN',
      'category': 'Listrik',
      'icon': Icons.flash_on,
      'color': Colors.orange,
    },
    {
      'name': 'PDAM',
      'category': 'Air',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'name': 'Telkomsel',
      'category': 'Pulsa & Data',
      'icon': Icons.phone_android,
      'color': Colors.red,
    },
    {
      'name': 'XL Axiata',
      'category': 'Pulsa & Data',
      'icon': Icons.phone_android,
      'color': Colors.indigo,
    },
    {
      'name': 'Netflix',
      'category': 'Hiburan',
      'icon': Icons.movie,
      'color': Colors.red.shade800,
    },
    {
      'name': 'Spotify',
      'category': 'Hiburan',
      'icon': Icons.music_note,
      'color': Colors.green,
    },
    {
      'name': 'BPJS',
      'category': 'Asuransi',
      'icon': Icons.health_and_safety,
      'color': Colors.green.shade800,
    },
    {
      'name': 'Tokopedia',
      'category': 'E-Commerce',
      'icon': Icons.shopping_bag,
      'color': Colors.green,
    },
  ];
  
  final List<String> _categories = [
    'Semua',
    'Listrik',
    'Air',
    'Pulsa & Data',
    'Hiburan',
    'Asuransi',
    'E-Commerce',
  ];
  
  final List<Map<String, dynamic>> _recentPayments = [
    {
      'name': 'PLN',
      'date': '18 Apr 2025',
      'amount': 'Rp 250.000',
      'icon': Icons.flash_on,
      'color': Colors.orange,
    },
    {
      'name': 'Telkomsel',
      'date': '15 Apr 2025',
      'amount': 'Rp 100.000',
      'icon': Icons.phone_android,
      'color': Colors.red,
    },
    {
      'name': 'Netflix',
      'date': '10 Apr 2025',
      'amount': 'Rp 159.000',
      'icon': Icons.movie,
      'color': Colors.red.shade800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredMerchants = _merchants;
    
    if (_selectedTabIndex > 0) {
      final selectedCategory = _categories[_selectedTabIndex];
      filteredMerchants = _merchants.where(
        (merchant) => merchant['category'] == selectedCategory
      ).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bayar'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari layanan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                setState(() {
                  // Filter akan diterapkan jika implementasi pencarian
                });
              },
            ),
          ),
          
          // Category Tabs
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: 16),
          
          // Merchant Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Layanan Pembayaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredMerchants.length,
                    itemBuilder: (context, index) {
                      final merchant = filteredMerchants[index];
                      return GestureDetector(
                        onTap: () {
                          _showMerchantDetail(merchant);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: merchant['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                merchant['icon'],
                                color: merchant['color'],
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              merchant['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Recent Payments
                  Text(
                    'Pembayaran Terakhir',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _recentPayments.isEmpty
                        ? Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text('Belum ada riwayat pembayaran'),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _recentPayments.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              indent: 70,
                            ),
                            itemBuilder: (context, index) {
                              final payment = _recentPayments[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: payment['color'].withOpacity(0.2),
                                  child: Icon(
                                    payment['icon'],
                                    color: payment['color'],
                                    size: 20,
                                  ),
                                ),
                                title: Text(payment['name']),
                                subtitle: Text(payment['date']),
                                trailing: Text(
                                  payment['amount'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  // Show payment detail
                                },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showScanQR(context);
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _showMerchantDetail(Map<String, dynamic> merchant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: merchant['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      merchant['icon'],
                      color: merchant['color'],
                      size: 25,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        merchant['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        merchant['category'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Informasi Pelanggan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ID Pelanggan / Nomor',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Proses selanjutnya: cek tagihan dll
                    _showPaymentConfirmation(merchant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Lanjutkan',
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
        );
      },
    );
  }

  void _showPaymentConfirmation(Map<String, dynamic> merchant) {
    // Simulasi data tagihan
    final billDetails = {
      'customer': 'Ahmad Zainal',
      'id': '1234567890',
      'period': 'April 2025',
      'amount': 'Rp 350.000',
      'admin': 'Rp 2.500',
      'total': 'Rp 352.500',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: merchant['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    merchant['icon'],
                    color: merchant['color'],
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  merchant['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDetailRow('Nama', billDetails['customer']!),
            _buildDetailRow('ID Pelanggan', billDetails['id']!),
            _buildDetailRow('Periode', billDetails['period']!),
            _buildDetailRow('Tagihan', billDetails['amount']!),
            _buildDetailRow('Biaya Admin', billDetails['admin']!),
            Divider(),
            _buildDetailRow('Total', billDetails['total']!, isBold: true),
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
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Bayar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
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
        title: Text('Pembayaran Berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            SizedBox(height: 16),
            Text('Pembayaran Anda telah berhasil diproses'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Opsional: kembali ke halaman utama
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
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

  void _showScanQR(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Text(
                'Scan Kode QR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Arahkan kamera ke kode QR untuk melakukan pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Batal'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}