import 'package:flutter/material.dart';
import '../theme.dart';
import '../Content/escrow_content.dart';

class ForBanksScreen extends StatelessWidget {
  const ForBanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'For Banks & Ops',
      subtitle: 'Escrow-first collections + dynamic fee floor, with clear ledgers, events, and admin guardrails.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Operating Model'),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: EscrowContent.opsOverview.map((m) =>
              SizedBox(
                width: 360,
                child: QCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m['title']!, style: QTheme.h6),
                      const SizedBox(height: 6),
                      Text(m['text']!, style: QTheme.body),
                    ],
                  ),
                ),
              )
            ).toList(),
          ),

          const SizedBox(height: 24),
          const SectionHeader('Data Model & Ledgers'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Core Ledgers', style: QTheme.h6),
                const SizedBox(height: 6),
                ...EscrowContent.ledgers.map((l) => _bullet(l)),
                const SizedBox(height: 16),
                Text('Events & Jobs (examples)', style: QTheme.h6),
                const SizedBox(height: 6),
                _bullet('CRON: reserve_upcoming_bills (re-run on deposit)'),
                _bullet('CRON: compute_quarter_fees'),
                _bullet('API: POST /escrow/deposit (rewards on deposit)'),
                _bullet('API: POST /escrow/apply-to-eoq (feature-flagged)'),
                _bullet('API: GET /quarter/summary (secured/credit/fee preview)'),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const SectionHeader('Admin Controls'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: EscrowContent.adminFlags.map((f) => _bullet(f)).toList(),
            ),
          ),

          const SizedBox(height: 24),
          const SectionHeader('Edge Cases'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: EscrowContent.edgeCases.map((e) => _bullet(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, size: 8, color: QPalette.slateMuted),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: QTheme.body)),
      ],
    ),
  );
}
