import 'package:flutter/material.dart';
import '../theme.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'AT&T', 'id': 'att', 'accent': QPalette.primary},
      {'name': 'Electric', 'id': 'electric', 'accent': Colors.orange},
      {'name': 'Water', 'id': 'water', 'accent': Colors.teal},
      {'name': 'Netflix', 'id': 'nflix', 'accent': Colors.pink},
      {'name': 'Insurance', 'id': 'ins', 'accent': Colors.indigo},
    ];

    return QSurface(
      title: 'Bills',
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          final b = items[i];
          final Color accent = b['accent'] as Color;
          return QCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accent.withOpacity(.12),
                  child: Icon(Icons.receipt_long_outlined, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b['name'] as String, style: QTheme.h6),
                      const SizedBox(height: 6),
                      Text('Avg \$120 • Due around the 12th • Autopay on', style: QTheme.bodyMuted),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/bill-detail',
                      arguments: {'id': b['id'], 'name': b['name'], 'dueDay': '12'},
                    );
                  },
                  child: const Text('Manage'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
