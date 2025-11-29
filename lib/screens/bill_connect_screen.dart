import 'package:flutter/material.dart';
import '../services/plaid_service.dart';

class BillConnectScreen extends StatelessWidget {
  const BillConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Connect your bills (Plaid)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('We use Plaid to securely discover recurring bills and transactions.'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            // TODO: fetch link_token from your backend
            const placeholderLinkToken = 'LINK_TOKEN_FROM_BACKEND';
            await PlaidService.openLink(
              linkToken: placeholderLinkToken,
              onSuccess: (publicToken) {
                // send to backend, exchange for access token
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plaid linked!')));
                Navigator.pushNamed(context, '/payment-setup');
              },
            );
          },
          child: const Text('Connect with Plaid'),
        )
      ],
    );
  }
}
