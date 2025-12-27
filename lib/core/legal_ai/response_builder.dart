class ResponseBuilder {
  static String build({
    required String topic,
    required String question,
    required List<String> baseAnswer,
  }) {
    final buffer = StringBuffer();

    // مقدمة ديناميكية
    if (question.contains('كيف')) {
      buffer.writeln('فيما يلي توضيح لكيفية التعامل مع هذه الحالة:\n');
    } else if (question.contains('هل')) {
      buffer.writeln('نعم، من الناحية القانونية:\n');
    } else if (question.contains('متى')) {
      buffer.writeln('من حيث التوقيت والإجراءات:\n');
    }

    // المحتوى الأساسي
    for (final line in baseAnswer) {
      buffer.writeln('• $line');
    }

    // خاتمة ذكية
    buffer.writeln('\nإذا تحب، نقدر نوضح نقطة معيّنة أكثر.');

    return buffer.toString();
  }
}
