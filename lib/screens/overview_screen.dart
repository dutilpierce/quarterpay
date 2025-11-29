import 'package:flutter/material.dart';
import '../theme.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Widget tile(IconData icon, String title, String value) => QCard(
      child: Row(children: [
        CircleAvatar(radius: 22, backgroundColor: QPalette.primary.withOpacity(.12), child: Icon(icon, color: QPalette.primary)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: QPalette.slate)),
        ]),
      ]),
    );

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: MediaQuery.sizeOf(context).width > 1100 ? 3 : 1,
      crossAxisSpacing: 16, mainAxisSpacing: 16,
      children: [
        tile(Icons.calendar_month, 'Quarterly Payment', '\$3,741 due Dec 31'),
        tile(Icons.receipt_long, 'Fee', '7% → aim for 0%'),
        tile(Icons.lock, 'Escrow Locked', '\$114 of \$342 (33%)'),
      ],
    );
  }
}
