import 'package:flutter/material.dart';
import '../theme.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fees', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),

          // Infographic: fee trajectory (visual, not numbers-heavy)
          QCard(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('How your fee goes down', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              LayoutBuilder(builder: (context, c) {
                return Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: QPalette.primary.withOpacity(.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    // base fee segment
                    Expanded(
                      flex: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: QPalette.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    // savings / boost impact segment
                    Expanded(
                      flex: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [QPalette.primary.withOpacity(.6), Colors.transparent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ]),
                );
              }),
              const SizedBox(height: 8),
              const Text('Pay on time and enable Round-Ups / Escrow Boost to reduce your fee automatically.',
                  style: TextStyle(color: QPalette.slateMuted)),
            ]),
          ),

          const SizedBox(height: 16),

          // Two clear paths, no dollar figures
          Row(
            children: const [
              Expanded(child: _InfoCard(
                icon: Icons.savings_rounded,
                title: 'Round-Ups • Escrow Boost',
                subtitle: 'Your spare change moves to an escrow—no card to spend from.',
                details: 'Every purchase moves rounded spare change into savings, lowering your fee over time.',
              )),
              SizedBox(width: 16),
              Expanded(child: _InfoCard(
                icon: Icons.flash_on_rounded,
                title: 'Instant Boost',
                subtitle: 'Deposit a buffer up front.',
                details: 'Add a one-time buffer and get to the lowest fee tier immediately.',
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String details;
  const _InfoCard({required this.icon, required this.title, required this.subtitle, required this.details});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 24, backgroundColor: QPalette.primary.withOpacity(.12),
              child: Icon(icon, color: QPalette.primary)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: QPalette.slate)),
              const SizedBox(height: 6),
              Text(details, style: const TextStyle(color: QPalette.slateMuted)),
            ]),
          ),
        ],
      ),
    );
  }
}
