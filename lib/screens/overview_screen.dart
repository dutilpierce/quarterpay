import 'package:flutter/material.dart';
import '../theme.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Overview',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          children: [
            // Stat tiles
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.35,
              children: const [
                _Tile(
                  icon: Icons.calendar_month,
                  title: 'Quarterly Payment',
                  big: '\$3,741',
                  sub: 'Next due Dec 31. We handle biller payments monthly.',
                ),
                _Tile(
                  icon: Icons.lock_outline,
                  title: 'Escrow Locked',
                  big: '\$114 (33%)',
                  sub: 'Round-ups & deposits increase this buffer automatically.',
                ),
                _Tile(
                  icon: Icons.verified_user_outlined,
                  title: 'Coverage',
                  big: 'Autopay ON',
                  sub: 'Eligible bills are paid on time to protect your credit.',
                ),
              ],
            ),
            const SizedBox(height: 16),
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How this works', style: QTheme.h6),
                  const SizedBox(height: 8),
                  Text(
                    'You make one payment per quarter. QuarterPay splits and disburses '
                    'to your billers monthly. If you enable round-ups/escrow, your fee can '
                    'be offset by automated savings.',
                    style: QTheme.body,
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

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String big;
  final String sub;
  const _Tile({required this.icon, required this.title, required this.big, required this.sub});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: QTheme.brandTint(context), child: Icon(icon)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: QTheme.h6),
                const SizedBox(height: 6),
                Text(big, style: QTheme.h4),
                const SizedBox(height: 6),
                Text(sub, style: QTheme.bodyMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
