import 'package:flutter/material.dart';
import '../theme.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bigger rows with icons and clearer separation
    final items = [
      _HistoryRow(
        icon: Icons.lightbulb_outline,
        title: 'Electric — \$112',
        date: 'Dec 12',
        sub: 'Paid via autopay • Confirmation #284901',
        color: const Color(0xFF4C8BF5),
      ),
      _HistoryRow(
        icon: Icons.wifi,
        title: 'AT&T — \$89',
        date: 'Dec 05',
        sub: 'Paid via autopay • Confirmation #284321',
        color: const Color(0xFF00A19B),
      ),
      _HistoryRow(
        icon: Icons.movie_outlined,
        title: 'Netflix — \$16',
        date: 'Dec 12',
        sub: 'Paid via autopay • Confirmation #284322',
        color: const Color(0xFF845EF7),
      ),
    ];

    return QSurface(
      title: 'History',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              for (final row in items) ...[
                QCard(child: row),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String sub;
  final Color color;
  const _HistoryRow({
    required this.icon,
    required this.title,
    required this.date,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: QTheme.h6),
                const SizedBox(height: 2),
                Text(sub, style: QTheme.bodyMuted),
              ],
            ),
          ),
          Text(date, style: QTheme.body),
        ],
      ),
    );
  }
}
