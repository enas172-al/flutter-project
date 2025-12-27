import 'package:project/core/data/qa_data.dart';

class MockAiService {
  Future<String> reply(String question) async {
    await Future.delayed(const Duration(seconds: 1));

    for (final entry in LegalQaData.data.entries) {
      if (question.contains(entry.key)) {
        return entry.value.join('\n\n');
      }
    }

    return 'سؤالك غير واضح حاليًا.\n'
           'يرجى تحديد نوع القضية أو السؤال بشكل أدق.';
  }
}
