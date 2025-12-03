import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'QuarterPay',
      subtitle: 'One quarterly payment. Three months of breathing room.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero band with simple value props
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: const [
              _HeroPill(icon: Icons.savings_outlined, title: 'Save money', text: 'Lower late fees & overdrafts.'),
              _HeroPill(icon: Icons.credit_score_outlined, title: 'Protect credit', text: 'Never miss due dates.'),
              _HeroPill(icon: Icons.merge_type_rounded, title: 'Combine bills', text: 'One autopay each quarter.'),
              _HeroPill(icon: Icons.trending_down, title: 'Fees to 0%', text: 'Use round-ups & escrow boosts.'),
            ],
          ),
          const SizedBox(height: 24),
          Center(child: Text('What QuarterPay can do for you', style: QTheme.h5)),
          const SizedBox(height: 12),
          // Info tiles
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _InfoTile(
                icon: Icons.payments_outlined,
                title: 'One quarterly payment',
                text: 'We pay your bills monthly; you pay us once per quarter.',
              ),
              _InfoTile(
                icon: Icons.link_outlined,
                title: 'Connect in minutes',
                text: 'Securely link accounts for bill reads & autopay (Plaid + Stripe).',
              ),
              _InfoTile(
                icon: Icons.auto_graph_outlined,
                title: 'Lower your fee',
                text: 'Use round-ups & escrow to bring fees down over time.',
              ),
              _InfoTile(
                icon: Icons.support_agent_outlined,
                title: 'AI helper on every bill',
                text: 'Explain fees, find savings, and forecast your budget.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _HeroPill({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 22, backgroundColor: QTheme.brandTint(context), child: Icon(icon, color: QPalette.primary)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: QTheme.h6),
            const SizedBox(height: 2),
            Text(text, style: QTheme.bodyMuted),
          ]),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _InfoTile({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: SizedBox(
        width: 360,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 22, backgroundColor: QTheme.brandTint(context), child: Icon(icon, color: QPalette.primary)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: QTheme.h6),
                const SizedBox(height: 4),
                Text(text, style: QTheme.body),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
