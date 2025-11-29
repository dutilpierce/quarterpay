import 'package:flutter/material.dart';
import '../theme.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Sep 30, 2025', 3741.00, 'Paid'),
      ('Jun 30, 2025', 3728.00, 'Paid'),
    ];

    return QSurface(
      child: QCard(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Status')),
          ],
          rows: [
            for (final it in items)
              DataRow(
                cells: [
                  DataCell(Text(it.$1), onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Viewing ${it.$1}')));
                  }),
                  DataCell(Text('\$${it.$2.toStringAsFixed(2)}')),
                  DataCell(Text(it.$3)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
