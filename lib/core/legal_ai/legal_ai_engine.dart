/// 📦 نتيجة الذكاء الاصطناعي
class LegalAiResult {
  final String answer;
  final List<String> suggestions;

  LegalAiResult({
    required this.answer,
    required this.suggestions,
  });
}

/// 🧠 محرك AI مبسط (بدون تحليل ذكي)
class LegalAiEngine {
  static Future<LegalAiResult> process(String question) async {
    // ⏳ محاكاة وقت التفكير
    await Future.delayed(const Duration(milliseconds: 600));

    // 📝 رد قانوني مبدئي (آمن ومستقر)
    final answer = '''
❓ سؤالك:
$question

📌 الرد القانوني المبدئي:
هذا رد إرشادي عام مبني على مبادئ قانونية عامة.
للحصول على استشارة دقيقة، يُنصح بمراجعة محامٍ مختص.
''';

    // 💡 اقتراحات عامة ثابتة
    final suggestions = [
      'ما هي إجراءات رفع دعوى قانونية؟',
      'ما المستندات المطلوبة لفتح قضية؟',
      'كم تستغرق القضايا عادة في المحاكم؟',
    ];

    return LegalAiResult(
      answer: answer,
      suggestions: suggestions,
    );
  }
}
