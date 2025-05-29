import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TRX001',
      'date': '24 Apr 2025',
      'time': '14:30',
      'description': 'Transfer ke Ahmad Budi',
      'amount': -500000,
      'type': 'transfer_out'
    },
    {
      'id': 'TRX002',
      'date': '22 Apr 2025',
      'time': '10:15',
      'description': 'Top Up Saldo',
      'amount': 1000000,
      'type': 'top_up'
    },
    {
      'id': 'TRX003',
      'date': '20 Apr 2025',
      'time': '16:45',
      'description': 'Pembayaran Listrik',
      'amount': -250000,
      'type': 'payment'
    },
    {
      'id': 'TRX004',
      'date': '18 Apr 2025',
      'time': '09:20',
      'description': 'Transfer dari Siti Nuraini',
      'amount': 750000,
      'type': 'transfer_in'
    },
  ];

  RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Transaksi Terakhir',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => AllTransactionsScreen()),
          //         );
          //       },
          //       child: Text(
          //         'Lihat Semua',
          //         style: TextStyle(color: Colors.blue),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final transaction = _transactions[index];
              return _buildTransactionItem(context, transaction);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> transaction) {
    IconData icon;
    Color color;
    
    switch (transaction['type']) {
      case 'transfer_out':
        icon = Icons.arrow_upward;
        color = Colors.red;
        break;
      case 'transfer_in':
        icon = Icons.arrow_downward;
        color = Colors.green;
        break;
      case 'top_up':
        icon = Icons.add_circle;
        color = Colors.green;
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.red;
        break;
      default:
        icon = Icons.swap_horiz;
        color = Colors.blue;
    }

    return InkWell(
      onTap: () => _showTransactionDetail(context, transaction),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${transaction['date']} - ${transaction['time']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              transaction['amount'] > 0 
                ? '+Rp ${_formatRupiah(transaction['amount'])}'
                : '-Rp ${_formatRupiah(transaction['amount'].abs())}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: transaction['amount'] > 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Format angka menjadi format Rupiah (dengan separator ribuan)
  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _showTransactionDetail(BuildContext context, Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTransactionDetailSheet(context, transaction),
    );
  }

  Widget _buildTransactionDetailSheet(BuildContext context, Map<String, dynamic> transaction) {
    IconData icon;
    Color color;
    String statusText = 'Berhasil';
    Color statusColor = Colors.green;
    
    // Informasi tambahan untuk detail transaksi
    Map<String, String> additionalInfo = {};
    
    switch (transaction['type']) {
      case 'transfer_out':
        icon = Icons.arrow_upward;
        color = Colors.red;
        additionalInfo = {
          'Nama Penerima': 'Ahmad Budi',
          'Bank Tujuan': 'Bank Central Asia (BCA)',
          'Nomor Rekening': '1234-5678-9012',
          'Metode Transfer': 'Instant Transfer',
          'Biaya Admin': 'Rp 2.500',
          'Catatan': 'Pembayaran Invoice #INV-2025-0042'
        };
        break;
      case 'transfer_in':
        icon = Icons.arrow_downward;
        color = Colors.green;
        additionalInfo = {
          'Nama Pengirim': 'Siti Nuraini',
          'Bank Asal': 'Bank Rakyat Indonesia (BRI)',
          'Nomor Rekening': '8765-4321-0987',
          'Metode Diterima': 'Instant Transfer',
          'Catatan': 'Pembayaran project website'
        };
        break;
      case 'top_up':
        icon = Icons.add_circle;
        color = Colors.green;
        additionalInfo = {
          'Metode Top Up': 'Transfer Bank',
          'Bank Asal': 'Bank Mandiri',
          'Nomor Referensi': 'REF-983042',
          'Biaya Admin': 'Rp 0',
          'Status Verifikasi': 'Terverifikasi'
        };
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.red;
        additionalInfo = {
          'Jenis Pembayaran': transaction['description'].contains('Listrik') ? 'Tagihan Listrik' : 'Tagihan Internet',
          'Nomor Pelanggan': transaction['description'].contains('Listrik') ? '1234567890' : '0987654321',
          'Penyedia Layanan': transaction['description'].contains('Listrik') ? 'PLN' : 'IndiHome',
          'Periode Tagihan': 'April 2025',
          'Biaya Admin': 'Rp 2.500',
          'Status Verifikasi': 'Terverifikasi'
        };
        break;
      case 'withdrawal':
        icon = Icons.account_balance;
        color = Colors.red;
        additionalInfo = {
          'Lokasi ATM': 'ATM BCA Jl. Sudirman',
          'Nomor Kartu': '****-****-****-6789',
          'Biaya Admin': 'Rp 0',
          'Jenis Penarikan': 'Reguler'
        };
        break;
      case 'salary':
        icon = Icons.work;
        color = Colors.green;
        additionalInfo = {
          'Nama Pengirim': 'PT Global Teknologi Indonesia',
          'Bank Asal': 'Bank Central Asia (BCA)',
          'Nomor Referensi': 'SAL/APR/2025/003847',
          'Jenis Transaksi': 'Gaji Bulanan',
          'Periode': 'April 2025'
        };
        break;
      default:
        icon = Icons.swap_horiz;
        color = Colors.blue;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // Increase height for more content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          
          // Header with status bar
          Container(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detail Transaksi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          // Status indicator
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 12,
                        color: statusColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  transaction['id'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 24),
          
          // Transaction amount section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['description'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${transaction['date']} · ${transaction['time']}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction['amount'] > 0 
                    ? '+Rp ${_formatRupiah(transaction['amount'])}'
                    : '-Rp ${_formatRupiah(transaction['amount'].abs())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: transaction['amount'] > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Transaction details content
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Info section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi Utama',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDetailItemNew('ID Transaksi', transaction['id']),
                          _buildDetailItemNew('Waktu', '${transaction['date']}, ${transaction['time']} WIB'),
                          if (additionalInfo.containsKey('Periode') || additionalInfo.containsKey('Periode Tagihan'))
                            _buildDetailItemNew('Periode', 
                                additionalInfo['Periode'] ?? additionalInfo['Periode Tagihan'] ?? ''),
                        ],
                      ),
                    ),
                    
                    // Additional Info section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getDetailSectionTitle(transaction['type']),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...additionalInfo.entries
                              .where((entry) => !['Periode', 'Periode Tagihan'].contains(entry.key)) // Skip periode already shown above
                              .map((entry) => _buildDetailItemNew(entry.key, entry.value))
                              ,
                        ],
                      ),
                    ),
                    
                    // Payment summary section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rincian Jumlah',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDetailItemNew(
                            'Jumlah',
                            'Rp ${_formatRupiah(transaction['amount'].abs())}',
                            valueColor: Colors.black87,
                          ),
                          if (additionalInfo.containsKey('Biaya Admin'))
                            _buildDetailItemNew(
                              'Biaya Admin',
                              additionalInfo['Biaya Admin'] ?? '',
                              valueColor: Colors.black87,
                            ),
                          Divider(height: 24),
                          _buildDetailItemNew(
                            'Total',
                            transaction['amount'] > 0 
                              ? '+Rp ${_formatRupiah(transaction['amount'])}'
                              : '-Rp ${_formatRupiah(_calculateTotal(transaction['amount'], additionalInfo))}',
                            valueBold: true,
                            valueColor: transaction['amount'] > 0 ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    
                    // Action buttons (moved to a separate row)
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          
          // Action buttons at bottom
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Help button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bantuan akan segera dihubungkan'))
                      );
                    },
                    icon: Icon(Icons.help_outline),
                    label: Text('Bantuan'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                
                // Share button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bukti transaksi telah dibagikan'))
                      );
                    },
                    icon: Icon(Icons.share),
                    label: Text('Bagikan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                
                // Download PDF button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mengunduh bukti transaksi sebagai PDF'))
                      );
                    },
                    icon: Icon(Icons.download, color: Colors.blue),
                    tooltip: 'Unduh PDF',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function untuk menghitung total dengan biaya admin
  int _calculateTotal(int amount, Map<String, String> additionalInfo) {
    int adminFee = 0;
    
    if (additionalInfo.containsKey('Biaya Admin')) {
      String adminFeeStr = additionalInfo['Biaya Admin'] ?? '';
      if (adminFeeStr.contains('Rp')) {
        adminFeeStr = adminFeeStr.replaceAll('Rp ', '').replaceAll('.', '');
        adminFee = int.tryParse(adminFeeStr) ?? 0;
      }
    }
    
    return amount.abs() + adminFee;
  }

  // Helper function untuk mendapatkan judul sesuai tipe transaksi
  String _getDetailSectionTitle(String type) {
    switch (type) {
      case 'transfer_out':
        return 'Detail Penerima';
      case 'transfer_in':
        return 'Detail Pengirim';
      case 'top_up':
        return 'Detail Top Up';
      case 'payment':
        return 'Detail Pembayaran';
      case 'withdrawal':
        return 'Detail Penarikan';
      case 'salary':
        return 'Detail Pengirim';
      default:
        return 'Detail Transaksi';
    }
  }

  // Detail item yang lebih menarik
  Widget _buildDetailItemNew(String label, String value, {bool valueBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: valueBold ? FontWeight.bold : FontWeight.w500,
                color: valueColor ?? Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// Layar Semua Transaksi
class AllTransactionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': 'TRX001',
      'date': '24 Apr 2025',
      'time': '14:30',
      'description': 'Transfer ke Ahmad Budi',
      'amount': -500000,
      'type': 'transfer_out'
    },
    {
      'id': 'TRX002',
      'date': '22 Apr 2025',
      'time': '10:15',
      'description': 'Top Up Saldo',
      'amount': 1000000,
      'type': 'top_up'
    },
    {
      'id': 'TRX003',
      'date': '20 Apr 2025',
      'time': '16:45',
      'description': 'Pembayaran Listrik',
      'amount': -250000,
      'type': 'payment'
    },
    {
      'id': 'TRX004',
      'date': '18 Apr 2025',
      'time': '09:20',
      'description': 'Transfer dari Siti Nuraini',
      'amount': 750000,
      'type': 'transfer_in'
    },
    {
      'id': 'TRX005',
      'date': '15 Apr 2025',
      'time': '11:05',
      'description': 'Pembayaran Internet',
      'amount': -350000,
      'type': 'payment'
    },
    {
      'id': 'TRX006',
      'date': '12 Apr 2025',
      'time': '13:40',
      'description': 'Tarik Tunai ATM',
      'amount': -600000,
      'type': 'withdrawal'
    },
    {
      'id': 'TRX007',
      'date': '10 Apr 2025',
      'time': '08:55',
      'description': 'Gaji Bulanan',
      'amount': 5000000,
      'type': 'salary'
    },
  ];

  AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Transaksi'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _allTransactions.length,
        itemBuilder: (context, index) {
          final transaction = _allTransactions[index];
          return _buildTransactionItem(context, transaction);
        },
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> transaction) {
    IconData icon;
    Color color;
    
    switch (transaction['type']) {
      case 'transfer_out':
        icon = Icons.arrow_upward;
        color = Colors.red;
        break;
      case 'transfer_in':
        icon = Icons.arrow_downward;
        color = Colors.green;
        break;
      case 'top_up':
        icon = Icons.add_circle;
        color = Colors.green;
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.red;
        break;
      case 'withdrawal':
        icon = Icons.account_balance;
        color = Colors.red;
        break;
      case 'salary':
        icon = Icons.work;
        color = Colors.green;
        break;
      default:
        icon = Icons.swap_horiz;
        color = Colors.blue;
    }

    return InkWell(
      onTap: () => _showTransactionDetail(context, transaction),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${transaction['date']} - ${transaction['time']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              transaction['amount'] > 0 
                ? '+Rp ${_formatRupiah(transaction['amount'])}'
                : '-Rp ${_formatRupiah(transaction['amount'].abs())}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: transaction['amount'] > 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Format angka menjadi format Rupiah (dengan separator ribuan)
  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _showTransactionDetail(BuildContext context, Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTransactionDetailSheet(context, transaction),
    );
  }

  Widget _buildTransactionDetailSheet(BuildContext context, Map<String, dynamic> transaction) {
    IconData icon;
    Color color;
    String statusText = 'Berhasil';
    Color statusColor = Colors.green;
    
    // Informasi tambahan untuk detail transaksi
    Map<String, String> additionalInfo = {};
    
    switch (transaction['type']) {
      case 'transfer_out':
        icon = Icons.arrow_upward;
        color = Colors.red;
        additionalInfo = {
          'Nama Penerima': 'Ahmad Budi',
          'Bank Tujuan': 'Bank Central Asia (BCA)',
          'Nomor Rekening': '1234-5678-9012',
          'Metode Transfer': 'Instant Transfer',
          'Biaya Admin': 'Rp 2.500',
          'Catatan': 'Pembayaran Invoice #INV-2025-0042'
        };
        break;
      case 'transfer_in':
        icon = Icons.arrow_downward;
        color = Colors.green;
        additionalInfo = {
          'Nama Pengirim': 'Siti Nuraini',
          'Bank Asal': 'Bank Rakyat Indonesia (BRI)',
          'Nomor Rekening': '8765-4321-0987',
          'Metode Diterima': 'Instant Transfer',
          'Catatan': 'Pembayaran project website'
        };
        break;
      case 'top_up':
        icon = Icons.add_circle;
        color = Colors.green;
        additionalInfo = {
          'Metode Top Up': 'Transfer Bank',
          'Bank Asal': 'Bank Mandiri',
          'Nomor Referensi': 'REF-983042',
          'Biaya Admin': 'Rp 0',
          'Status Verifikasi': 'Terverifikasi'
        };
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.red;
        additionalInfo = {
          'Jenis Pembayaran': transaction['description'].contains('Listrik') ? 'Tagihan Listrik' : 'Tagihan Internet',
          'Nomor Pelanggan': transaction['description'].contains('Listrik') ? '1234567890' : '0987654321',
          'Penyedia Layanan': transaction['description'].contains('Listrik') ? 'PLN' : 'IndiHome',
          'Periode Tagihan': 'April 2025',
          'Biaya Admin': 'Rp 2.500',
          'Status Verifikasi': 'Terverifikasi'
        };
        break;
      case 'withdrawal':
        icon = Icons.account_balance;
        color = Colors.red;
        additionalInfo = {
          'Lokasi ATM': 'ATM BCA Jl. Sudirman',
          'Nomor Kartu': '****-****-****-6789',
          'Biaya Admin': 'Rp 0',
          'Jenis Penarikan': 'Reguler'
        };
        break;
      case 'salary':
        icon = Icons.work;
        color = Colors.green;
        additionalInfo = {
          'Nama Pengirim': 'PT Global Teknologi Indonesia',
          'Bank Asal': 'Bank Central Asia (BCA)',
          'Nomor Referensi': 'SAL/APR/2025/003847',
          'Jenis Transaksi': 'Gaji Bulanan',
          'Periode': 'April 2025'
        };
        break;
      default:
        icon = Icons.swap_horiz;
        color = Colors.blue;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // Increase height for more content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          
          // Header with status bar
          Container(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detail Transaksi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          // Status indicator
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 12,
                        color: statusColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  transaction['id'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 24),
          
          // Transaction amount section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['description'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${transaction['date']} · ${transaction['time']}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction['amount'] > 0 
                    ? '+Rp ${_formatRupiah(transaction['amount'])}'
                    : '-Rp ${_formatRupiah(transaction['amount'].abs())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: transaction['amount'] > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Transaction details content
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Info section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi Utama',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDetailItemNew('ID Transaksi', transaction['id']),
                          _buildDetailItemNew('Waktu', '${transaction['date']}, ${transaction['time']} WIB'),
                          if (additionalInfo.containsKey('Periode') || additionalInfo.containsKey('Periode Tagihan'))
                            _buildDetailItemNew('Periode', 
                                additionalInfo['Periode'] ?? additionalInfo['Periode Tagihan'] ?? ''),
                        ],
                      ),
                    ),
                    
                    // Additional Info section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getDetailSectionTitle(transaction['type']),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...additionalInfo.entries
                              .where((entry) => !['Periode', 'Periode Tagihan'].contains(entry.key)) // Skip periode already shown above
                              .map((entry) => _buildDetailItemNew(entry.key, entry.value))
                              ,
                        ],
                      ),
                    ),
                    
                    // Payment summary section
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rincian Jumlah',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDetailItemNew(
                            'Jumlah',
                            'Rp ${_formatRupiah(transaction['amount'].abs())}',
                            valueColor: Colors.black87,
                          ),
                          if (additionalInfo.containsKey('BiayaAdmin'))
                            _buildDetailItemNew(
                              'Biaya Admin',
                              additionalInfo['Biaya Admin'] ?? '',
                              valueColor: Colors.black87,
                            ),
                          Divider(height: 24),
                          _buildDetailItemNew(
                            'Total',
                            transaction['amount'] > 0 
                              ? '+Rp ${_formatRupiah(transaction['amount'])}'
                              : '-Rp ${_formatRupiah(_calculateTotal(transaction['amount'], additionalInfo))}',
                            valueBold: true,
                            valueColor: transaction['amount'] > 0 ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    
                    // Action buttons (moved to a separate row)
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          
          // Action buttons at bottom
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Help button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bantuan akan segera dihubungkan'))
                      );
                    },
                    icon: Icon(Icons.help_outline),
                    label: Text('Bantuan'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                
                // Share button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bukti transaksi telah dibagikan'))
                      );
                    },
                    icon: Icon(Icons.share),
                    label: Text('Bagikan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                
                // Download PDF button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mengunduh bukti transaksi sebagai PDF'))
                      );
                    },
                    icon: Icon(Icons.download, color: Colors.blue),
                    tooltip: 'Unduh PDF',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function untuk menghitung total dengan biaya admin
  int _calculateTotal(int amount, Map<String, String> additionalInfo) {
    int adminFee = 0;
    
    if (additionalInfo.containsKey('Biaya Admin')) {
      String adminFeeStr = additionalInfo['Biaya Admin'] ?? '';
      if (adminFeeStr.contains('Rp')) {
        adminFeeStr = adminFeeStr.replaceAll('Rp ', '').replaceAll('.', '');
        adminFee = int.tryParse(adminFeeStr) ?? 0;
      }
    }
    
    return amount.abs() + adminFee;
  }

  // Helper function untuk mendapatkan judul sesuai tipe transaksi
  String _getDetailSectionTitle(String type) {
    switch (type) {
      case 'transfer_out':
        return 'Detail Penerima';
      case 'transfer_in':
        return 'Detail Pengirim';
      case 'top_up':
        return 'Detail Top Up';
      case 'payment':
        return 'Detail Pembayaran';
      case 'withdrawal':
        return 'Detail Penarikan';
      case 'salary':
        return 'Detail Pengirim';
      default:
        return 'Detail Transaksi';
    }
  }

  // Detail item yang lebih menarik
  Widget _buildDetailItemNew(String label, String value, {bool valueBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: valueBold ? FontWeight.bold : FontWeight.w500,
                color: valueColor ?? Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}