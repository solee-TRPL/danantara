import 'package:danantara/layanan/bayar_screen.dart';
import 'package:danantara/layanan/kirim_screen.dart';
import 'package:danantara/layanan/terima_screen.dart';
import 'package:danantara/layanan/top_up_screen.dart';
// import 'package:danantara/widgets/promo_carousel.dart';
import 'package:danantara/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/riwayat_screen.dart';
import '../screens/saldo_screen.dart';
// import '../screens/scan_qr_screen.dart';
import '../screens/profile_screen.dart';
// import '../screens/all_promos_screen.dart';
import '../screens/notification_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContentScreen(),
    RiwayatScreen(),
    SaldoScreen(),
    // ScanQRScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue[700],
            unselectedItemColor: Colors.grey[400],
            backgroundColor: Colors.white,
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                activeIcon: Icon(Icons.history_rounded),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_rounded),
                activeIcon: Icon(Icons.account_balance_wallet_rounded),
                label: 'Saldo',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.qr_code_scanner_rounded),
              //   activeIcon: Icon(Icons.qr_code_scanner_rounded),
              //   label: 'Scan QR',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen content for the main Home tab
class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  _HomeContentScreenState createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  bool _isSaldoVisible = true;
  final ScrollController _scrollController = ScrollController();
  int _unreadNotifications = 2; // Example unread count

  @override
  void initState() {
    super.initState();
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.blue[700],
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Calculate scroll percentage
                var top = constraints.biggest.height;
                var expandedHeight = 240;
                var collapsedHeight = 100;
                var expandRatio = (top - collapsedHeight) / (expandedHeight - collapsedHeight);
                expandRatio = expandRatio.clamp(0.0, 1.0);

                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      // Gradient background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blue[800]!, Colors.blue[600]!],
                          ),
                        ),
                      ),
                      
                      // Decorative circles
                      Positioned(
                        right: -40,
                        top: -20,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -50,
                        bottom: -30,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      
                      // Main content
                      SafeArea(
                        child: Column(
                          children: [
                            // Top bar with logo and notification
                            Opacity(
                              opacity: expandRatio,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Logo
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.account_balance_wallet,
                                            color: Colors.blue[700],
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Danantara',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Notification button
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NotificationScreen(),
                                              ),
                                            ).then((_) {
                                              // Refresh notification count
                                              setState(() {
                                                _unreadNotifications = 0;
                                              });
                                            });
                                          },
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.15),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              Icons.notifications_none_rounded,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        if (_unreadNotifications > 0)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 16,
                                                minHeight: 16,
                                              ),
                                              child: Text(
                                                '$_unreadNotifications',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Spacer
                            Spacer(),
                            
                            // Balance card - with fade animation
                            Opacity(
                              opacity: expandRatio,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Saldo Utama',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SaldoScreen(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(0, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(
                                            _isSaldoVisible
                                                ? 'Rp 3.500.000'
                                                : 'Rp ••••••••',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isSaldoVisible = !_isSaldoVisible;
                                              });
                                            },
                                            child: Icon(
                                              _isSaldoVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              size: 20,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 150),
                    opacity: expandRatio < 0.3 ? 1.0 : 0.0,
                    child: Container(
                      height: 56, // Standar height AppBar
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo di kiri
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.blue[700],
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'DigiWallet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Saldo di kanan
                          Text(
                            _isSaldoVisible
                                ? 'Rp 3.500.000'
                                : 'Rp ••••••••',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  centerTitle: false,
                  titlePadding: EdgeInsets.symmetric(horizontal: 16),
                );
              },
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildActionPanel(context),
                SizedBox(height: 16),
                // buildPromoSection(context),
                SizedBox(height: 16),
                buildTransactionSection(context),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionPanel(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Layanan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  context,
                  Icons.arrow_upward_rounded,
                  'Kirim',
                  Colors.blue[700]!,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KirimScreen()),
                  ),
                ),
                _buildActionButton(
                  context,
                  Icons.arrow_downward_rounded,
                  'Terima',
                  Colors.green[600]!,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TerimaScreen()),
                  ),
                ),
                _buildActionButton(
                  context,
                  Icons.payment_rounded,
                  'Bayar',
                  Colors.orange[600]!,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BayarScreen()),
                  ),
                ),
                _buildActionButton(
                  context,
                  Icons.add_circle_outline_rounded,
                  'Top Up',
                  Colors.purple[600]!,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopUpScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildPromoSection(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.fromLTRB(4, 0, 4, 8),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'Promo Spesial',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black87,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => AllPromosScreen(),
  //                     ),
  //                   );
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       'Lihat Semua',
  //                       style: TextStyle(
  //                         color: Colors.blue[700],
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     SizedBox(width: 4),
  //                     Icon(
  //                       Icons.arrow_forward_ios,
  //                       size: 12,
  //                       color: Colors.blue[700],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         PromoCarousel(),
  //       ],
  //     ),
  //   );
  // }

  Widget buildTransactionSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaksi Terakhir',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RiwayatScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Lihat Semua',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.blue[700],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          RecentTransactions(),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}