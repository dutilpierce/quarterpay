import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/plaid_service.dart';

class BillConnectScreen extends StatelessWidget {
  const BillConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // no big page title (per your request) → pass empty string
    return QSurface(
      title: '',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main CTA card
              QCard(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Connect your bills', style: QTheme.h4),
                    const SizedBox(height: 6),
                    Text(
                      'Securely link your bank via Plaid to detect recurring bills and enable round-ups.',
                      style: QTheme.bodyMuted,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: QButton.primary(
                        label: 'Connect with Plaid',
                        onPressed: () async {
                          await PlaidService.openLink();
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('We never store your credentials.', style: QTheme.small),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Why connect? — compact, centered, auto-sizing info cards
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _WhyCard(
                    icon: Icons.receipt_long,
                    title: 'Discover Bills',
                    text: 'We auto-detect recurring payments so nothing gets missed.',
                  ),
                  _WhyCard(
                    icon: Icons.change_circle_outlined,
                    title: 'Round-Ups Ready',
                    text: 'Spare change flows to your escrow buffer automatically.',
                  ),
                  _WhyCard(
                    icon: Icons.flash_on_outlined,
                    title: 'Faster Setup',
                    text: 'Skip manual entry—most bills are recognized in seconds.',
                  ),
                  _WhyCard(
                    icon: Icons.lock_outline,
                    title: 'Bank-Grade Security',
                    text: 'Powered by Plaid. You control and can revoke access anytime.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _WhyCard({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final tint = QTheme.brandTint(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 300),
      child: QCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: tint,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, size: 20, color: QPalette.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: QTheme.h6),
                  const SizedBox(height: 4),
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
