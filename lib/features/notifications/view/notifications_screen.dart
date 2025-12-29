import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool newCases = true;
  bool sessionReminder = true;
  bool legalBot = true;

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
          _item(
            title: 'تنبيهات القضايا الجديدة',
            value: newCases,
            onChanged: (val) {
              setState(() {
                newCases = val;
              });
            },
          ),
          _item(
            title: 'تذكير بمواعيد الجلسات',
            value: sessionReminder,
            onChanged: (val) {
              setState(() {
                sessionReminder = val;
              });
            },
          ),
          _item(
            title: 'إشعارات legalBot',
            value: legalBot,
            onChanged: (val) {
              setState(() {
                legalBot = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
