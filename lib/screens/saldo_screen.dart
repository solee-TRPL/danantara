import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class SaldoScreen extends StatelessWidget {
  const SaldoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Informasi Saldo', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Use pushReplacement to go back to home and clear the stack
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSaldoCard(),
              SizedBox(height: 24),
              _buildTransactionSummary(context),
              SizedBox(height: 24),
              _buildQuickActions(context),
              SizedBox(height: 24), // Added extra padding at bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaldoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo Tersedia',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rp 3.500.000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nomor Rekening',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '1234 5678 9012',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemilik',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NAMA PENGGUNA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Transaksi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showIncomeDetails(context),
                child: _buildSummaryCard(
                  'Pemasukan',
                  'Rp 2.500.000',
                  Colors.green,
                  Icons.arrow_downward,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _showExpenseDetails(context),
                child: _buildSummaryCard(
                  'Pengeluaran',
                  'Rp 1.200.000',
                  Colors.red,
                  Icons.arrow_upward,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showIncomeDetails(BuildContext context) {
    final List<Map<String, dynamic>> incomeTransactions = [
      {
        'date': '24 Apr 2025',
        'description': 'Transfer dari Siti Nuraini',
        'amount': 750000,
      },
      {
        'date': '22 Apr 2025',
        'description': 'Top Up Saldo',
        'amount': 1000000,
      },
      {
        'date': '10 Apr 2025',
        'description': 'Gaji Bulanan',
        'amount': 5000000,
      },
    ];

    _showTransactionDetailsDialog(
      context,
      'Detail Pemasukan',
      incomeTransactions,
      Colors.green,
      Icons.arrow_downward,
    );
  }

  void _showExpenseDetails(BuildContext context) {
    final List<Map<String, dynamic>> expenseTransactions = [
      {
        'date': '24 Apr 2025',
        'description': 'Transfer ke Ahmad Budi',
        'amount': 500000,
      },
      {
        'date': '20 Apr 2025',
        'description': 'Pembayaran Listrik',
        'amount': 250000,
      },
      {
        'date': '15 Apr 2025',
        'description': 'Pembayaran Internet',
        'amount': 350000,
      },
      {
        'date': '12 Apr 2025',
        'description': 'Tarik Tunai ATM',
        'amount': 600000,
      },
    ];

    _showTransactionDetailsDialog(
      context,
      'Detail Pengeluaran',
      expenseTransactions,
      Colors.red,
      Icons.arrow_upward,
    );
  }

  void _showTransactionDetailsDialog(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> transactions,
    Color color,
    IconData icon,
  ) {
    int total = 0;
    for (var transaction in transactions) {
      total += transaction['amount'] as int;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total ${title.split(' ')[1]}',
                      style: TextStyle(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp ${total.toString()}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Bulan April 2025',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: index == transactions.length - 1 
                                ? Colors.transparent 
                                : Colors.grey[300]!,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
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
                                  transaction['date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Rp ${transaction['amount']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bulan ini',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Icon(
                Icons.info_outline,
                size: 16,
                color: color.withOpacity(0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aksi Cepat',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionItem(
                context,
                Icons.swap_horiz,
                'Transfer',
                Colors.blue,
                () => _showTransferSheet(context),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionItem(
                context,
                Icons.account_balance,
                'Tarik Tunai',
                Colors.orange,
                () => _showTarikTunaiSheet(context),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionItem(
                context,
                Icons.history,
                'Mutasi',
                Colors.purple,
                () => _showMutasiSheet(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showTransferSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransferBottomSheet(),
    );
  }

  void _showTarikTunaiSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TarikTunaiBottomSheet(),
    );
  }

  void _showMutasiSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MutasiBottomSheet(),
    );
  }
}

// Rest of the original code remains the same...
// (BaseBottomSheet, TransferBottomSheet, TarikTunaiBottomSheet, MutasiBottomSheet classes)

// Base Bottom Sheet untuk reusabilitas
class BaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseBottomSheet({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3, // 2/3 dari tinggi layar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Divider(),
          // Content
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Transfer Bottom Sheet
class TransferBottomSheet extends StatefulWidget {
  const TransferBottomSheet({super.key});

  @override
  _TransferBottomSheetState createState() => _TransferBottomSheetState();
}

class _TransferBottomSheetState extends State<TransferBottomSheet> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _recentContacts = [
    {'name': 'Ahmad Budi', 'account': '1234-5678-9012', 'avatar': 'A'},
    {'name': 'Siti Nuraini', 'account': '2345-6789-0123', 'avatar': 'S'},
    {'name': 'Rahmat Hidayat', 'account': '3456-7890-1234', 'avatar': 'R'},
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Modern handle bar
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          
          // Modern header with close button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transfer',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  
                  // Recent contacts section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transfer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Show all contacts
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),
                  
                  // Modern recent contacts
                  Container(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _recentContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _recentContacts[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _accountController.text = contact['account'];
                              });
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue[400]!,
                                          Colors.blue[600]!,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        contact['avatar'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    contact['name'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Account input section
                  Text(
                    'Destination Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _accountController,
                    decoration: InputDecoration(
                      hintText: 'Enter account number',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.blue[400]!,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.account_balance_outlined,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.contacts_outlined,
                          color: Colors.blue[600],
                        ),
                        onPressed: () {
                          // Open contacts
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Amount input section
                  Text(
                    'Transfer Amount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.blue[400]!,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          widthFactor: 0.0,
                          child: Text(
                            'Rp',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Note input section
                  Text(
                    'Add Note (Optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.blue[400]!,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.edit_note_outlined,
                        color: Colors.grey[600],
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Transaction summary card
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue[100]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transfer Fee',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'FREE',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(color: Colors.blue[200]),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _amountController.text.isEmpty ? 'Rp 0' : 'Rp ${_amountController.text}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_accountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter destination account'),
                              backgroundColor: Colors.red[400],
                            ),
                          );
                          return;
                        }

                        if (_amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter transfer amount'),
                              backgroundColor: Colors.red[400],
                            ),
                          );
                          return;
                        }

                        _showTransferConfirmation(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTransferConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Transfer Confirmation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  
                  // Modern confirmation card
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildConfirmationRow(
                          'To Account',
                          _accountController.text,
                          Icons.account_balance_outlined,
                        ),
                        Divider(height: 24),
                        _buildConfirmationRow(
                          'Amount',
                          'Rp ${_amountController.text}',
                          Icons.payments_outlined,
                        ),
                        if (_noteController.text.isNotEmpty) ...[
                          Divider(height: 24),
                          _buildConfirmationRow(
                            'Note',
                            _noteController.text,
                            Icons.note_outlined,
                          ),
                        ],
                        Divider(height: 24),
                        _buildConfirmationRow(
                          'Transfer Fee',
                          'FREE',
                          Icons.local_offer_outlined,
                          valueColor: Colors.green[700],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Total amount
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp ${_amountController.text}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close confirmation
                            Navigator.pop(context); // Close transfer sheet
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 12),
                                    Text('Transfer successful!'),
                                  ],
                                ),
                                backgroundColor: Colors.green[600],
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationRow(String label, String value, IconData icon, {Color? valueColor}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.blue[600],
            size: 20,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Tarik Tunai Bottom Sheet
class TarikTunaiBottomSheet extends StatefulWidget {
  const TarikTunaiBottomSheet({super.key});

  @override
  _TarikTunaiBottomSheetState createState() => _TarikTunaiBottomSheetState();
}

class _TarikTunaiBottomSheetState extends State<TarikTunaiBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedATM = 'mandiri';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Tarik Tunai',
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Tersedia',
                    style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp 3.500.000',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Amount input
            Text(
              'Jumlah Penarikan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Rp',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                hintText: 'Masukkan jumlah penarikan',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 8),
            Text('Minimal Rp 50.000, maksimal Rp 2.000.000',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),

            SizedBox(height: 24),
            // Quick amounts
            Text(
              'Pilihan Cepat',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildQuickAmountButton('100000'),
                _buildQuickAmountButton('200000'),
                _buildQuickAmountButton('500000'),
                _buildQuickAmountButton('1000000'),
              ],
            ),

            SizedBox(height: 24),
            // ATM Selection
            Text(
              'Pilih ATM',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),

            // ATM Options
            _buildATMOption(
              'mandiri',
              'ATM Mandiri',
              'Tarik tunai di ATM Mandiri tanpa kartu',
              'assets/images/mandiri.png',
            ),
            SizedBox(height: 12),
            _buildATMOption(
              'bca',
              'ATM BCA',
              'Tarik tunai di ATM BCA tanpa kartu',
              'assets/images/bca.png',
            ),
            SizedBox(height: 12),
            _buildATMOption(
              'bni',
              'ATM BNI',
              'Tarik tunai di ATM BNI tanpa kartu',
              'assets/images/bni.png',
            ),

            SizedBox(height: 32),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate amount
                  if (_amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Masukkan jumlah penarikan')),
                    );
                    return;
                  }

                  int amount = int.parse(_amountController.text);
                  if (amount < 50000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Minimal penarikan Rp 50.000')),
                    );
                    return;
                  }

                  if (amount > 2000000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Maksimal penarikan Rp 2.000.000'),
                      ),
                    );
                    return;
                  }

                  // Show confirmation
                  _showTarikTunaiConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    String formattedAmount = '';
    switch (amount) {
      case '100000':
        formattedAmount = '100rb';
        break;
      case '200000':
        formattedAmount = '200rb';
        break;
      case '500000':
        formattedAmount = '500rb';
        break;
      case '1000000':
        formattedAmount = '1jt';
        break;
    }

    return InkWell(
      onTap: () {
        setState(() {
          _amountController.text = amount;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue[300]!),
          color:
              _amountController.text == amount ? Colors.blue[50] : Colors.white,
        ),
        child: Text(
          'Rp $formattedAmount',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue[700],
          ),
        ),
      ),
    );
  }

  Widget _buildATMOption(
    String value,
    String title,
    String subtitle,
    String logoPath,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedATM = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedATM == value ? Colors.blue : Colors.grey[300]!,
            width: _selectedATM == value ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  value.substring(0, 1).toUpperCase(), // Placeholder for image
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: _selectedATM,
              onChanged: (newValue) {
                setState(() {
                  _selectedATM = newValue!;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void _showTarikTunaiConfirmation(BuildContext context) {
    String atmName = '';
    switch (_selectedATM) {
      case 'mandiri':
        atmName = 'ATM Mandiri';
        break;
      case 'bca':
        atmName = 'ATM BCA';
        break;
      case 'bni':
        atmName = 'ATM BNI';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Tarik Tunai'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmationItem(
              'Jumlah',
              'Rp ${_amountController.text}',
            ),
            _buildConfirmationItem('ATM', atmName),
            _buildConfirmationItem('Biaya', 'Rp 5.000', isBold: false),
            Divider(),
            _buildConfirmationItem(
              'Total',
              'Rp ${(int.parse(_amountController.text) + 5000).toString()}',
              isBold: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batalkan'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog

              // Generate and show code
              String code = '${DateTime.now().millisecondsSinceEpoch % 1000000}';
              _showWithdrawalCode(context, code);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  void _showWithdrawalCode(BuildContext context, String code) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Kode Tarik Tunai'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 16),
            Text(
              'Kode Tarik Tunai Anda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: code.split('').map((digit) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: Text(
                      digit,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              'Kode ini akan kadaluarsa dalam 30 menit',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Tunjukkan kode ini ke ATM ${_selectedATM.toUpperCase()} untuk melakukan penarikan tunai tanpa kartu',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close sheet
            },
            child: Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              // Copy code to clipboard
              // Clipboard.setData(ClipboardData(text: code));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kode disalin ke clipboard')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Salin Kode'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationItem(
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.blue[700] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Mutasi Bottom Sheet
class MutasiBottomSheet extends StatefulWidget {
  const MutasiBottomSheet({super.key});

  @override
  _MutasiBottomSheetState createState() => _MutasiBottomSheetState();
}

class _MutasiBottomSheetState extends State<MutasiBottomSheet> {
  String _selectedPeriod = 'this_month';
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TRX001',
      'date': '24 Apr 2025',
      'time': '14:30',
      'description': 'Transfer ke Ahmad Budi',
      'amount': -500000,
      'type': 'transfer_out',
    },
    {
      'id': 'TRX002',
      'date': '22 Apr 2025',
      'time': '10:15',
      'description': 'Top Up Saldo',
      'amount': 1000000,
      'type': 'top_up',
    },
    {
      'id': 'TRX003',
      'date': '20 Apr 2025',
      'time': '16:45',
      'description': 'Pembayaran Listrik',
      'amount': -250000,
      'type': 'payment',
    },
    {
      'id': 'TRX004',
      'date': '18 Apr 2025',
      'time': '09:20',
      'description': 'Transfer dari Siti Nuraini',
      'amount': 750000,
      'type': 'transfer_in',
    },
    {
      'id': 'TRX005',
      'date': '15 Apr 2025',
      'time': '11:05',
      'description': 'Pembayaran Internet',
      'amount': -350000,
      'type': 'payment',
    },
    {
      'id': 'TRX006',
      'date': '12 Apr 2025',
      'time': '13:40',
      'description': 'Tarik Tunai ATM',
      'amount': -600000,
      'type': 'withdrawal',
    },
    {
      'id': 'TRX007',
      'date': '10 Apr 2025',
      'time': '08:55',
      'description': 'Gaji Bulanan',
      'amount': 5000000,
      'type': 'salary',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Mutasi Rekening',
      child: Column(
        children: [
          // Filter period
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(child: _buildPeriodOption('this_month', 'Bulan Ini')),
                Expanded(child: _buildPeriodOption('last_month', 'Bulan Lalu')),
                Expanded(child: _buildPeriodOption('last_3months', '3 Bulan')),
              ],
            ),
          ),

          // Transactions list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> transaction = _transactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ),

          // Export button
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Mutasi diunduh sebagai PDF')),
                );
              },
              icon: Icon(Icons.download),
              label: Text('Unduh Mutasi (PDF)'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
                minimumSize: Size(double.infinity, 0),
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodOption(String value, String label) {
    bool isSelected = _selectedPeriod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = value;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
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
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
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
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['description'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${transaction['date']} - ${transaction['time']}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Text(
              transaction['amount'] > 0
                  ? '+Rp ${transaction['amount'].abs()}'
                  : '-Rp ${transaction['amount'].abs()}',
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

  void _showTransactionDetail(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Transaksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('ID Transaksi', transaction['id']),
            _buildDetailItem('Tanggal', transaction['date']),
            _buildDetailItem('Waktu', transaction['time']),
            _buildDetailItem('Deskripsi', transaction['description']),
            _buildDetailItem(
              'Jumlah',
              transaction['amount'] > 0
                  ? '+Rp ${transaction['amount'].abs()}'
                  : '-Rp ${transaction['amount'].abs()}',
              valueColor:
                  transaction['amount'] > 0 ? Colors.green : Colors.red,
            ),
            _buildDetailItem('Status', 'Berhasil'),
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

  Widget _buildDetailItem(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}