import 'package:flutter/material.dart';
import '../theme.dart';

class ForBanksScreen extends StatelessWidget {
  const ForBanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'For Banks & Ops',
      subtitle: 'Pilot up to 500 users; we handle bill servicing, reminders, and AI analysis.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: const [
              _Tile(
                icon: Icons.verified_user_outlined,
                title: 'KYC/AML ready',
                text: 'Use your existing onboarding or ours; Plaid + Stripe flows.',
              ),
              _Tile(
                icon: Icons.receipt_long_outlined,
                title: 'Bill-level servicing',
                text: 'We read statements, schedule payments, and reconcile status.',
              ),
              _Tile(
                icon: Icons.analytics_outlined,
                title: 'AI insights',
                text: 'Explain fees, spot waste, and recommend savings per user.',
              ),
              _Tile(
                icon: Icons.shield_outlined,
                title: 'Compliance minded',
                text: 'SOC2 pathways, data minimization, and clear user controls.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _Tile({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: SizedBox(
        width: 380,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 22, backgroundColor: QTheme.brandTint(context), child: Icon(icon, color: QPalette.primary)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: QTheme.h6),
                const SizedBox(height: 4),
                Text(text, style: QTheme.bodyMuted),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
