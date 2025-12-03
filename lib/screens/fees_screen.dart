import 'package:flutter/material.dart';
import '../theme.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Fees',
      subtitle: 'Simple, transparent — and designed to go down as you build good habits.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Step bar (7% -> 4% -> 0%) as a simple infographic
          QCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader('How fees reduce over time'),
                const SizedBox(height: 8),
                Text(
                  'Start here and trend down with Escrow Boost + Round-Ups + on-time payments.',
                  style: QTheme.bodyMuted,
                ),
                const SizedBox(height: 18),
                _StepRow(label: 'Initial', percent: .33, color: QPalette.warning),
                const SizedBox(height: 10),
                _StepRow(label: 'Improving', percent: .66, color: QPalette.info),
                const SizedBox(height: 10),
                _StepRow(label: 'Best rate', percent: 1.0, color: QPalette.success),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Two info cards: Escrow Boost vs Instant Boost
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _InfoCard(
                icon: Icons.savings_outlined,
                title: 'Escrow Boost',
                text:
                    'Lock small amounts you already plan to use. This improves risk profile and reduces fees as you go.',
              ),
              _InfoCard(
                icon: Icons.bolt_outlined,
                title: 'Instant Boost',
                text:
                    'Need to lower your quarterly outlay now? Inject a one-time amount to immediately drop your effective rate.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  const _StepRow({required this.label, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return QCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: QTheme.body)),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 12,
                color: color,
                backgroundColor: QPalette.border,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _InfoCard({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 560,
      child: QCard(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: QTheme.brandTint(context),
              child: Icon(icon, color: QPalette.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(text, style: QTheme.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
