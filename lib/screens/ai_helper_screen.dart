import 'package:flutter/material.dart';
import '../theme.dart';

class AIHelperScreen extends StatelessWidget {
  const AIHelperScreen({super.key});

  void _prefillChat(BuildContext context, String prompt) {
    // TODO: wire this into your chat widget. For now, show a snack.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Prefill: $prompt')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <_Action>[
      _Action(
        icon: Icons.auto_awesome_outlined,
        title: 'Find Savings',
        text: 'Scan bills for lower plans, promo rates, and bundling.',
        prompt: 'Analyze my connected bills and suggest cheaper plans or promos.',
      ),
      _Action(
        icon: Icons.trending_up_outlined,
        title: 'Forecast Budget',
        text: 'Predict quarterly payment and cash buffer needs.',
        prompt: 'Forecast my quarter: expected total, due dates, and buffer suggestions.',
      ),
      _Action(
        icon: Icons.receipt_long_outlined,
        title: 'Explain Fees',
        text: 'Plain-English fee breakdown and how to reduce them.',
        prompt: 'Explain my fees in plain English and give concrete reduction steps.',
      ),
      _Action(
        icon: Icons.favorite_outline,
        title: 'Help Me Save',
        text: 'Round-ups and instant boost suggestions you can act on.',
        prompt: 'Create a savings plan: round-ups + one-time boost to reach 0% fee.',
      ),
    ];

    return QSurface(
      title: 'AI Helper',
      subtitle: 'Tap an action to prefill the chat with the right prompt.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1060),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
            child: LayoutBuilder(
              builder: (context, c) {
                final isNarrow = c.maxWidth < 820;
                final cardWidth = isNarrow ? c.maxWidth : (c.maxWidth - 16) / 2;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: actions.map((a) {
                    return SizedBox(
                      width: cardWidth,
                      child: _ActionCard(
                        action: a,
                        onTap: () => _prefillChat(context, a.prompt),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Action {
  final IconData icon;
  final String title;
  final String text;
  final String prompt;
  _Action({required this.icon, required this.title, required this.text, required this.prompt});
}

class _ActionCard extends StatelessWidget {
  final _Action action;
  final VoidCallback onTap;
  const _ActionCard({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: QCard(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundColor: tint, child: Icon(action.icon)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(action.title, style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(action.text, style: QTheme.bodyMuted),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: QButton.icon(
                      icon: Icons.chat_bubble_outline,
                      label: 'Use this in chat',
                      onPressed: onTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
