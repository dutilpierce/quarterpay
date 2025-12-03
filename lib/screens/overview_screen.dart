import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/eoq_payment_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Overview',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // End-of-Quarter summary (values are placeholders you can later bind to real state)
            const EoqPaymentCard(
              totalScheduled: 3600,   // total quarter spend scheduled
              creditUsed: 1200,       // used so far this quarter
              basePct: 0.07,          // 7% base fee
              floorPct: 0.06,         // 6% minimum floor after rewards
              rewardsApplied: 114,    // escrow/round-ups applied toward fee
              note:
                  'Round-ups and early escrow deposits reduce your fee (up to 1% off the base). '
                  'We disburse to billers monthly; you make one payment at quarter end.',
            ),

            const SizedBox(height: 16),

            // How this works (kept exactly like before)
            QCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How this works', style: QTheme.h6),
                  const SizedBox(height: 8),
                  Text(
                    'You make one payment per quarter. QuarterPay splits and disburses '
                    'to your billers monthly. If you enable round-ups/escrow, your fee can '
                    'be offset by automated savings (down to a minimum floor).',
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
}
