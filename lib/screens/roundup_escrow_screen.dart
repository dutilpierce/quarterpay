import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/escrow_service.dart';

class RoundUpEscrowScreen extends StatefulWidget {
  const RoundUpEscrowScreen({super.key});

  @override
  State<RoundUpEscrowScreen> createState() => _RoundUpEscrowScreenState();
}

class _RoundUpEscrowScreenState extends State<RoundUpEscrowScreen> {
  @override
  Widget build(BuildContext context) {
    return QSurface(
      child: StreamBuilder<double>(
        stream: EscrowService.stream,
        initialData: EscrowService.current,
        builder: (context, s) {
          final amt = s.data ?? 114.0;
          final pct = (amt / EscrowService.quarterlyTarget).clamp(0.0, 1.0);

          return QCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                  Icon(Icons.lock_rounded, size: 42, color: QPalette.slate),
                  SizedBox(width: 10),
                  Text('\$114 LOCKED', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
                ]),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    minHeight: 14,
                    value: pct,
                    backgroundColor: Colors.black12,
                    color: QPalette.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('33% complete', style: TextStyle(color: QPalette.slateMuted)),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: _Bullet('Every purchase → spare change locked instantly')),
                    SizedBox(width: 16),
                    Expanded(child: _Bullet('No debit card on escrow → CANNOT spend it')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.savings_rounded),
                        label: const Text('Enable Round-Ups'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.flash_on_rounded),
                        label: const Text('Instant Boost'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('• ', style: TextStyle(fontSize: 18)),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
    ]);
  }
}
