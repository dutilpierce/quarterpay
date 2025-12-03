import 'package:flutter/material.dart';
import '../theme.dart';

class EoqPaymentCard extends StatelessWidget {
  final double totalScheduled;   // total quarter spend (scheduled)
  final double creditUsed;       // what’s been used so far
  final double basePct;          // e.g. 0.07
  final double floorPct;         // e.g. 0.05
  final double rewardsApplied;   // e.g. escrow / roundups applied as $ off fee
  final String? note;

  const EoqPaymentCard({
    super.key,
    required this.totalScheduled,
    required this.creditUsed,
    required this.basePct,
    required this.floorPct,
    required this.rewardsApplied,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    // --- fee math ---
    final double baseFee   = (totalScheduled * basePct);
    final double floorFee  = (totalScheduled * floorPct);
    // reduce base fee by rewards, but never below the floor
    final double feeAfter  = (baseFee - rewardsApplied).clamp(floorFee, double.infinity);

    // progress (creditUsed vs totalScheduled)
    final double progress  = totalScheduled > 0 ? (creditUsed / totalScheduled).clamp(0, 1) : 0;

    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('End-of-Quarter Summary', style: QTheme.h6),
          const SizedBox(height: 8),
          Text(
            'We pay your billers monthly from your QuarterPay line. At the end of the quarter, '
            'you make a single repayment. Escrow/Round-ups can reduce your fee, with a minimum floor.',
            style: QTheme.body,
          ),

          const SizedBox(height: 12),

          // Usage progress
          _usageBar(progress: progress),

          const SizedBox(height: 12),

          // Numbers
          _row('Total scheduled', _money(totalScheduled)),
          _row('Credit used so far', _money(creditUsed)),
          const Divider(height: 20),

          _row('Base fee (${_pct(basePct)})', _money(baseFee)),
          _row('Rewards applied', '-${_money(rewardsApplied)}', valueColor: QPalette.success),
          _row('Minimum fee floor (${_pct(floorPct)})', _money(floorFee), valueColor: QPalette.slateMuted),
          const SizedBox(height: 6),

          _row('Estimated EOQ fee', _money(feeAfter), isStrong: true),

          if (note != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: QTheme.brandTint(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(note!, style: QTheme.body),
            )
          ],
        ],
      ),
    );
  }

  // helpers

  static String _money(double v) => '\$${v.toStringAsFixed(2)}';
  static String _pct(double p) => '${(p * 100).toStringAsFixed(0)}%';

  Widget _row(
    String label,
    String value, {
    bool isStrong = false,
    Color? valueColor,
  }) {
    final TextStyle left  = isStrong ? QTheme.body.copyWith(fontWeight: FontWeight.w700) : QTheme.body;
    final TextStyle right = (isStrong ? QTheme.body.copyWith(fontWeight: FontWeight.w700) : QTheme.body)
        .copyWith(color: valueColor);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: left)),
          Text(value, style: right),
        ],
      ),
    );
  }

  Widget _usageBar({required double progress}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quarter usage', style: QTheme.small),
        const SizedBox(height: 6),
        LayoutBuilder(
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
        ),
      ],
    );
  }
}
