import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  static const String _endpoint =
      'https://api.openai.com/v1/chat/completions';

  /// 🔹 هذه الدالة مسؤولة عن:
  /// - استقبال سؤال المستخدم
  /// - إرساله للـ AI
  /// - إرجاع الرد النصّي فقط
  Future<String> askQuestion(String question) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('❌ OPENAI_API_KEY غير موجود في ملف .env');
    }

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
                "أنت مساعد قانوني ليبي محترف. "
                "أجب فقط على سؤال المستخدم إجابة قانونية واضحة ومختصرة "
                "وبلغة عربية رسمية بدون مقدمات أو حشو."
          },
          {
            "role": "user",
            "content": question
          }
        ],
        "temperature": 0.3,
        "max_tokens": 500,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        '❌ خطأ من السيرفر: ${response.statusCode}\n${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);

    return decoded['choices'][0]['message']['content'];
  }
}
