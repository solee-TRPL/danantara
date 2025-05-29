import 'package:flutter/material.dart';
import 'gallery_screen.dart';
import 'scan_history_screen.dart';
import 'scanner_setting_screen.dart';
import 'home_screen.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFlashlightOn = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScannerSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient background for top section
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[700]!, Colors.blue[500]!],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Title and mode selector
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Scan Code',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _tabController.index == 0
                            ? 'Scan QR code for payments or transfers'
                            : 'Scan barcode on products or documents',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tab selector
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.5),
                          ),
                          labelColor: Colors.blue[700],
                          unselectedLabelColor: Colors.white,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          tabs: [
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.qr_code_rounded, size: 16),
                                  SizedBox(width: 4),
                                  Text('QR Code'),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.line_weight_rounded, size: 16),
                                  SizedBox(width: 4),
                                  Text('Barcode'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Scanner area
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildQRScannerView(screenWidth, screenHeight),
                      _buildBarcodeScannerView(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom actions - optimized to prevent overflow
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gallery Button
              _buildActionButton(
                icon: Icons.image_rounded,
                label: 'Gallery',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhotoGalleryScreen(),
                    ),
                  );
                },
              ),

              // Flashlight Button
              _buildActionButton(
                icon:
                    _isFlashlightOn
                        ? Icons.flash_off_rounded
                        : Icons.flash_on_rounded,
                label: _isFlashlightOn ? 'Flash Off' : 'Flash On',
                isActive: _isFlashlightOn,
                onTap: () {
                  setState(() {
                    _isFlashlightOn = !_isFlashlightOn;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Flashlight ${_isFlashlightOn ? 'on' : 'off'}',
                      ),
                    ),
                  );
                },
              ),

              // History Button
              _buildActionButton(
                icon: Icons.history_rounded,
                label: 'History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScanHistoryScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRScannerView(double screenWidth, double screenHeight) {
    // Calculate optimal scanner size based on available height
    final availableHeight = screenHeight - 300; // Adjusted for better spacing
    final scannerSize = (availableHeight * 0.45).clamp(
      150.0,
      screenWidth * 0.6,
    );

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Add some top spacing
            // Scanner frame with animation
            Container(
              width: scannerSize,
              height: scannerSize,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Corner decorations
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildCorner(Colors.blue[600]!, topLeft: true),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _buildCorner(Colors.blue[600]!, topRight: true),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildCorner(Colors.blue[600]!, bottomLeft: true),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildCorner(Colors.blue[600]!, bottomRight: true),
                  ),

                  // Scan animation
                  Center(
                    child: Container(
                      width: scannerSize - 4,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.blue[400]!,
                            Colors.blue[600]!,
                            Colors.blue[400]!,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // QR icon overlay
                  Center(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: scannerSize * 0.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Posisikan QR Code di tengah frame',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kode akan otomatis terbaca ketika terdeteksi',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Add bottom spacing
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeScannerView(double screenWidth, double screenHeight) {
    // Calculate optimal scanner size based on available height
    final availableHeight = screenHeight - 320; // Adjusted for better spacing
    final scannerWidth = (availableHeight * 0.5).clamp(
      150.0,
      screenWidth * 0.75,
    );
    final scannerHeight = scannerWidth * 0.5;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Add some top spacing
            // Barcode scanner frame
            Container(
              width: scannerWidth,
              height: scannerHeight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Corner decorations
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildCorner(Colors.blue[600]!, topLeft: true),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _buildCorner(Colors.blue[600]!, topRight: true),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildCorner(Colors.blue[600]!, bottomLeft: true),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildCorner(Colors.blue[600]!, bottomRight: true),
                  ),

                  // Scan line animation
                  Center(
                    child: Container(
                      width: 2,
                      height: scannerHeight - 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.blue[400]!,
                            Colors.blue[600]!,
                            Colors.blue[400]!,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Barcode icon overlay
                  Center(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.view_week_outlined,
                        size: scannerHeight * 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Arahkan barcode ke tengah frame',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pastikan barcode terlihat jelas dan tidak tertutup',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Supported formats
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 6),
                  Text(
                    'Mendukung format EAN, UPC, Code39, Code128',
                    style: TextStyle(fontSize: 11, color: Colors.blue[700]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Add bottom spacing
          ],
        ),
      ),
    );
  }

  // Widget untuk sudut frame scanner
  Widget _buildCorner(
    Color color, {
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border(
          top:
              topLeft || topRight
                  ? BorderSide(color: color, width: 3)
                  : BorderSide.none,
          left:
              topLeft || bottomLeft
                  ? BorderSide(color: color, width: 3)
                  : BorderSide.none,
          right:
              topRight || bottomRight
                  ? BorderSide(color: color, width: 3)
                  : BorderSide.none,
          bottom:
              bottomLeft || bottomRight
                  ? BorderSide(color: color, width: 3)
                  : BorderSide.none,
        ),
      ),
    );
  }

  // Widget untuk tombol aksi di bagian bawah - optimized to prevent overflow
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Colors.blue : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue : Colors.grey[700],
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? Colors.blue : Colors.grey[700],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}