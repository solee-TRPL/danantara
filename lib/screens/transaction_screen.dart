import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: Text('Riwayat Transaksi'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Semua'),
            Tab(text: 'Masuk'),
            Tab(text: 'Keluar'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionList('all'),
          _buildTransactionList('in'),
          _buildTransactionList('out'),
        ],
      ),
    );
  }

  Widget _buildTransactionList(String type) {
    // Filter transactions based on type
    final List<Map<String, dynamic>> transactions = [
      {
        'name': 'Transfer ke Budi',
        'date': '25 Apr 2025',
        'amount': '-Rp50.000',
        'icon': Icons.arrow_upward,
        'iconColor': Colors.red,
        'type': 'out',
      },
      {
        'name': 'Top Up Saldo',
        'date': '24 Apr 2025',
        'amount': '+Rp200.000',
        'icon': Icons.account_balance_wallet,
        'iconColor': Colors.green,
        'type': 'in',
      },
      {
        'name': 'Bayar Listrik',
        'date': '23 Apr 2025',
        'amount': '-Rp150.000',
        'icon': Icons.electric_bolt,
        'iconColor': Colors.orange,
        'type': 'out',
      },
      {
        'name': 'Terima dari Ani',
        'date': '22 Apr 2025',
        'amount': '+Rp75.000',
        'icon': Icons.arrow_downward,
        'iconColor': Colors.green,
        'type': 'in',
      },
      {
        'name': 'Bayar Internet',
        'date': '21 Apr 2025',
        'amount': '-Rp250.000',
        'icon': Icons.wifi,
        'iconColor': Colors.blue,
        'type': 'out',
      },
      {
        'name': 'Terima Gaji',
        'date': '20 Apr 2025',
        'amount': '+Rp3.500.000',
        'icon': Icons.work,
        'iconColor': Colors.green,
        'type': 'in',
      },
    ];

    final filteredTransactions = type == 'all'
        ? transactions
        : transactions.where((t) => t['type'] == type).toList();

    return filteredTransactions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  size: 60,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Belum ada transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = filteredTransactions[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: transaction['iconColor'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      transaction['icon'],
                      color: transaction['iconColor'],
                    ),
                  ),
                  title: Text(
                    transaction['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    transaction['date'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Text(
                    transaction['amount'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: transaction['amount'].startsWith('+')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  onTap: () {
                    // Navigate to transaction details
                  },
                ),
              );
            },
          );
  }
}