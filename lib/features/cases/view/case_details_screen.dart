import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/services/ai_service.dart';
import '../model/case_model.dart';

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
  final TextEditingController aiController = TextEditingController();
  final AiService aiService = AiService();

  String aiResponse = '';
  bool loadingAi = false;

  Future<void> askAi() async {
    if (aiController.text.trim().isEmpty) return;

    setState(() => loadingAi = true);

    final result = await aiService.askQuestion(
      'هذه قضية قانونية:\n'
      'العنوان: ${widget.legalCase.title}\n'
      'المحكمة: ${widget.legalCase.court}\n'
      'السؤال: ${aiController.text}',
    );

    setState(() {
      aiResponse = result;
      loadingAi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // 🔝 AppBar
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

            // 🧾 TITLE
            Text(
              widget.legalCase.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // STATUS
            Chip(
              label: Text(widget.legalCase.status),
              backgroundColor: Colors.green.shade100,
              labelStyle: const TextStyle(color: Colors.green),
            ),

            const SizedBox(height: 16),

            // 📊 SUMMARY
            _InfoGrid(legalCase: widget.legalCase),

            const SizedBox(height: 24),

            // 📄 CASE TEXT
            const Text(
              'نص القضية القانوني',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: const Text(
                'نزاع حول ملكية عقار كائن في منطقة الفرناج، '
                'يدعي الطرف الأول ملكيته بناءً على عقد بيع '
                'بينما ينكر الطرف الثاني صحة العقد...',
                style: TextStyle(height: 1.6),
              ),
            ),

            const SizedBox(height: 24),

            // 🤖 AI SECTION
            const Text(
              'المساعد القانوني الذكي',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: aiController,
              decoration: InputDecoration(
                hintText: 'اكتب سؤالك القانوني بخصوص هذه القضية',
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
              child: ElevatedButton.icon(
                icon: const Icon(Icons.smart_toy),
                label: const Text('اسأل الذكاء الاصطناعي'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: askAi,
              ),
            ),

            const SizedBox(height: 12),

            if (loadingAi)
              const Center(child: CircularProgressIndicator()),

            if (aiResponse.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  aiResponse,
                  style: const TextStyle(height: 1.6),
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final LegalCase legalCase;

  const _InfoGrid({required this.legalCase});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3,
      children: [
        _InfoCard('رقم القضية', legalCase.number),
        _InfoCard('المحكمة', legalCase.court),
        _InfoCard('المحامي', legalCase.lawyer),
        _InfoCard('الجلسة القادمة', legalCase.nextSession),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              )),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
