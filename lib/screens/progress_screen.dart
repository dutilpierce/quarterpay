import 'package:flutter/material.dart';
import '../theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Your Escrow',
      subtitle: 'One quarterly payment; we handle the monthly billers. Track usage, fee estimate, and escrow boosts here.',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ====== MAIN PROGRESS ======
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quarter progress', style: QTheme.h6),
                  const SizedBox(height: 8),
                  Text(
                    'Usage of your QuarterPay credit line so far. Milestones help you plan your quarter and stay ahead.',
                    style: QTheme.body,
                  ),
                  const SizedBox(height: 12),
                  _ProgressBar(percent: .62),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _Milestone(label: '33%', amount: 1200),
                      _Milestone(label: '66%', amount: 2400),
                      _Milestone(label: '100%', amount: 3600),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ====== MINI TIPS / FILL NEGATIVE SPACE ======
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _MiniTip(
                  icon: Icons.shield_moon_outlined,
                  title: 'On-time bill protection',
                  text: 'We pay eligible billers monthly to protect your credit score.',
                ),
                _MiniTip(
                  icon: Icons.auto_graph_outlined,
                  title: 'Plan your quarter',
                  text: 'Use milestones to forecast spend and the quarter-end repayment.',
                ),
                _MiniTip(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Lower your fee',
                  text: 'Round-ups & early escrow deposits can reduce your fee down to the floor.',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ====== BILLER PAYMENT STATUS ======
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Biller payment status', style: QTheme.h6),
                  const SizedBox(height: 8),
                  Text(
                    'QuarterPay disburses payments to your billers monthly. Here’s what’s been paid so far this quarter.',
                    style: QTheme.body,
                  ),
                  const SizedBox(height: 12),
                  ...[
                    _BillerRow(name: 'Electric', month: 'Nov', status: 'Paid',  icon: Icons.bolt_outlined),
                    _BillerRow(name: 'Internet', month: 'Nov', status: 'Paid',  icon: Icons.wifi_outlined),
                    _BillerRow(name: 'Water',    month: 'Nov', status: 'Queued', icon: Icons.water_drop_outlined),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ====== ESCROW & BOOSTS (moved here from the Escrow Boost page) ======
            _EscrowSection(),
          ],
        ),
      ),
    );
  }
}

// -------------------- widgets --------------------

class _ProgressBar extends StatelessWidget {
  final double percent;
  const _ProgressBar({required this.percent});

  @override
  Widget build(BuildContext context) {
    final p = percent.clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth * p;
        return Stack(
          children: [
            Container(
              height: 14,
              decoration: BoxDecoration(
                color: QPalette.cardFill.withOpacity(.5),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: 14,
              width: w,
              decoration: BoxDecoration(
                color: QPalette.primary,
                borderRadius: BorderRadius.circular(999),
                boxShadow: QShadows.soft,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Milestone extends StatelessWidget {
  final String label;
  final double amount;
  const _Milestone({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.flag_outlined, size: 18, color: QPalette.slateMuted),
        const SizedBox(width: 6),
        Text('$label at \$${amount.toStringAsFixed(0)}', style: QTheme.bodyMuted),
      ],
    );
  }
}

class _MiniTip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _MiniTip({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: QCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: QPalette.slate, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(text, style: QTheme.body),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BillerRow extends StatelessWidget {
  final String name;
  final String month;
  final String status;
  final IconData icon;
  const _BillerRow({required this.name, required this.month, required this.status, required this.icon});

  @override
  Widget build(BuildContext context) {
    final ok = status.toLowerCase() == 'paid';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: QTheme.brandTint(context),
            child: Icon(icon, color: QPalette.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text('$name — $month', style: QTheme.body),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: (ok ? QPalette.success : QPalette.info).withOpacity(.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: QTheme.small.copyWith(color: ok ? QPalette.success : QPalette.info, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

/// Distinct but on-brand section that consolidates the old Escrow Boost content.
class _EscrowSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return QCard(
      overlayColor: tint, // subtle tint to distinguish the area
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Escrow & Boosts', style: QTheme.h6),
          const SizedBox(height: 6),
          Text(
            'Grow your escrow automatically with round-ups, or add an Instant Boost when you need to bring your end-of-quarter '
            'payment down. Small deposits over time can reduce your fee down to the floor.',
            style: QTheme.body,
          ),
          const SizedBox(height: 12),

          // Row of concise action/info cards
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 900;
              final children = const [
                _EscrowCard(
                  icon: Icons.savings_outlined,
                  title: 'Round-Ups',
                  bullets: [
                    'Auto-save spare change from purchases',
                    'Applies to escrow to reduce EOQ fee',
                    'Toggle anytime',
                  ],
                ),
                _EscrowCard(
                  icon: Icons.bolt_outlined,
                  title: 'Instant Boost',
                  bullets: [
                    'One-tap escrow top-up',
                    'Use when you want a lower EOQ payment',
                    'Great before quarter end',
                  ],
                  primaryCta: 'Add Instant Boost',
                ),
                _EscrowCard(
                  icon: Icons.lock_outline,
                  title: 'Auto-Lock',
                  bullets: [
                    'Escrow funds are reserved for quarter end',
                    'Unlock only with repayment schedule updates',
                    'Visibility inside Overview & History',
                  ],
                ),
                _EscrowCard(
                  icon: Icons.percent_outlined,
                  title: 'Fee Floor',
                  bullets: [
                    'Base fee (e.g., 7%) can be reduced via escrow',
                    'Never below program floor (e.g., 6%)',
                    'Shown on EOQ summary',
                  ],
                ),
              ];
              return isNarrow
                  ? Column(
                      children: children
                          .map((w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w))
                          .toList(),
                    )
                  : Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: children
                          .map((w) => SizedBox(width: (c.maxWidth - 36) / 2, child: w))
                          .toList(),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _EscrowCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> bullets;
  final String? primaryCta;
  const _EscrowCard({
    required this.icon,
    required this.title,
    required this.bullets,
    this.primaryCta,
  });

  @override
  Widget build(BuildContext context) {
    final accent = QPalette.primary.withOpacity(.12);
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(backgroundColor: accent, child: Icon(icon, color: QPalette.primary)),
            const SizedBox(width: 10),
            Text(title, style: QTheme.h6),
          ]),
          const SizedBox(height: 10),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Icon(Icons.check_circle_outline, size: 16, color: QPalette.slate),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(b, style: QTheme.body)),
                  ],
                ),
              )),
          if (primaryCta != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {/* TODO: hook to your flow */},
                icon: const Icon(Icons.bolt_outlined, size: 18),
                label: Text(primaryCta!),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  backgroundColor: QPalette.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
