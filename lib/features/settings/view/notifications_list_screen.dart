import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'الإشعارات',
          style: TextStyle(color: AppColors.gold),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _NotificationItem(
            title: 'قضية جديدة أُضيفت',
            body: 'تمت إضافة قضية نزاع عقاري برقم LY-2025-001',
            time: 'منذ 5 دقائق',
            isRead: false,
          ),
          _NotificationItem(
            title: 'تذكير جلسة',
            body: 'جلسة قضية الطلاق غدًا في محكمة مصراتة',
            time: 'منذ ساعتين',
            isRead: false,
          ),
          _NotificationItem(
            title: 'تحديث حالة قضية',
            body: 'تم تأجيل قضية الاحتيال التجاري',
            time: 'أمس',
            isRead: true,
          ),
          _NotificationItem(
            title: 'legalBot',
            body: 'لديك اقتراح قانوني جديد',
            time: 'منذ 3 أيام',
            isRead: true,
          ),
        ],
      ),
    );
  }
}

// ====== عنصر إشعار ======
class _NotificationItem extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final bool isRead;

  const _NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRead ? Colors.white : Colors.blue.shade50,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: isRead ? Colors.grey : AppColors.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(body),
        ),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
