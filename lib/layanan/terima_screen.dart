import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TerimaScreen extends StatefulWidget {
  const TerimaScreen({super.key});

  @override
  _TerimaScreenState createState() => _TerimaScreenState();
}

class _TerimaScreenState extends State<TerimaScreen> {
  final String _accountNumber = "1234567890";
  // final String _qrImagePath = "assets/images/qr_placeholder.png";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terima Uang'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kode QR
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Kode QR Anda',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // QR Code placeholder
                        // Dalam implementasi nyata, gunakan package seperti qr_flutter
                        child: Center(
                          child: Icon(
                            Icons.qr_code,
                            size: 200,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tunjukkan kode QR ini untuk menerima uang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Nomor Rekening
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nomor Rekening',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _accountNumber,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.copy, color: Colors.grey),
                                    onPressed: () => _copyToClipboard(_accountNumber),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bagikan nomor rekening ini untuk menerima uang',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Opsi Pembagian
              Text(
                'Bagikan Dengan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    Icons.message,
                    'SMS',
                    Colors.green.shade700,
                  ),
                  _buildShareOption(
                    Icons.email,
                    'Email',
                    Colors.red.shade700,
                  ),
                  _buildShareOption(
                    Icons.chat_bubble,
                    'WhatsApp',
                    Colors.green,
                  ),
                  _buildShareOption(
                    Icons.more_horiz,
                    'Lainnya',
                    Colors.blue,
                  ),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Riwayat Penerimaan
              _buildRecentHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRecentHistory() {
    final List<Map<String, dynamic>> recentHistory = [
      {
        'name': 'Ahmad Rizky',
        'date': '21 Apr 2025',
        'amount': 'Rp 200.000',
      },
      {
        'name': 'PT Sejahtera',
        'date': '15 Apr 2025',
        'amount': 'Rp 1.500.000',
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Penerimaan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            if (recentHistory.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Belum ada riwayat penerimaan'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recentHistory.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final history = recentHistory[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),
                    ),
                    title: Text(history['name']),
                    subtitle: Text(history['date']),
                    trailing: Text(
                      history['amount'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nomor rekening disalin ke clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }
}