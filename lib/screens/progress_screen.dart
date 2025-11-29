import 'package:flutter/material.dart';
import '../theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              Text('Your Escrow Progress', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              const Text('Build your buffer to reduce fees automatically.', style: TextStyle(color: QPalette.slateMuted)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: const [
                Icon(Icons.lock_outline),
                SizedBox(width: 8),
                Text('Escrow Boost', style: TextStyle(fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: 114 / 342,
                  minHeight: 18,
                  backgroundColor: QPalette.border,
                  color: QPalette.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text('33% complete', style: TextStyle(color: QPalette.slateMuted)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _MiniStat(icon: Icons.savings_outlined, label: 'Round-ups', value: '\$68 this month'),
            _MiniStat(icon: Icons.payments_outlined, label: 'Instant Boost', value: '\$100 buffer'),
            _MiniStat(icon: Icons.trending_up, label: 'Projected', value: '0% fee in 90d'),
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon; final String label; final String value;
  const _MiniStat({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: QCard(
        child: Row(children: [
          CircleAvatar(radius: 24, backgroundColor: QPalette.primary.withOpacity(.12), child: Icon(icon, color: QPalette.primary)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: QPalette.slateMuted, fontSize: 12)),
          ])
        ]),
      ),
    );
  }
}
