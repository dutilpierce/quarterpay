import 'package:flutter/material.dart';
import '../widgets/ai_chat_widget.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FAQ', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('Ask anything — answers generated instantly.'),
        const SizedBox(height: 16),
        const Expanded(child: AIChatWidget()),
      ],
    );
  }
}
