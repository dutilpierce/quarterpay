import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('QuarterPay', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('One quarterly payment. Three months of breathing room.',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          Wrap(spacing: 16, runSpacing: 16, children: const [
            _MetricCard(title: 'Average Monthly Bills', value: '\$1,247'),
            _MetricCard(title: 'Quarterly Total', value: '\$3,741'),
            _MetricCard(title: 'Base Fee (flat)', value: '7% (~\$444/quarter)'),
          ]),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Two ways to reduce/eliminate fee:', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('1. Escrow Boost (Round-Ups) → Lock \$114 in 90 days = 33% complete → fee drops to 4%'),
                Text('   → Lock \$342+ → fee drops to 0%'),
                SizedBox(height: 8),
                Text('2. Instant Boost → Deposit buffer upfront → 0% fee instantly'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Get Started'),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/escrow'),
              child: const Text('See Escrow Boost →'),
            )
          ])
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title; final String value;
  const _MetricCard({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
