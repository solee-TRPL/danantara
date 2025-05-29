import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 1,
      'type': 'creditCard',
      'title': 'Visa Gold',
      'number': '**** **** **** 5678',
      'expiry': '12/26',
      'icon': Icons.credit_card,
      'isDefault': true,
      'color': Colors.amber,
    },
    {
      'id': 2,
      'type': 'creditCard',
      'title': 'Mastercard',
      'number': '**** **** **** 1234',
      'expiry': '03/27',
      'icon': Icons.credit_card,
      'isDefault': false,
      'color': Colors.red,
    },
    {
      'id': 3,
      'type': 'bank',
      'title': 'Bank Central Asia',
      'number': '**** **** 9012',
      'icon': Icons.account_balance,
      'isDefault': false,
      'color': Colors.blue,
    },
    {
      'id': 4,
      'type': 'ewallet',
      'title': 'GoPay',
      'number': '0812 **** 7890',
      'icon': Icons.account_balance_wallet,
      'isDefault': false,
      'color': Colors.deepPurple,
    },
  ];

  int? _selectedPaymentId;

  @override
  void initState() {
    super.initState();
    _selectedPaymentId = _paymentMethods.firstWhere((method) => method['isDefault'] == true)['id'] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metode Pembayaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with Balance
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade800, Colors.purple.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade200.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saldo Anda',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Rp 3.500.000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.add,
                            label: 'Top Up',
                            onTap: () {
                              _showTopUpDialog();
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.send,
                            label: 'Transfer',
                            onTap: () {
                              _showTransferDialog();
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.history,
                            label: 'Riwayat',
                            onTap: () {
                              // Navigate to transaction history
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _showAddPaymentMethodDialog();
                    },
                    icon: Icon(Icons.add, size: 18),
                    label: Text('Tambah'),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Payment Methods List
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  return _buildPaymentMethodCard(method);
                },
              ),
              
              SizedBox(height: 24),
              
              // Promotion card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.amber.shade700),
                        SizedBox(width: 8),
                        Text(
                          'Promo Spesial!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dapatkan cashback 5% untuk setiap transaksi menggunakan kartu kredit yang terdaftar',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade600,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: Text('Lihat Detail'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQRCodeDialog();
        },
        tooltip: 'Scan untuk Bayar',
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final bool isDefault = method['isDefault'] ?? false;
    final Color methodColor = method['color'] ?? Colors.grey;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
        border: isDefault
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Set as default payment method
            setState(() {
              for (var m in _paymentMethods) {
                m['isDefault'] = m['id'] == method['id'];
              }
              _selectedPaymentId = method['id'] as int;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: methodColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    method['icon'] as IconData,
                    color: methodColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        method['number'] as String,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      if (method.containsKey('expiry')) ...[
                        SizedBox(height: 4),
                        Text(
                          'Exp: ${method['expiry']}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isDefault)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(height: 8),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _showPaymentOptionsDialog(method);
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTopUpDialog() {
    final TextEditingController amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Top Up Saldo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Masukkan jumlah yang ingin Anda tambahkan ke saldo Anda',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Pilih metode pembayaran:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              value: _selectedPaymentId,
              items: _paymentMethods.map((method) {
                return DropdownMenuItem<int>(
                  value: method['id'] as int,
                  child: Text(
                    '${method['title']} (${method['number']})',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentId = value;
                });
              },
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
                  content: Text('Top up berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Top Up'),
          ),
        ],
      ),
    );
  }

  void _showTransferDialog() {
    final TextEditingController recipientController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipientController,
              decoration: InputDecoration(
                labelText: 'Nomor Rekening / Nomor Telepon',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                border: OutlineInputBorder(),
              ),
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
                  content: Text('Transfer berhasil'),
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

  void _showAddPaymentMethodDialog() {
    final List<Map<String, dynamic>> paymentTypes = [
      {
        'title': 'Kartu Kredit / Debit',
        'icon': Icons.credit_card,
        'color': Colors.blue,
      },
      {
        'title': 'Rekening Bank',
        'icon': Icons.account_balance,
        'color': Colors.green,
      },
      {
        'title': 'E-Wallet',
        'icon': Icons.account_balance_wallet,
        'color': Colors.purple,
      },
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Metode Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: paymentTypes.map((type) => ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (type['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                type['icon'] as IconData,
                color: type['color'] as Color,
              ),
            ),
            title: Text(
              type['title'] as String,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(context);
              _showAddPaymentDetailsDialog(type['title'] as String);
            },
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentDetailsDialog(String paymentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah $paymentType'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: paymentType == 'Kartu Kredit / Debit' 
                    ? 'Nomor Kartu' 
                    : paymentType == 'Rekening Bank' 
                        ? 'Nomor Rekening' 
                        : 'Nomor E-Wallet',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            if (paymentType == 'Kartu Kredit / Debit') ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Tanggal Kadaluarsa',
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama di ${paymentType == 'Kartu Kredit / Debit' 
                    ? 'Kartu' 
                    : paymentType == 'Rekening Bank' 
                        ? 'Rekening' 
                        : 'E-Wallet'}',
                border: OutlineInputBorder(),
              ),
            ),
            if (paymentType == 'Rekening Bank') ...[
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Bank',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Bank Central Asia',
                  'Bank Mandiri',
                  'Bank Rakyat Indonesia',
                  'Bank Negara Indonesia',
                  'CIMB Niaga',
                ].map((bank) => DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                )).toList(),
                onChanged: (value) {},
              ),
            ],
            if (paymentType == 'E-Wallet') ...[
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Provider',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'GoPay',
                  'OVO',
                  'DANA',
                  'LinkAja',
                  'ShopeePay',
                ].map((wallet) => DropdownMenuItem<String>(
                  value: wallet,
                  child: Text(wallet),
                )).toList(),
                onChanged: (value) {},
              ),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$paymentType berhasil ditambahkan'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptionsDialog(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Opsi ${method['title']}'),
        children: [
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text('Jadikan Default'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                for (var m in _paymentMethods) {
                  m['isDefault'] = m['id'] == method['id'];
                }
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              // Show edit dialog
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Hapus', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmationDialog(method);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Metode Pembayaran'),
        content: Text(
          'Apakah Anda yakin ingin menghapus ${method['title']} (${method['number']}) dari daftar metode pembayaran Anda?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _paymentMethods.removeWhere((m) => m['id'] == method['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${method['title']} berhasil dihapus'),
                ),
              );
            },
            child: Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCodeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Scan untuk Bayar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tunjukkan QR code ini untuk melakukan pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(
                      Icons.qr_code_2,
                      size: 180,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Ahmad Budi • 0812 3456 7890',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ID: 123456789',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQROption(
                    icon: Icons.refresh,
                    label: 'Refresh',
                    onTap: () {},
                  ),
                  _buildQROption(
                    icon: Icons.share,
                    label: 'Bagikan',
                    onTap: () {},
                  ),
                  _buildQROption(
                    icon: Icons.download,
                    label: 'Simpan',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQROption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}