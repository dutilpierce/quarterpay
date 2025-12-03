import 'package:flutter/material.dart';
import '../theme.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stepsTop = [
      _FlowCard(
        icon: Icons.link_outlined,
        title: 'Connect',
        text: 'Link your bank via Plaid to detect recurring bills.',
      ),
      _FlowCard(
        icon: Icons.grid_view_rounded,
        title: 'Combine',
        text: 'Monthly bills are combined into a single quarterly total.',
      ),
      _FlowCard(
        icon: Icons.savings_outlined,
        title: 'Escrow Buffer',
        text: 'Round-ups + deposits build a safety buffer each quarter.',
      ),
    ];

    final stepsBottom = [
      _FlowCard(
        icon: Icons.payments_outlined,
        title: 'Quarterly Pay',
        text: 'You pay once; we disburse monthly to each biller on time.',
      ),
      _FlowCard(
        icon: Icons.verified_user_outlined,
        title: 'Protect Credit',
        text: 'On-time payments reduce stress and protect your credit.',
      ),
    ];

    return QSurface(
      title: 'How It Works',
      subtitle: 'A simple flow with no gotchas.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Row 1 with arrows between cards
              _FlowRow(cards: stepsTop),

              const SizedBox(height: 16),

              // Row 2 with a centered arrow between the two cards
              _FlowRow(cards: stepsBottom),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlowRow extends StatelessWidget {
  final List<Widget> cards;
  const _FlowRow({required this.cards});

  @override
  Widget build(BuildContext context) {
    // slightly larger cards + arrows placed between
    final children = <Widget>[];
    for (var i = 0; i < cards.length; i++) {
      children.add(Expanded(child: cards[i]));
      if (i != cards.length - 1) {
        children.add(const _BetweenArrow());
      }
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}

class _BetweenArrow extends StatelessWidget {
  const _BetweenArrow();

  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 36),
      child: Container(
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(Icons.arrow_forward_rounded, size: 20, color: QPalette.primary),
      ),
    );
  }
}

class _FlowCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _FlowCard({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: QCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: QPalette.primary, size: 20),
            ),
            const SizedBox(height: 10),
            Text(title, style: QTheme.h6),
            const SizedBox(height: 4),
            Text(text, style: QTheme.body),
          ],
        ),
      ),
    );
  }
}
