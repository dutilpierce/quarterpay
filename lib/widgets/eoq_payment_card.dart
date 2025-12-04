import 'package:flutter/material.dart';
import '../theme.dart';

class EoqPaymentCard extends StatelessWidget {
  /// Total scheduled this quarter (legacy prop; used for copy/progress visuals).
  final double totalScheduled;

  /// Credit used so far this quarter (gross).
  final double creditUsed;

  /// Usage rate, e.g. 0.07 for 7%.
  final double basePct;

  /// Floor rate, e.g. 0.02 for 2%.
  final double floorPct;

  /// Escrow/round-ups PREVIEW applied against usage basis (reduces usage fee only).
  final double rewardsApplied;

  /// (Optional) Approved quarterly coverage limit (line). If null, falls back to totalScheduled.
  final double? lineQtr;

  /// (Optional) Same-quarter refunds that reduce usage basis.
  final double? refundsSameQtr;

  /// Optional note bubble.
  final String? note;

  const EoqPaymentCard({
    super.key,
    required this.totalScheduled,
    required this.creditUsed,
    required this.basePct,
    required this.floorPct,
    required this.rewardsApplied,
    this.lineQtr,
    this.refundsSameQtr,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    // Line used for floor fee (defaults to totalScheduled if lineQtr missing)
    final double lineForFloor = (lineQtr ?? totalScheduled).clamp(0, double.infinity);

    // Usage basis = credit used minus refunds minus escrow preview
    final double adjustedUsed =
        (creditUsed - (refundsSameQtr ?? 0) - rewardsApplied).clamp(0, double.infinity);

    final double usageFee = adjustedUsed * basePct;
    final double floorFee = lineForFloor * floorPct;
    final double eoqFee = usageFee > floorFee ? usageFee : floorFee;

    // Visual progress bar (credit used vs line)
    final double denom = lineForFloor > 0 ? lineForFloor : (totalScheduled > 0 ? totalScheduled : 1);
    final double progress = (creditUsed / denom).clamp(0, 1);

    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('End-of-Quarter Summary', style: QTheme.h6),
          const SizedBox(height: 8),
          Text(
            'We pay billers monthly from your QuarterPay line. At quarter’s end, your fee is the greater of '
            '${_pct(basePct)} of credit actually used (after refunds & escrow preview), or ${_pct(floorPct)} of your approved line.',
            style: QTheme.body,
          ),

          const SizedBox(height: 12),
          _usageBar(progress: progress),

          const SizedBox(height: 12),
          _row('Approved quarterly line', _money(lineForFloor)),
          _row('Credit used to date', _money(creditUsed)),
          if ((refundsSameQtr ?? 0) > 0)
            _row('Same-quarter refunds', '-${_money(refundsSameQtr ?? 0)}', valueColor: QPalette.slateMuted),
          if (rewardsApplied > 0)
            _row('Escrow applied (preview)', '-${_money(rewardsApplied)}', valueColor: QPalette.slateMuted),

          const Divider(height: 22),

          _row('Usage fee (${_pct(basePct)})', _money(usageFee)),
          _row('Access & Guarantee floor (${_pct(floorPct)})', _money(floorFee)),
          const SizedBox(height: 8),
          _row('Your quarterly program fee (greater of)', _money(eoqFee), isStrong: true),

          if (note != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: QTheme.brandTint(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(note!, style: QTheme.body),
            ),
          ],
        ],
      ),
    );
  }

  // ==== helpers ====

  static String _money(double v) => '\$${v.toStringAsFixed(2)}';
  static String _pct(double p) => '${(p * 100).toStringAsFixed(0)}%';

  Widget _row(
    String label,
    String value, {
    bool isStrong = false,
    Color? valueColor,
  }) {
    final TextStyle left =
        isStrong ? QTheme.body.copyWith(fontWeight: FontWeight.w700) : QTheme.body;
    final TextStyle right =
        (isStrong ? QTheme.body.copyWith(fontWeight: FontWeight.w700) : QTheme.body)
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
