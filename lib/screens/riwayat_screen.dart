import 'package:flutter/material.dart';
import 'home_screen.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        // Header yang akan tetap terlihat ketika scroll
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            // AppBar
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.blue[700],
              title: Text('Riwayat Transaksi',style: TextStyle(color: Colors.white)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              ),
              pinned: true, // AppBar tetap terlihat saat scroll
              actions: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.search_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cari transaksi'))
                    );
                  },
                ),
              ],
            ),
            
            // Header statistik ringkas yang tetap terlihat saat scroll
            SliverPersistentHeader(
              pinned: true, // Header tetap terlihat saat scroll
              delegate: _SummaryHeaderDelegate(
                minHeight: 80,
                maxHeight: 80,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem(
                        context,
                        'Pemasukan',
                        'Rp 2.500.000',
                        Icons.arrow_downward_rounded,
                        Colors.green,
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildSummaryItem(
                        context,
                        'Pengeluaran',
                        'Rp 1.750.000',
                        Icons.arrow_upward_rounded,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Tab bar filter periode yang tetap terlihat saat scroll
            SliverPersistentHeader(
              pinned: true, // Tab bar tetap terlihat saat scroll
              delegate: _TabBarHeaderDelegate(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DefaultTabController(
                      length: 3,
                      child: TabBar(
                        indicatorColor: Colors.blue[700],
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.blue[700],
                        unselectedLabelColor: Colors.grey[600],
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        tabs: [
                          Tab(text: 'Hari Ini'),
                          Tab(text: 'Minggu Ini'),
                          Tab(text: 'Bulan Ini'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        
        // Daftar transaksi (konten utama)
        body: ListView.builder(
          padding: EdgeInsets.only(top: 12, bottom: 16),
          itemCount: 10,
          itemBuilder: (context, index) {
            // Menambahkan header tanggal jika transaksi di hari berbeda
            bool showDateHeader = index == 0 || index == 3 || index == 7;
            String dateHeader = index == 0 
                ? '20 April 2025' 
                : index == 3 
                    ? '19 April 2025' 
                    : '18 April 2025';
            
            // Demo data untuk riwayat transaksi
            bool isIncoming = index % 3 == 0;
            bool isPending = index % 5 == 0;
            String title = isIncoming ? 'Terima dari Ahmad' : 'Kirim ke Budi';
            String date = '${20 - (index % 3)} April 2025';
            double amount = (index + 1) * 50000.0;
            
            // Data tambahan untuk detail transaksi
            String transactionId = 'TRX${1000 + index}';
            String description = isIncoming 
                ? 'Menerima dana dari Ahmad ${index % 2 == 0 ? 'untuk pembayaran proyek' : 'sebagai pengembalian pinjaman'}' 
                : 'Mengirim dana ke Budi ${index % 2 == 0 ? 'untuk keperluan kantor' : 'sebagai bantuan biaya pendidikan'}';
            String category = isIncoming ? 'Penerimaan' : 'Pengiriman';
            String paymentMethod = isIncoming ? 'Direct Transfer' : 'Saldo DigiWallet';
            
            // Icon berdasarkan kategori
            IconData transactionIcon = _getTransactionIcon(index, isIncoming);
            Color iconColor = isIncoming ? Colors.green : Colors.orange;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header tanggal jika dibutuhkan
                if (showDateHeader)
                  Padding(
                    padding: EdgeInsets.only(left: 24, top: 16, bottom: 8),
                    child: Text(
                      dateHeader,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    ),
                  ),
                
                // Item transaksi
                TransactionListItem(
                  title: title,
                  date: date,
                  amount: amount,
                  isIncoming: isIncoming,
                  isPending: isPending,
                  transactionId: transactionId,
                  description: description,
                  category: category,
                  paymentMethod: paymentMethod,
                  time: '${(index % 12) + 1}:${(index * 7) % 60 < 10 ? '0' : ''}${(index * 7) % 60} ${index % 2 == 0 ? 'AM' : 'PM'}',
                  transactionIcon: transactionIcon,
                  iconColor: iconColor,
                ),
              ],
            );
          },
        ),
      ),
      // Tombol floating untuk pencarian lanjutan atau filter
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Implementasi untuk pencarian lanjutan
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Pencarian lanjutan'))
      //     );
      //   },
      //   backgroundColor: Colors.blue[700],
      //   icon: Icon(Icons.filter_alt_rounded),
      //   label: Text('Filter'),
      // ),
    );
  }
  
  // Menentukan icon berdasarkan jenis transaksi
  IconData _getTransactionIcon(int index, bool isIncoming) {
    if (isIncoming) {
      List<IconData> incomingIcons = [
        Icons.arrow_downward_rounded,
        Icons.payment_rounded,
        Icons.account_balance_rounded,
        Icons.attach_money_rounded
      ];
      return incomingIcons[index % incomingIcons.length];
    } else {
      List<IconData> outgoingIcons = [
        Icons.arrow_upward_rounded,
        Icons.shopping_cart_rounded,
        Icons.local_mall_rounded,
        Icons.fastfood_rounded,
        Icons.directions_car_rounded,
      ];
      return outgoingIcons[index % outgoingIcons.length];
    }
  }
  
  // Widget untuk item ringkasan
  Widget _buildSummaryItem(BuildContext context, String label, String value, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

// Delegate untuk header ringkasan yang tetap terlihat saat scroll
class _SummaryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  
  _SummaryHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  
  @override
  double get minExtent => minHeight;
  
  @override
  double get maxExtent => maxHeight;
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }
  
  @override
  bool shouldRebuild(_SummaryHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

// Delegate untuk tab bar filter yang tetap terlihat saat scroll
class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  
  _TabBarHeaderDelegate({
    required this.child,
  });
  
  @override
  double get minExtent => 60;
  
  @override
  double get maxExtent => 60;
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }
  
  @override
  bool shouldRebuild(_TabBarHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

class TransactionListItem extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final bool isIncoming;
  final bool isPending;
  final String transactionId;
  final String description;
  final String category;
  final String paymentMethod;
  final String time;
  final IconData transactionIcon;
  final Color iconColor;

  const TransactionListItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncoming,
    this.isPending = false,
    required this.transactionId,
    required this.description,
    required this.category,
    required this.paymentMethod,
    required this.time,
    this.transactionIcon = Icons.swap_horiz_rounded,
    this.iconColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showTransactionDetails(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon transaksi dengan animasi latar belakang
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      iconColor.withOpacity(0.2),
                      iconColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Elemen dekoratif di latar belakang
                    Positioned(
                      right: -5,
                      bottom: -5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: iconColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    // Icon utama
                    Center(
                      child: Icon(
                        transactionIcon,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // Informasi transaksi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 4),
                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Jumlah transaksi
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncoming ? '+' : '-'} Rp ${amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isIncoming ? Colors.green[600] : Colors.red[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPending 
                          ? Colors.orange.withOpacity(0.2) 
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isPending ? 'Pending' : 'Selesai',
                      style: TextStyle(
                        color: isPending ? Colors.orange[700] : Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Fungsi untuk menampilkan pop-up detail transaksi
  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Latar belakang dekoratif
              Positioned(
                top: -50,
                right: -50,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: iconColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                bottom: -60,
                left: -30,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: iconColor.withOpacity(0.05),
                ),
              ),
              
              // Konten utama
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle drag
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Detail Transaksi',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      
                      // Status dan jumlah dengan animasi latar belakang
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                isIncoming ? Colors.green[50]! : Colors.orange[50]!,
                                isIncoming ? Colors.green[100]! : Colors.orange[100]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: (isIncoming ? Colors.green : Colors.orange).withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Icon dengan efek
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (isIncoming ? Colors.green : Colors.orange).withOpacity(0.2),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (isIncoming ? Colors.green : Colors.orange).withOpacity(0.3),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isIncoming ? Colors.green : Colors.orange,
                                      boxShadow: [
                                        BoxShadow(
                                          color: (isIncoming ? Colors.green : Colors.orange).withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      transactionIcon,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              
                              // Status transaksi
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  isIncoming ? 'Dana Masuk' : 'Dana Keluar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isIncoming ? Colors.green[700] : Colors.orange[700],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              
                              // Jumlah
                              Text(
                                'Rp ${amount.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              
                              // Status proses
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isPending 
                                      ? Colors.orange.withOpacity(0.2) 
                                      : Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isPending ? Icons.access_time : Icons.check_circle,
                                      size: 18,
                                      color: isPending ? Colors.orange[700] : Colors.green[700],
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      isPending ? 'Pending' : 'Selesai',
                                      style: TextStyle(
                                        color: isPending ? Colors.orange[700] : Colors.green[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 32),
                      
                      // Detail informasi transaksi dengan card
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Transaksi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 16),
                            _buildDetailItemEnhanced('Transaksi', title, Icons.swap_horiz_rounded),
                            _buildDetailItemEnhanced('Tanggal', date, Icons.calendar_today_rounded),
                            _buildDetailItemEnhanced('Waktu', time, Icons.access_time_rounded),
                            _buildDetailItemEnhanced('ID Transaksi', transactionId, Icons.tag_rounded),
                            _buildDetailItemEnhanced('Kategori', category, Icons.category_rounded),
                            _buildDetailItemEnhanced('Metode Pembayaran', paymentMethod, Icons.credit_card_rounded),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24),
                      
                      // Deskripsi
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              description,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 32),
                      
                      // Tombol aksi
                      Row(
                        children: [
                          // Tombol cetak
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Implementasi cetak bukti
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Cetak bukti transaksi'))
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.blue[700]!),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.print_rounded,
                                color: Colors.blue[700],
                              ),
                              label: Text(
                                'Cetak',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Tombol bagikan
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Implementasi untuk berbagi bukti transaksi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Berbagi bukti transaksi'))
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              icon: Icon(
                                Icons.share_rounded,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Bagikan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Tombol laporkan masalah
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            // Implementasi lapor masalah
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Laporkan masalah dengan transaksi ini'))
                            );
                          },
                          icon: Icon(
                            Icons.report_problem_outlined,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          label: Text(
                            'Laporkan Masalah',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
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
        );
      },
    );
  }
  
  // Widget untuk item detail transaksi yang diperbarui
  Widget _buildDetailItemEnhanced(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: Colors.blue[700],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}