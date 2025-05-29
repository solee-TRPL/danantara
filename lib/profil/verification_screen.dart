import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isIdUploaded = false;
  bool _isSelfieUploaded = false;
  bool _isProcessing = false;
  bool _isVerified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Akun'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isVerified 
                        ? [Colors.green.shade400, Colors.green.shade700]
                        : [Colors.orange.shade300, Colors.orange.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isVerified ? Icons.verified_user : Icons.pending,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isVerified ? 'Akun Terverifikasi' : 'Menunggu Verifikasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                _isVerified 
                                    ? 'Selamat, akun Anda telah terverifikasi'
                                    : 'Tim kami sedang memverifikasi data Anda',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_isVerified)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white, size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Terverifikasi pada 10 April 2025',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              Text(
                'Dokumen Verifikasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              
              // ID Card Upload
              _buildDocumentUploadCard(
                context,
                title: 'KTP atau Identitas',
                description: 'Unggah foto KTP atau kartu identitas lainnya',
                icon: Icons.credit_card,
                isUploaded: _isIdUploaded,
                onTap: () {
                  setState(() {
                    _isIdUploaded = true;
                  });
                },
              ),
              
              SizedBox(height: 16),
              
              // Selfie Upload
              _buildDocumentUploadCard(
                context,
                title: 'Foto Selfie dengan KTP',
                description: 'Unggah foto selfie sambil memegang KTP Anda',
                icon: Icons.face,
                isUploaded: _isSelfieUploaded,
                onTap: () {
                  setState(() {
                    _isSelfieUploaded = true;
                  });
                },
              ),
              
              SizedBox(height: 24),
              
              // Additional Information
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue.shade700),
                        SizedBox(width: 8),
                        Text(
                          'Informasi Penting',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Pastikan foto identitas jelas dan tidak terpotong\n'
                      '• Foto selfie harus menampakkan wajah dengan jelas\n'
                      '• Proses verifikasi membutuhkan waktu 1-3 hari kerja\n'
                      '• Seluruh data Anda terlindungi dan terenkripsi',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Submit Button
              if (!_isVerified)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (_isIdUploaded && _isSelfieUploaded && !_isProcessing)
                        ? () {
                            setState(() {
                              _isProcessing = true;
                            });
                            // Simulate verification process
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                _isVerified = true;
                                _isProcessing = false;
                              });
                            });
                          }
                        : null,
                    child: _isProcessing
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Kirim untuk Verifikasi',
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

  Widget _buildDocumentUploadCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return Container(
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
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isUploaded ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUploaded
                        ? Colors.green.withOpacity(0.1)
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isUploaded ? Icons.check : icon,
                    color: isUploaded
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
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
                      Text(
                        isUploaded ? 'Berhasil diunggah' : description,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isUploaded ? Icons.check_circle : Icons.arrow_forward_ios,
                  color: isUploaded ? Colors.green : Colors.grey,
                  size: isUploaded ? 24 : 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}