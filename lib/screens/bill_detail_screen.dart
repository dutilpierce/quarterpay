import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/ai_chat_widget.dart';

class BillDetailScreen extends StatelessWidget {
  final String name;
  final double amount;
  final int dueDay;

  const BillDetailScreen({
    super.key,
    required this.name,
    required this.amount,
    required this.dueDay,
  });

  @override
  Widget build(BuildContext context) {
    return QSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bill Details', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          QCard(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: QPalette.primary,
                  child: Icon(Icons.receipt_long_rounded, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text('Due on the $dueDay', style: const TextStyle(color: QPalette.slateMuted)),
                  ]),
                ),
                Text('\$${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('AI analysis & savings suggestions', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 420,
            child: QCard(
              child: const AIChatWidget(
                initialMessages: [
                  {
                    'role': 'system',
                    'content': 'You are QuarterPay AI. Analyze the bill, find fees, and suggest savings with a confident, friendly tone.'
                  }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
