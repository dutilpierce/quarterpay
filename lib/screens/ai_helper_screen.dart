import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/ai_chat_widget.dart';

class AIHelperScreen extends StatefulWidget {
  const AIHelperScreen({super.key});
  @override
  State<AIHelperScreen> createState() => _AIHelperScreenState();
}

class _AIHelperScreenState extends State<AIHelperScreen> {
  bool open = true;
  @override
  Widget build(BuildContext context) {
    Widget big(String title, IconData icon, Color bg) {
      return QCard(
        child: Container(
          height: 220,
          decoration: BoxDecoration(color: bg.withOpacity(.2), borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 22, backgroundColor: Colors.white, child: Icon(icon, color: QPalette.primary)),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          ]),
        ),
      );
    }

    return ListView(
      children: [
        Text('AI Helper', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 16, mainAxisSpacing: 16,
          crossAxisCount: MediaQuery.sizeOf(context).width > 1100 ? 2 : 1,
          children: [
            big('Find Savings', Icons.savings, const Color(0xFFDFF7F5)),
            big('Forecast Budget', Icons.stacked_line_chart, const Color(0xFFEAE7FF)),
            big('Explain Fees', Icons.receipt_long_outlined, const Color(0xFFFFF0DA)),
            big('Help Me Save', Icons.lightbulb_outline, const Color(0xFFFFE1E8)),
          ],
        ),
        const SizedBox(height: 24),
        if (open) SizedBox(height: 500, child: const AIChatWidget()),
      ],
    );
  }
}
