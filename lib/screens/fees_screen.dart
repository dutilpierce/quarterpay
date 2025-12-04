import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/fee_simulator_panel.dart';
import '../state/quarter_state.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qs = QuarterState.instance;

    final double lineQtr = qs.lineQtr;
    final double creditUsedQtr = qs.creditUsedQtr;
    final double refundsSameQtr = qs.refundsSameQtr;

    final double usageRate = qs.usageRate; // 0.07
    final double floorRate  = qs.floorRate; // 0.02

    final double adjustedUsed = qs.adjustedUsed;
    final double feeUsage = qs.feeUsage;
    final double feeFloor = qs.feeFloor;
    final double eoqFee   = qs.eoqFee;
    final bool   usageWins = qs.usageWins;

    return QSurface(
      title: 'Quarterly Fees',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          children: [
            _SummaryBanner(
              lineQtr: lineQtr,
              creditUsedQtr: creditUsedQtr,
              refundsSameQtr: refundsSameQtr,
              usageRate: usageRate,
              floorRate: floorRate,
              feeUsage: feeUsage,
              feeFloor: feeFloor,
              eoqFee: eoqFee,
              usageWins: usageWins,
            ),

            const SizedBox(height: 16),

            _TwoUp(
              left: _ConceptCard(
                icon: Icons.percent,
                title: 'Usage Fee',
                headline: '7% of credit used',
                bullets: const [
                  'Applies to credit we covered for your bills this quarter.',
                  'Same-quarter refunds reduce the used amount.',
                  'Escrow/round-ups reduce usage by preventing credit draw.',
                ],
                accent: QPalette.primary,
              ),
              right: _ConceptCard(
                icon: Icons.verified_user_outlined,
                title: 'Access & Guarantee Fee',
                headline: '2% of your approved line',
                bullets: const [
                  'Covers on-call coverage & payment assurance.',
                  'Applies even if usage is \$0 (not interest).',
                  'Prorated when your line changes mid-quarter.',
                ],
                accent: Colors.orange,
              ),
            ),

            const SizedBox(height: 16),

            _ComparisonPanel(
              usage: feeUsage,
              floor: feeFloor,
              usageWins: usageWins,
            ),

            const SizedBox(height: 16),

            // Simulator stays — lets users play with scenarios
            const FeeSimulatorPanel(),

            const SizedBox(height: 16),

            const _ExamplesDeck(),

            const SizedBox(height: 12),
            _ComplianceNote(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Summary section
// ─────────────────────────────────────────────────────────────

class _SummaryBanner extends StatelessWidget {
  final double lineQtr;
  final double creditUsedQtr;
  final double refundsSameQtr;
  final double usageRate;
  final double floorRate;
  final double feeUsage;
  final double feeFloor;
  final double eoqFee;
  final bool usageWins;

  const _SummaryBanner({
    required this.lineQtr,
    required this.creditUsedQtr,
    required this.refundsSameQtr,
    required this.usageRate,
    required this.floorRate,
    required this.feeUsage,
    required this.feeFloor,
    required this.eoqFee,
    required this.usageWins,
  });

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your quarter so far', style: QTheme.h6),
          const SizedBox(height: 8),
          Text(
            'We charge the greater of the Usage Fee (${_pct(usageRate)}) or the '
            'Access & Payment Guarantee fee (${_pct(floorRate)}).',
            style: QTheme.body,
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _StatChip(
                icon: Icons.calendar_month,
                label: 'Approved line',
                value: _money(lineQtr),
                tint: QTheme.brandTint(context),
              ),
              _StatChip(
                icon: Icons.credit_card,
                label: 'Credit used (gross)',
                value: _money(creditUsedQtr),
                tint: QTheme.brandTint(context),
              ),
              _StatChip(
                icon: Icons.undo_rounded,
                label: 'Same-quarter refunds',
                value: '-${_money(refundsSameQtr)}',
                tint: QTheme.brandTint(context),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _FeeTile(
                label: 'Usage Fee (7%)',
                amount: feeUsage,
                color: QPalette.primary,
                isWinner: usageWins,
              ),
              _FeeTile(
                label: 'Access & Guarantee (2%)',
                amount: feeFloor,
                color: Colors.orange,
                isWinner: !usageWins,
              ),
            ],
          ),

          const SizedBox(height: 12),
          _ResultBanner(amount: eoqFee, usageWins: usageWins),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Concept cards (two-up)
// ─────────────────────────────────────────────────────────────

class _TwoUp extends StatelessWidget {
  final Widget left;
  final Widget right;
  const _TwoUp({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, cons) {
        final isWide = cons.maxWidth > 900;
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: left),
              const SizedBox(width: 16),
              Expanded(child: right),
            ],
          );
        }
        return Column(children: [left, const SizedBox(height: 16), right]);
      },
    );
  }
}

class _ConceptCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String headline;
  final List<String> bullets;
  final Color accent;

  const _ConceptCard({
    required this.icon,
    required this.title,
    required this.headline,
    required this.bullets,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              backgroundColor: accent.withOpacity(.12),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 10),
            Text(title, style: QTheme.h6),
          ]),
          const SizedBox(height: 8),
          Text(headline, style: QTheme.h4),
          const SizedBox(height: 8),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(child: Text(b, style: QTheme.body)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Visual comparison
// ─────────────────────────────────────────────────────────────

class _ComparisonPanel extends StatelessWidget {
  final double usage;
  final double floor;
  final bool usageWins;

  const _ComparisonPanel({
    required this.usage,
    required this.floor,
    required this.usageWins,
  });

  @override
  Widget build(BuildContext context) {
    final double maxFee = (usage > floor ? usage : floor).clamp(1, double.infinity);
    final double usagePct = (usage / maxFee).clamp(0, 1);
    final double floorPct = (floor / maxFee).clamp(0, 1);

    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.bar_chart_rounded, color: QPalette.primary),
            const SizedBox(width: 8),
            Text('Comparison', style: QTheme.h6),
          ]),
          const SizedBox(height: 12),
          _barRow(
            context: context,
            label: 'Usage Fee',
            amount: usage,
            fraction: usagePct,
            color: QPalette.primary,
            isWinner: usageWins,
          ),
          const SizedBox(height: 10),
          _barRow(
            context: context,
            label: 'Access & Guarantee',
            amount: floor,
            fraction: floorPct,
            color: Colors.orange,
            isWinner: !usageWins,
          ),
        ],
      ),
    );
  }

  Widget _barRow({
    required BuildContext context,
    required String label,
    required double amount,
    required double fraction,
    required Color color,
    required bool isWinner,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: Text(
              label,
              style: isWinner
                  ? QTheme.body.copyWith(fontWeight: FontWeight.w800)
                  : QTheme.body,
            ),
          ),
          Text(_money(amount), style: QTheme.body),
          const SizedBox(width: 6),
          if (isWinner) const Icon(Icons.arrow_upward, size: 16),
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
}

class _ResultBanner extends StatelessWidget {
  final double amount;
  final bool usageWins;
  const _ResultBanner({required this.amount, required this.usageWins});

  @override
  Widget build(BuildContext context) {
    final Color base = usageWins ? QPalette.primary : Colors.orange;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: base.withOpacity(.08),
        border: Border.all(color: base.withOpacity(.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            usageWins ? Icons.trending_up : Icons.verified_user_outlined,
            color: base,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              usageWins
                  ? 'You pay the Usage Fee this quarter.'
                  : 'You pay the Access & Guarantee Fee this quarter.',
              style: QTheme.body,
            ),
          ),
          Text(_money(amount), style: QTheme.h6),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Examples Deck
// ─────────────────────────────────────────────────────────────

class _ExamplesDeck extends StatelessWidget {
  const _ExamplesDeck();

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.menu_book_outlined, color: QPalette.primary),
            const SizedBox(width: 8),
            Text('Examples', style: QTheme.h6),
          ]),
          const SizedBox(height: 8),
          Text(
            'Illustrative scenarios using the greater-of rule (7% usage vs 2% access & guarantee).',
            style: QTheme.body,
          ),
          const SizedBox(height: 12),

          LayoutBuilder(
            builder: (c, cons) {
              final isWide = cons.maxWidth > 900;
              final cards = <Widget>[
                _ExampleCard(
                  title: 'Case 1 — No Credit Used',
                  lines: const [
                    'Line: \$1,200 • Used: \$0',
                    'Usage = \$0 | Floor = \$24',
                    'You pay \$24 (floor).',
                  ],
                  color: Colors.orange,
                ),
                _ExampleCard(
                  title: 'Case 2 — Light Usage',
                  lines: const [
                    'Line: \$1,200 • Used: \$300',
                    'Usage = \$21 | Floor = \$24',
                    'You pay \$24 (floor).',
                  ],
                  color: Colors.orange,
                ),
                _ExampleCard(
                  title: 'Case 3 — Moderate Usage',
                  lines: const [
                    'Line: \$1,200 • Used: \$800',
                    'Usage = \$56 | Floor = \$24',
                    'You pay \$56 (usage).',
                  ],
                  color: QPalette.primary,
                ),
                _ExampleCard(
                  title: 'Case 4 — Heavy Usage + Refunds',
                  lines: const [
                    'Used \$1,400 − \$200 same-quarter refund = \$1,200',
                    'Usage = \$84 | Floor = \$24',
                    'You pay \$84 (usage).',
                  ],
                  color: QPalette.primary,
                ),
                _ExampleCard(
                  title: 'Case 5 — Line Increased Mid-Quarter',
                  lines: const [
                    'Days 1–45: Line \$1,000 → 2% = \$20 → half = \$10',
                    'Days 46–90: Line \$2,000 → 2% = \$40 → half = \$20',
                    'Floor total = \$30 (compare usage to \$30).',
                  ],
                  color: Colors.orange,
                ),
              ];

              if (isWide) {
                return Column(
                  children: [
                    Row(children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 12),
                      Expanded(child: cards[1]),
                      const SizedBox(width: 12),
                      Expanded(child: cards[2]),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(child: cards[3]),
                      const SizedBox(width: 12),
                      Expanded(child: cards[4]),
                      const SizedBox(width: 12),
                      const Expanded(child: SizedBox.shrink()),
                    ]),
                  ],
                );
              }
              return Column(
                children: [
                  ...cards.expand((w) => [w, const SizedBox(height: 12)]).toList()..removeLast(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final List<String> lines;
  final Color color;

  const _ExampleCard({
    required this.title,
    required this.lines,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.78),
        borderRadius: BorderRadius.circular(14),
        boxShadow: QShadows.soft,
        border: Border.all(color: QPalette.cardFill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(backgroundColor: color.withOpacity(.12), child: Icon(Icons.bolt_outlined, color: color)),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: QTheme.body.copyWith(fontWeight: FontWeight.w800))),
          ]),
          const SizedBox(height: 8),
          ...lines.map((t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    Expanded(child: Text(t, style: QTheme.body)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Compliance Note
// ─────────────────────────────────────────────────────────────

class _ComplianceNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: QTheme.brandTint(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Quarterly Program Fee: You will be charged the greater of (1) 7% of the credit we covered for your bills '
        'this quarter, or (2) 2% of your approved Quarterly Coverage Limit. This fee supports payment assurance, '
        'underwriting, monitoring, and on-call coverage throughout the quarter.',
        style: QTheme.small,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Small shared UI atoms
// ─────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color tint;
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 220),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: QPalette.cardFill),
        boxShadow: QShadows.soft,
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: tint, child: Icon(icon, color: QPalette.primary)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: QTheme.small),
                const SizedBox(height: 2),
                Text(value, style: QTheme.body.copyWith(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeTile extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final bool isWinner;

  const _FeeTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.isWinner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 260),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.78),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: QPalette.cardFill),
        boxShadow: QShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(backgroundColor: color.withOpacity(.12), child: Icon(Icons.stacked_bar_chart, color: color)),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: QTheme.body)),
            if (isWinner)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Higher', style: QTheme.small),
              ),
          ]),
          const SizedBox(height: 8),
          Text(_money(amount), style: QTheme.h4),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Format helpers
// ─────────────────────────────────────────────────────────────

String _money(double v) => '\$${v.toStringAsFixed(2)}';
String _pct(double p) => '${(p * 100).toStringAsFixed(0)}%';
