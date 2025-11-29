import 'dart:async';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await dotenv.load(fileName: '.env');
    final key = dotenv.env['OPENAI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('Missing OPENAI_API_KEY in .env');
    }
    OpenAI.apiKey = key;
    _initialized = true;
  }

  static Stream<String> streamChat({required List<Map<String, String>> messages}) async* {
    await init();
    final chatMessages = messages.map((m) {
      final role = switch (m['role']) {
        'system' => OpenAIChatMessageRole.system,
        'assistant' => OpenAIChatMessageRole.assistant,
        _ => OpenAIChatMessageRole.user,
      };
      return OpenAIChatCompletionChoiceMessageModel(
        role: role,
        content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(m['content'] ?? '')],
      );
    }).toList();

    final stream = OpenAI.instance.chat.createStream(
      model: 'gpt-4o-mini',
      messages: chatMessages,
      temperature: 0.7,
    );

    final controller = StreamController<String>();
    stream.listen((event) {
      final delta = event.choices.first.delta?.content
              ?.map((c) => c?.text ?? '')
              .join('') ?? '';
      if (delta.isNotEmpty) controller.add(delta);
    }, onError: controller.addError, onDone: controller.close);

    yield* controller.stream;
  }
}
