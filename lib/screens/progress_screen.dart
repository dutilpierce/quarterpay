import 'package:flutter/material.dart';
import '../theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Your Escrow',
      subtitle: 'Milestones at 33%, 66%, and 100% toward your quarterly buffer.',
      child: Column(
        children: [
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Buffer completion', style: QTheme.h6),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: .33,
                    minHeight: 14,
                    backgroundColor: QTheme.brandTint(context),
                    color: QPalette.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text('33% • \$114 of \$342', style: QTheme.bodyMuted),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // three info cards auto height (no giant empty space)
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: const [
              _MiniTip(
                title: 'Round-Ups',
                text: 'Spare change goes to escrow.\nEx: \$3.41 → \$0.59 saved.',
              ),
              _MiniTip(
                title: 'Instant Boost',
                text: 'Deposit upfront to reach 100% now.\nEx: add \$228 → fee drops.',
              ),
              _MiniTip(
                title: 'On-time autopay',
                text: 'We disburse monthly so bills stay current.\nEx: utilities paid on due date.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniTip extends StatelessWidget {
  final String title, text;
  const _MiniTip({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: QCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: QTheme.h6),
            const SizedBox(height: 6),
            Text(text, style: QTheme.bodyMuted),
          ],
        ),
      ),
    );
  }
}
