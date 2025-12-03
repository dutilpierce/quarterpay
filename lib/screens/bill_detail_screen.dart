import 'package:flutter/material.dart';
import '../theme.dart';

class BillDetailScreen extends StatelessWidget {
  const BillDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final name = (args['name'] ?? 'Bill') as String;
    final dueDay = (args['dueDay'] ?? 'TBD') as String;

    return QSurface(
      title: '$name — Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QCard(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0x1100A3A3),
                  child: Icon(Icons.receipt_long_outlined, color: QPalette.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: QTheme.h6),
                      const SizedBox(height: 6),
                      Text('Due: $dueDay • Autopay enabled', style: QTheme.bodyMuted),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/ai-helper');
                  },
                  icon: const Icon(Icons.bolt_outlined),
                  label: const Text('Analyze this bill'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _L('Average monthly'), _V('\$144'),
                SizedBox(height: 10),
                _L('Category'), _V('Utilities'),
                SizedBox(height: 10),
                _L('Suggestions'),
                _V('Consider autopay discount and paperless billing; we’ll watch for rate changes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _L extends StatelessWidget {
  final String t; const _L(this.t);
  @override Widget build(BuildContext context) => Text(t, style: QTheme.bodyMuted);
}
class _V extends StatelessWidget {
  final String t; const _V(this.t);
  @override Widget build(BuildContext context) => Text(t, style: QTheme.body);
}
