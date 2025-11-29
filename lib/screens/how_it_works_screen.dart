import 'package:flutter/material.dart';
import '../theme.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Widget step(IconData icon, String text) => QCard(
      child: Row(children: [
        CircleAvatar(radius: 20, backgroundColor: QPalette.primary.withOpacity(.12), child: Icon(icon, color: QPalette.primary)),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600))),
        OutlinedButton(onPressed: (){}, child: const Text('Sample bill')),
      ]),
    );

    return ListView(
      children: [
        step(Icons.account_balance_wallet_outlined, 'Combine 3 months of bills → 1 quarterly payment.'),
        const SizedBox(height: 12),
        step(Icons.schedule, 'We pay bills monthly and on time to each biller.'),
        const SizedBox(height: 12),
        step(Icons.savings, 'Reduce fees with automated savings and boosts.'),
      ],
    );
  }
}
