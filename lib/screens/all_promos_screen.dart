import 'package:flutter/material.dart';

class AllPromosScreen extends StatelessWidget {
  // Data promo untuk tampilan lengkap
  final List<PromoItem> _allPromos = [
    PromoItem(
      title: "DISKON 50%",
      subtitle: "Semua Produk Fashion",
      description: "Nikmati diskon besar-besaran untuk semua produk fashion terbaru. Berlaku hingga akhir bulan!",
      gradient: [Color(0xFFFF4E50), Color(0xFFF9D423)],
      icon: Icons.shopping_bag,
      validUntil: "30 Mei 2025",
      code: "FASHION50",
    ),
    PromoItem(
      title: "GRATIS ONGKIR",
      subtitle: "Min. Belanja Rp 100.000",
      description: "Belanja apapun dan dapatkan gratis ongkir ke seluruh Indonesia dengan minimal belanja Rp 100.000.",
      gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
      icon: Icons.local_shipping,
      validUntil: "15 Mei 2025",
      code: "FREEONGKIR",
    ),
    PromoItem(
      title: "BELI 1 GRATIS 1",
      subtitle: "Untuk Semua Minuman",
      description: "Kesempatan terbatas! Beli satu gratis satu untuk semua jenis minuman. Berlaku di semua outlet.",
      gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
      icon: Icons.local_cafe,
      validUntil: "10 Mei 2025",
      code: "BUY1GET1",
    ),
    PromoItem(
      title: "DISKON 30%",
      subtitle: "Produk Elektronik",
      description: "Diskon spesial untuk seluruh produk elektronik. Kesempatan terbatas, segera dapatkan sekarang!",
      gradient: [Color(0xFF6B8DD6), Color(0xFF8E37D7)],
      icon: Icons.devices,
      validUntil: "20 Mei 2025",
      code: "ELEKTRO30",
    ),
    PromoItem(
      title: "CASHBACK 20%",
      subtitle: "Pembayaran via Dompet Digital",
      description: "Dapatkan cashback 20% untuk setiap transaksi menggunakan dompet digital. Maksimal cashback Rp 50.000.",
      gradient: [Color(0xFFED213A), Color(0xFF93291E)],
      icon: Icons.account_balance_wallet,
      validUntil: "25 Mei 2025",
      code: "CASHBACK20",
    ),
    PromoItem(
      title: "DISKON MERCHANT 25%",
      subtitle: "Khusus Pengguna Baru",
      description: "Diskon spesial 25% untuk pengguna baru di merchant pilihan. Berlaku untuk pembelian pertama.",
      gradient: [Color(0xFF614385), Color(0xFF516395)],
      icon: Icons.storefront,
      validUntil: "5 Juni 2025",
      code: "NEWUSER25",
    ),
    PromoItem(
      title: "VOUCHER RP 100.000",
      subtitle: "Transaksi Min. Rp 500.000",
      description: "Dapatkan voucher belanja Rp 100.000 untuk transaksi minimal Rp 500.000 pada kategori pilihan.",
      gradient: [Color(0xFF1FA2FF), Color(0xFF12D8FA)],
      icon: Icons.card_giftcard,
      validUntil: "12 Mei 2025",
      code: "VOUCHER100",
    ),
    PromoItem(
      title: "PROMO BUNDLING",
      subtitle: "Hemat hingga 40%",
      description: "Beli paket bundling dan hemat hingga 40% dari harga normal. Promo terbatas untuk produk tertentu.",
      gradient: [Color(0xFFFF8008), Color(0xFFFFC837)],
      icon: Icons.shopping_basket,
      validUntil: "18 Mei 2025",
      code: "BUNDLE40",
    ),
  ];

  AllPromosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Promo'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[800]!, Colors.blue[600]!],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: _allPromos.length,
          itemBuilder: (context, index) {
            return buildPromoCard(context, _allPromos[index]);
          },
        ),
      ),
    );
  }

  Widget buildPromoCard(BuildContext context, PromoItem promo) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: promo.gradient[0].withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => buildPromoDetailSheet(context, promo),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: promo.gradient,
            ),
          ),
          child: Stack(
            children: [
              // Background design elements
              Positioned(
                right: -30,
                bottom: -30,
                child: Icon(
                  promo.icon,
                  size: 140,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              // Circular decorative element
              Positioned(
                left: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Promo Spesial',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      promo.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      promo.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "s.d ${promo.validUntil}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Lihat Detail',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPromoDetailSheet(BuildContext context, PromoItem promo) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
          // Header with gradient
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: promo.gradient,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
                // Decorative elements
                Positioned(
                  right: -30,
                  bottom: -30,
                  child: Icon(
                    promo.icon,
                    size: 150,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                // Close button
                Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                // Title content
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        promo.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        promo.subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Detail content
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo description
                  Text(
                    'Deskripsi Promo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    promo.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Promo period
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: promo.gradient[0],
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Periode Promo',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Berlaku hingga ${promo.validUntil}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Promo code
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kode Promo',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Text(
                                promo.code,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // Copy promo code functionality
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Kode disalin ke clipboard!'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: promo.gradient,
                                    ),
                                  ),
                                  child: Text(
                                    'Salin',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
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

                  // Terms and conditions
                  Text(
                    'Syarat & Ketentuan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      buildTermItem(promo, 'Promo berlaku untuk semua pengguna'),
                      buildTermItem(promo, 'Promo tidak dapat digabungkan dengan promo lain'),
                      buildTermItem(promo, 'Promo hanya berlaku untuk produk tertentu'),
                      buildTermItem(promo, 'Berlaku untuk pembelian online dan offline'),
                      buildTermItem(promo, 'Pihak penyelenggara berhak membatalkan promo tanpa pemberitahuan'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: promo.gradient[0],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Implementation for using promo
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Promo berhasil digunakan!'),
                    backgroundColor: promo.gradient[0],
                  ),
                );
              },
              child: Text(
                'Gunakan Promo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTermItem(PromoItem promo, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: promo.gradient[0],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoItem {
  final String title;
  final String subtitle;
  final String description;
  final List<Color> gradient;
  final IconData icon;
  final String validUntil;
  final String code;

  PromoItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradient,
    required this.icon,
    required this.validUntil,
    required this.code,
  });
}