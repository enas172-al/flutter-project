import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _item('تنبيهات القضايا الجديدة'),
          _item('تذكير بمواعيد الجلسات'),
          _item('إشعارات legalBot'),
        ],
      ),
    );
  }

  Widget _item(String title) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        value: true,
        onChanged: (_) {},
      ),
    );
  }
}
