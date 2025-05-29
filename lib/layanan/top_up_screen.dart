import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'bank_transfer'; // Default method
  
  // Pilihan nominal cepat
  final List<int> _quickAmounts = [50000, 100000, 200000, 500000, 1000000];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up Saldo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            SizedBox(height: 24),
            _buildAmountInput(),
            SizedBox(height: 24),
            _buildQuickAmounts(),
            SizedBox(height: 24),
            _buildPaymentMethods(),
            SizedBox(height: 32),
            _buildTopUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
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
            'Saldo Saat Ini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
            ),
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
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah Top Up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            hintText: 'Masukkan jumlah',
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            // Optional: format the input as currency
          },
        ),
        SizedBox(height: 8),
        Text(
          'Minimal Top Up Rp 10.000',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilihan Cepat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _quickAmounts.map((amount) {
            return InkWell(
              onTap: () {
                setState(() {
                  _amountController.text = amount.toString();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[300]!),
                  color: Colors.white,
                ),
                child: Text(
                  'Rp ${amount.toString()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        _buildPaymentMethodOption(
          value: 'bank_transfer',
          title: 'Transfer Bank',
          subtitle: 'BCA, BNI, BRI, Mandiri, dll',
          icon: Icons.account_balance,
        ),
        Divider(),
        _buildPaymentMethodOption(
          value: 'e_wallet',
          title: 'E-Wallet',
          subtitle: 'OVO, GoPay, DANA, LinkAja, ShopeePay',
          icon: Icons.account_balance_wallet,
        ),
        Divider(),
        _buildPaymentMethodOption(
          value: 'credit_card',
          title: 'Kartu Kredit',
          subtitle: 'Visa, Mastercard, JCB',
          icon: Icons.credit_card,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedMethod,
      onChanged: (newValue) {
        setState(() {
          _selectedMethod = newValue!;
        });
      },
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.blue[700],
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    );
  }

  Widget _buildTopUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Validate amount
          if (_amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Silahkan masukkan jumlah top up')),
            );
            return;
          }

          int amount = int.parse(_amountController.text);
          if (amount < 10000) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Minimal top up Rp 10.000')),
            );
            return;
          }

          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => _buildConfirmationDialog(amount),
          );
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationDialog(int amount) {
    String paymentMethod = '';
    switch (_selectedMethod) {
      case 'bank_transfer':
        paymentMethod = 'Transfer Bank';
        break;
      case 'e_wallet':
        paymentMethod = 'E-Wallet';
        break;
      case 'credit_card':
        paymentMethod = 'Kartu Kredit';
        break;
    }

    return AlertDialog(
      title: Text('Konfirmasi Top Up'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConfirmationItem('Jumlah Top Up', 'Rp ${amount.toString()}'),
          _buildConfirmationItem('Metode Pembayaran', paymentMethod),
          _buildConfirmationItem('Biaya Admin', 'Rp 2.500'),
          Divider(),
          _buildConfirmationItem(
            'Total Pembayaran',
            'Rp ${(amount + 2500).toString()}',
            isBold: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
          ),
          child: Text('Batalkan'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Process payment
            // After successful payment, show success dialog
            Future.delayed(Duration(seconds: 1), () {
              showDialog(
                context: context,
                builder: (context) => _buildSuccessDialog(),
              );
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: Text('Konfirmasi & Bayar'),
        ),
      ],
    );
  }

  Widget _buildConfirmationItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
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

  Widget _buildSuccessDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 72,
          ),
          SizedBox(height: 16),
          Text(
            'Top Up Berhasil!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Saldo Anda telah berhasil ditambahkan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Back to home
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Kembali ke Home'),
          ),
        ],
      ),
    );
  }
}