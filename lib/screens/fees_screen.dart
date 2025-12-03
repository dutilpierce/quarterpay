import 'package:flutter/material.dart';
import '../theme.dart';
import '../Content/escrow_content.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Fees & How They Work',
      subtitle:
          'Your quarterly fee is based on actual credit used with a 5% floor on your quarter’s scheduled total. '
          'Round-ups and escrow deposits can reduce the effective cost by up to ~1%.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('What you pay at quarter end'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(
                  'Base fee on credit usage',
                  'We charge a base percentage only on the amounts that actually used the credit line (escrow-covered amounts do not incur the base fee).',
                ),
                const SizedBox(height: 8),
                _bullet(
                  'Floor for the whole quarter',
                  'There is a minimum effective fee (5% floor) applied to your total scheduled bill amount for the quarter—this ensures predictable coverage and program stability.',
                ),
                const SizedBox(height: 8),
                _bullet(
                  'You pay the greater of:',
                  'A) Base% × CreditUsed  — OR —  B) 5% × TotalScheduledForQuarter.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const SectionHeader('How round-ups & escrow deposits help'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(
                  'Escrow-first coverage',
                  'As you deposit, we reserve upcoming bills in escrow. When due, escrow pays first and reduces your credit usage (which can lower the base fee route).',
                ),
                const SizedBox(height: 8),
                _bullet(
                  'Tiered rewards (capped)',
                  'Deposits can earn tiered rewards (1–3%, capped per quarter). Rewards are applied to upcoming bills or your end-of-quarter payment.',
                ),
                const SizedBox(height: 8),
                _bullet(
                  'Up to ~1% effective reduction',
                  'Between escrow-first + rewards, most users can trim ~0–1% off the effective cost (depends on deposit timing, tiers, caps, and how much credit gets used).',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const SectionHeader('Clear examples'),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: const [
              _ExampleCard(
                title: 'Example A — No escrow deposits',
                lines: [
                  'Total scheduled bills this quarter: \$3,000',
                  'Escrow coverage: \$0  → CreditUsed: \$3,000',
                  'Base% × CreditUsed = 7% × \$3,000 = \$210',
                  'Floor = 5% × \$3,000 = \$150',
                  'You pay the greater → \$210',
                ],
              ),
              _ExampleCard(
                title: 'Example B — Partial escrow + rewards',
                lines: [
                  'Total scheduled bills: \$3,000',
                  'You deposit \$600 (Tier 3, 3% reward, capped per quarter)',
                  'Escrow secured \$600 → CreditUsed ≈ \$2,400',
                  'Base route: 7% × \$2,400 = \$168',
                  'Floor route: 5% × \$3,000 = \$150',
                  'Greater is \$168',
                  'Apply reward (subject to quarterly cap) → reduces what you owe at EOQ',
                ],
              ),
              _ExampleCard(
                title: 'Example C — Mostly escrow, tiny credit usage',
                lines: [
                  'Total scheduled bills: \$3,000',
                  'Escrow covered \$2,900 → CreditUsed ≈ \$100',
                  'Base route: 7% × \$100 = \$7',
                  'Floor route: 5% × \$3,000 = \$150',
                  'Greater is \$150 → you pay the floor, minus any reward credits (up to cap).',
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
          const SectionHeader('FAQs'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Faq(
                  q: 'Why is there a floor?',
                  a: 'It guarantees predictable coverage and program stability. The floor is calculated on your total scheduled bill amount for the quarter.',
                ),
                _Faq(
                  q: 'Do I always get rewards?',
                  a: 'Rewards apply to qualifying deposits (with tiers and caps). Internal transfers or gaming behaviors are excluded by cooldowns and controls.',
                ),
                _Faq(
                  q: 'Does escrow eliminate the fee?',
                  a: 'Escrow reduces credit usage and can lower the base route, but the end result is still the greater of Base%×Usage vs 5% floor (minus applicable rewards).',
                ),
                _Faq(
                  q: 'When do I see my exact fee?',
                  a: 'You get EOQ previews at D-10, D-5, and D-1 with a clear breakdown of credit usage, floor, and reward credits.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String title, String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline, size: 18, color: QPalette.slateMuted),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 4),
                  Text(text, style: QTheme.body),
                ],
              ),
            ),
          ],
        ),
      );
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final List<String> lines;
  const _ExampleCard({required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: QCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: QTheme.h6),
            const SizedBox(height: 8),
            ...lines.map((l) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(l, style: QTheme.body),
                )),
          ],
        ),
      ),
    );
  }
}

class _Faq extends StatelessWidget {
  final String q, a;
  const _Faq({required this.q, required this.a});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(q, style: QTheme.h6),
          const SizedBox(height: 4),
          Text(a, style: QTheme.body),
        ],
      ),
    );
  }
}
