import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/plaid_service.dart';

class PaymentSetupScreen extends StatelessWidget {
  const PaymentSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Setup', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Connect your bank for Round-Ups & bill pay'),
                const SizedBox(height: 10),
                Row(children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      const linkToken = 'LINK_TOKEN_FROM_BACKEND';
                      await PlaidService.openLink(
                        linkToken: linkToken,
                        onSuccess: (_) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Plaid linked!')),
                        ),
                      );
                    },
                    icon: const Icon(Icons.link_rounded),
                    label: const Text('Connect with Plaid'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // redirect to your Stripe Setup Intent / Billing portal page
                      // e.g., launchUrl(Uri.parse('https://your-backend/setup-intent'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Stripe setup flow (placeholder)')),
                      );
                    },
                    icon: const Icon(Icons.credit_card_rounded),
                    label: const Text('Enable Payments (Stripe)'),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
