import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/plaid_service.dart';

class PaymentSetupScreen extends StatelessWidget {
  const PaymentSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Payment Setup',
      subtitle: 'ACH settlement typically takes 1–3 business days. We auto-pay eligible bills monthly.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: Column(
            children: [
              _Card(
                icon: Icons.link,
                title: 'Connect with Plaid',
                text:
                    'Securely connect your bank to discover recurring bills and enable round-ups.',
                buttonText: 'Connect Bank (Plaid)',
                onTap: () async => PlaidService.openLink(),
              ),
              _Card(
                icon: Icons.account_balance,
                title: 'Set up payments with Stripe',
                text:
                    'Use Stripe to manage quarterly payment method and autopay coverage.',
                buttonText: 'Open Stripe Setup',
                onTap: () {
                  // TODO: replace with your server-hosted onboarding url
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final String buttonText;
  final VoidCallback onTap;

  const _Card({
    required this.icon,
    required this.title,
    required this.text,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return QCard(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: QTheme.brandTint(context),
            child: Icon(icon, color: QPalette.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: QTheme.h6),
                const SizedBox(height: 6),
                Text(text, style: QTheme.bodyMuted),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: QButton.primary(label: buttonText, onPressed: onTap),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
