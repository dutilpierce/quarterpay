import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/eoq_payment_card.dart';
import '../state/quarter_state.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qs = QuarterState.instance;

    return QSurface(
      title: 'Overview',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          children: [
            // EOQ summary (kept — top 3 tiles removed per your request)
            EoqPaymentCard(
              totalScheduled: qs.lineQtr,
              creditUsed: qs.creditUsedQtr,
              basePct: qs.usageRate,
              floorPct: qs.floorRate,
              rewardsApplied: 0, // if you later pass escrow-to-fee, subtract here
              note: 'We split your quarterly payment into monthly biller disbursements. '
                    'At quarter end, your fee is the higher of ${_pct(qs.usageRate)} usage '
                    'or ${_pct(qs.floorRate)} access & guarantee.',
            ),

            const SizedBox(height: 16),

            // How this works (unchanged text block)
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How this works', style: QTheme.h6),
                  const SizedBox(height: 8),
                  Text(
                    'You make one payment per quarter. QuarterPay disburses to your billers monthly '
                    'from your approved line. Funding escrow and round-ups reduce credit usage and can '
                    'lower the usage fee exposure. A minimum ${_pct(qs.floorRate)} access & guarantee fee applies.',
                    style: QTheme.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _pct(double p) => '${(p * 100).toStringAsFixed(0)}%';
}
