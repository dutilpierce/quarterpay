import 'package:flutter/material.dart';
import '../theme.dart';

class FeeSimulatorPanel extends StatefulWidget {
  const FeeSimulatorPanel({super.key});

  @override
  State<FeeSimulatorPanel> createState() => _FeeSimulatorPanelState();
}

class _FeeSimulatorPanelState extends State<FeeSimulatorPanel> {
  // Inputs (defaults are just examples)
  double line = 1200;          // LINE_QTR
  double used = 300;           // CREDIT_USED_QTR (gross)
  double refunds = 0;          // same-quarter refunds only

  // Rates/flags (could be wired to admin config later)
  double floorRate = 0.02;     // 2% Access & Guarantee Fee
  double usageRate = 0.07;     // 7% Usage Fee

  // local helpers
  double get _adjustedUsed => (used - refunds).clamp(0, double.infinity);
  double get _feeUsage => _adjustedUsed * usageRate;
  double get _feeFloor => line * floorRate;
  double get _eoqFee => _feeUsage > _feeFloor ? _feeUsage : _feeFloor;

  @override
  Widget build(BuildContext context) {
    final bool isUsageWins = _feeUsage >= _feeFloor;

    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(Icons.calculate_outlined, color: QPalette.primary),
              const SizedBox(width: 8),
              Text('Quarterly Fee Simulator', style: QTheme.h6),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your quarterly fee is the greater of the Usage Fee (7% of credit used this quarter) '
            'or the 2% Access & Payment Guarantee fee (2% of your approved quarterly line).',
            style: QTheme.body,
          ),

          const SizedBox(height: 16),

          // ===== Controls (sliders) =====
          _groupCard(
            icon: Icons.tune,
            label: 'Inputs',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Approved Quarterly Line',
                  value: line,
                  min: 300,
                  max: 10000,
                  onChanged: (v) => setState(() => line = v),
                  valueText: _money(line),
                ),
                _sliderRow(
                  label: 'Credit Used (gross)',
                  value: used,
                  min: 0,
                  max: line,
                  onChanged: (v) => setState(() => used = v),
                  valueText: _money(used),
                ),
                _sliderRow(
                  label: 'Same-Quarter Refunds',
                  value: refunds.clamp(0, used),
                  min: 0,
                  max: used,
                  onChanged: (v) => setState(() => refunds = v),
                  valueText: '-${_money(refunds.clamp(0, used))}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== Live math preview (with icons + color accents) =====
          _groupCard(
            icon: Icons.visibility_outlined,
            label: 'Live Preview',
            child: Column(
              children: [
                _previewRow(
                  icon: Icons.swap_horiz,
                  label: 'Adjusted credit used',
                  text: _money(_adjustedUsed.toDouble()),
                ),
                _previewRow(
                  icon: Icons.percent,
                  label: 'Usage Fee (7%)',
                  text: _money(_feeUsage.toDouble()),
                  valueColor: isUsageWins ? QPalette.primary : null,
                  bold: isUsageWins,
                ),
                _previewRow(
                  icon: Icons.verified_user_outlined,
                  label: 'Access & Guarantee Fee (2%)',
                  text: _money(_feeFloor.toDouble()),
                  valueColor: !isUsageWins ? QPalette.primary : null,
                  bold: !isUsageWins,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== Animated comparison bars with arrow/highlight =====
          _groupCard(
            icon: Icons.bar_chart_rounded,
            label: 'Comparison',
            child: _comparisonBars(
              context: context,
              usage: _feeUsage.toDouble(),
              floor: _feeFloor.toDouble(),
              winnerIsUsage: isUsageWins,
            ),
          ),

          const SizedBox(height: 12),

          // ===== Result banner (animated) =====
          _resultBanner(
            context: context,
            usage: _feeUsage.toDouble(),
            floor: _feeFloor.toDouble(),
            eoq: _eoqFee.toDouble(),
            usageWins: isUsageWins,
          ),

          const SizedBox(height: 6),

          // ===== Compliance-safe copy =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: QTheme.brandTint(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Quarterly Program Fee: You will be charged the greater of (1) 7% of the credit we covered '
              'for your bills this quarter, or (2) 2% of your approved Quarterly Coverage Limit. This fee '
              'supports payment assurance, underwriting, monitoring, and on-call coverage throughout the quarter.',
              style: QTheme.small,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Widgets ─────────────────────────

  Widget _groupCard({
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.circular(14),
        boxShadow: QShadows.soft,
        border: Border.all(color: QPalette.cardFill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 18, color: QPalette.primary),
            const SizedBox(width: 8),
            Text(label, style: QTheme.body.copyWith(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String valueText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: QTheme.body)),
              Text(valueText, style: QTheme.body.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          Slider(value: value, min: min, max: max, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _previewRow({
    required IconData icon,
    required String label,
    required String text,
    Color? valueColor,
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: QPalette.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: QTheme.body)),
          Text(
            text,
            style: (bold ? QTheme.body.copyWith(fontWeight: FontWeight.w800) : QTheme.body)
                .copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }

  Widget _comparisonBars({
    required BuildContext context,
    required double usage,
    required double floor,
    required bool winnerIsUsage,
  }) {
    // Normalize to bar widths
    final double maxFee = (usage > floor ? usage : floor).clamp(1, double.infinity);
    final double usagePct = (usage / maxFee).clamp(0, 1);
    final double floorPct = (floor / maxFee).clamp(0, 1);

    return Column(
      children: [
        _barRow(
          context: context,
          label: 'Usage Fee',
          amount: usage,
          fraction: usagePct,
          color: QPalette.primary,
          trailing: winnerIsUsage ? const Icon(Icons.arrow_upward, size: 16) : const SizedBox.shrink(),
          bold: winnerIsUsage,
        ),
        const SizedBox(height: 10),
        _barRow(
          context: context,
          label: 'Access & Guarantee',
          amount: floor,
          fraction: floorPct,
          color: Colors.orange,
          trailing: !winnerIsUsage ? const Icon(Icons.arrow_upward, size: 16) : const SizedBox.shrink(),
          bold: !winnerIsUsage,
        ),
      ],
    );
  }

  Widget _barRow({
    required BuildContext context,
    required String label,
    required double amount,
    required double fraction,
    required Color color,
    Widget? trailing,
    bool bold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: Text(label,
                style: bold
                    ? QTheme.body.copyWith(fontWeight: FontWeight.w800)
                    : QTheme.body),
          ),
          Text(_money(amount), style: QTheme.body),
          const SizedBox(width: 6),
          if (trailing != null) trailing,
        ]),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, c) => Stack(
            children: [
              Container(
                height: 12,
                width: c.maxWidth,
                decoration: BoxDecoration(
                  color: QPalette.cardFill.withOpacity(.45),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                height: 12,
                width: c.maxWidth * fraction,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: QShadows.soft,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _resultBanner({
    required BuildContext context,
    required double usage,
    required double floor,
    required double eoq,
    required bool usageWins,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (usageWins ? QPalette.primary : Colors.orange).withOpacity(.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: (usageWins ? QPalette.primary : Colors.orange).withOpacity(.3)),
      ),
      child: Row(
        children: [
          Icon(
            usageWins ? Icons.trending_up : Icons.verified_user_outlined,
            color: usageWins ? QPalette.primary : Colors.orange,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              usageWins
                  ? 'You pay the Usage Fee this quarter.'
                  : 'You pay the Access & Guarantee Fee this quarter.',
              style: QTheme.body,
            ),
          ),
          Text(_money(eoq.toDouble()), style: QTheme.h6),
        ],
      ),
    );
  }

  // ───────────────────────── Formatting ─────────────────────────

  static String _money(double v) => '\$${v.toStringAsFixed(2)}';
}
