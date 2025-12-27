import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../model/case_model.dart';

class CaseCard extends StatelessWidget {
  final LegalCase caseItem;

  const CaseCard({super.key, required this.caseItem});

  Color get statusColor {
    switch (caseItem.status) {
      case 'مفتوحة':
        return Colors.green;
      case 'مؤجلة':
        return Colors.orange;
      case 'مغلقة':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              caseItem.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text('رقم القضية: ${caseItem.number}'),
            Text('المحكمة: ${caseItem.court}'),
            Text('المحامي: ${caseItem.lawyer}'),
            Text('الجلسة القادمة: ${caseItem.nextSession}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(caseItem.type)),
                const SizedBox(width: 8),
                Chip(
                  label: Text(caseItem.status),
                  backgroundColor: statusColor.withOpacity(0.15),
                  labelStyle: TextStyle(color: statusColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Case Details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                ),
                child: const Text(
                  'عرض التفاصيل',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
