import 'package:flutter/material.dart';
import '../theme.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = [
      ('AT&T', 85.0, 'Utilities', Icons.network_cell_rounded, const Color(0xFFE7F7FF)),
      ('Electric', 146.0, 'Utilities', Icons.bolt_rounded, const Color(0xFFEFFFF2)),
      ('Water', 64.0, 'Utilities', Icons.water_drop_rounded, const Color(0xFFEFF6FF)),
      ('Netflix', 15.0, 'Subscription', Icons.tv_rounded, const Color(0xFFFFF1F2)),
      ('Insurance', 120.0, 'Insurance', Icons.shield_rounded, const Color(0xFFFEF9C3)),
    ];

    return QSurface(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: bills.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.sizeOf(context).width > 1100 ? 3 : 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.9,
        ),
        itemBuilder: (_, i) {
          final (name, amount, category, icon, bg) = bills[i];
          return QCard(
            color: (bg as Color),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(icon as IconData, color: QPalette.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name as String, style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(category as String, style: const TextStyle(color: QPalette.slateMuted)),
                  ]),
                ),
                Text('\$${(amount as num).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
