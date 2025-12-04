import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/fee_simulator_panel.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo data (replace with live values when wired up)
    const double quarterlyTarget = 3741; // total scheduled this quarter
    const double escrowLocked     = 114;  // current escrow
    const double creditUsed       = 1260; // used so far (illustrative)

    final double progress = (creditUsed / quarterlyTarget).clamp(0, 1);

    return QSurface(
      title: 'Progress',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== Quarter usage =====
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quarter status', style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(
                    'We pay your billers monthly from your QuarterPay line. '
                    'You make one repayment at the end of the quarter.',
                    style: QTheme.body,
                  ),
                  const SizedBox(height: 12),
                  _UsageBar(progress: progress),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _pill(context, label: '33%'),
                      const SizedBox(width: 8),
                      _pill(context, label: '66%'),
                      const SizedBox(width: 8),
                      _pill(context, label: '100%'),
                      const Spacer(),
                      Text('\$${creditUsed.toStringAsFixed(0)} / \$${quarterlyTarget.toStringAsFixed(0)}',
                          style: QTheme.small),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== Escrow area (distinct tint) =====
            Container(
              decoration: BoxDecoration(
                color: QTheme.brandTint(context),
                borderRadius: BorderRadius.circular(16),
                boxShadow: QShadows.soft,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Escrow & Boosts', style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(
                    'Round-ups and early deposits build a buffer that can reduce your usage fee. '
                    'Escrow never replaces the 2% Program Access & Guarantee fee.',
                    style: QTheme.body,
                  ),
                  const SizedBox(height: 12),

                  // two compact cards inside the tinted container
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _InfoBadge(
                        icon: Icons.savings_outlined,
                        title: 'Escrow locked',
                        big: '\$${escrowLocked.toStringAsFixed(0)}',
                        sub: 'Applied to your quarter at EOQ',
                      ),
                      _InfoBadge(
                        icon: Icons.bolt_outlined,
                        title: 'Instant Boost',
                        big: 'On-demand',
                        sub: 'Add funds now to increase buffer',
                        trailing: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Add funds'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== Tips / guidance =====
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _MiniTip(
                  icon: Icons.autorenew_outlined,
                  title: 'Automate round-ups',
                  text: 'Micro-deposits add up and help offset usage fees.',
                ),
                _MiniTip(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Deposit early',
                  text: 'Early escrow deposits increase your buffer sooner.',
                ),
                _MiniTip(
                  icon: Icons.receipt_long_outlined,
                  title: 'Keep bills linked',
                  text: 'Linked billers are paid on time to protect your credit.',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== Fee simulator (preview) =====
            const FeeSimulatorPanel(),

            const SizedBox(height: 16),

            // ===== Biller payment confidence =====
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment assurance', style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(
                    'We disburse your linked bills monthly. You can view each bill’s status, '
                    'confirmation, and date of payment in History at any time.',
                    style: QTheme.body,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statusDot(color: Colors.green),
                      const SizedBox(width: 8),
                      Text('All scheduled payments are current.', style: QTheme.small),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(BuildContext context, {required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: QTheme.brandTint(context),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: QTheme.small),
    );
  }

  Widget _statusDot({required Color color}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// Compact usage bar that respects theme translucency.
class _UsageBar extends StatelessWidget {
  final double progress;
  const _UsageBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth * progress;
        return Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: QPalette.cardFill.withOpacity(.5),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: 12,
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

/// Small tip card
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
            CircleAvatar(
              backgroundColor: QTheme.brandTint(context),
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 6),
                  Text(text, style: QTheme.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact info badge used inside the tinted escrow area
class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final String big;
  final String sub;
  final Widget? trailing;
  const _InfoBadge({
    required this.icon,
    required this.title,
    required this.big,
    required this.sub,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 420),
      child: QCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: QPalette.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 2),
                  Text(big, style: QTheme.h4),
                  const SizedBox(height: 6),
                  Text(sub, style: QTheme.bodyMuted),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
