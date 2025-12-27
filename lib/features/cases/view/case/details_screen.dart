import 'package:flutter/material.dart';
import 'package:project/core/constants/app_color.dart';
import 'package:project/core/services/mock_ai_service.dart';
import 'package:project/features/cases/model/case_model.dart';
import 'package:project/core/legal_ai/suggestion_engine.dart';
class CaseDetailsScreen extends StatefulWidget {
  final LegalCase legalCase;

  const CaseDetailsScreen({
    super.key,
    required this.legalCase,
  });

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  final TextEditingController _questionCtrl = TextEditingController();
  final MockAiService _aiService = MockAiService();

  bool loading = false;
  String aiAnswer = '';
  List<String> aiSuggestions = [];

  Future<void> askAi() async {
    if (_questionCtrl.text.trim().isEmpty) return;

    setState(() {
      loading = true;
      aiAnswer = '';
      aiSuggestions = [];
    });

    final response = await _aiService.reply(_questionCtrl.text.trim());
    final suggestions =
       SuggestionsEngine.suggestFromQuestion(_questionCtrl.text.trim());

    setState(() {
      aiAnswer = response;
      aiSuggestions = suggestions;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.legalCase;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'تفاصيل القضية',
          style: TextStyle(color: AppColors.gold),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 عنوان القضية
            Text(
              c.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 بطاقة معلومات القضية
            _CaseInfoCard(caseItem: c),

            const SizedBox(height: 24),

            // 🤖 المساعد القانوني
            const Text(
              'المساعد القانوني الذكي',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: _questionCtrl,
              decoration: InputDecoration(
                hintText: 'اكتب سؤالك القانوني هنا...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: askAi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'اسأل',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (loading)
              const Center(child: CircularProgressIndicator()),

            if (aiAnswer.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  aiAnswer,
                  style: const TextStyle(height: 1.6),
                ),
              ),

            if (aiSuggestions.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'أسئلة مقترحة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: aiSuggestions.map((q) {
                  return ActionChip(
                    label: Text(q),
                    onPressed: () {
                      _questionCtrl.text = q;
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// 🔹 بطاقة معلومات القضية
class _CaseInfoCard extends StatelessWidget {
  final LegalCase caseItem;

  const _CaseInfoCard({required this.caseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _row('رقم القضية', caseItem.number),
          _row('المحكمة', caseItem.court),
          _row('نوع القضية', caseItem.type),
          _row('الحالة', caseItem.status),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
