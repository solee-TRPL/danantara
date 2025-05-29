import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Transfer Berhasil',
      message: 'Transfer ke Ahmad Budi sebesar Rp 250.000 telah berhasil',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      type: NotificationType.transaction,
      isRead: false,
      icon: Icons.send_rounded,
      color: Colors.green,
    ),
    NotificationItem(
      id: '2',
      title: 'Promo Spesial Akhir Tahun!',
      message:
          'Dapatkan cashback 50% untuk transfer ke bank lain. Maksimal Rp 100.000',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      type: NotificationType.promo,
      isRead: false,
      icon: Icons.local_offer_rounded,
      color: Colors.orange,
    ),
    NotificationItem(
      id: '3',
      title: 'Pembayaran Listrik',
      message:
          'Pembayaran tagihan listrik bulan Januari berhasil. Total: Rp 450.000',
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      type: NotificationType.transaction,
      isRead: true,
      icon: Icons.receipt_long_rounded,
      color: Colors.blue,
    ),
    NotificationItem(
      id: '4',
      title: 'Verifikasi Akun',
      message:
          'Akun Anda telah berhasil diverifikasi. Nikmati fitur lengkap DigiWallet!',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      type: NotificationType.info,
      isRead: true,
      icon: Icons.verified_user_rounded,
      color: Colors.purple,
    ),
    NotificationItem(
      id: '5',
      title: 'Top Up Berhasil',
      message: 'Top up saldo Rp 1.000.000 dari BCA berhasil ditambahkan',
      timestamp: DateTime.now().subtract(Duration(days: 2)),
      type: NotificationType.transaction,
      isRead: true,
      icon: Icons.account_balance_wallet_rounded,
      color: Colors.teal,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Tandai Semua',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue[700],
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue[700],
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'Semua'),
                Tab(text: 'Belum Dibaca ($unreadCount)'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All notifications
          _buildNotificationList(_notifications),
          // Unread notifications
          _buildNotificationList(
            _notifications.where((n) => !n.isRead).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationItem> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada notifikasi',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteNotification(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notifikasi dihapus'),
            action: SnackBarAction(
              label: 'Batalkan',
              onPressed: () {
                // Implement undo functionality
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : Colors.blue[50],
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notification.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(notification.icon, color: notification.color, size: 24),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                notification.message,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              Text(
                _formatTimestamp(notification.timestamp),
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              notification.isRead = true;
            });
            _showNotificationDetail(notification);
          },
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return DateFormat('dd MMM yyyy').format(timestamp);
    }
  }

  void _showNotificationDetail(NotificationItem notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: notification.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        notification.icon,
                        color: notification.color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24),
                if (notification.type == NotificationType.transaction)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to transaction detail
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Detail Transaksi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (notification.type == NotificationType.promo)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to promo detail
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Promo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Tutup',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
    );
  }
}

enum NotificationType { transaction, promo, info }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;
  final IconData icon;
  final Color color;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.icon,
    required this.color,
  });
}
