import 'package:flutter/material.dart';
import '../theme.dart';

class DueDatesScreen extends StatefulWidget {
  const DueDatesScreen({super.key});

  @override
  State<DueDatesScreen> createState() => _DueDatesScreenState();
}

class _DueDatesScreenState extends State<DueDatesScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  // Example data: day -> list of bills due that day
  final Map<int, List<Map<String, dynamic>>> _bills = {
    5: [{'name': 'AT&T', 'amount': 85.0}],
    12: [{'name': 'Electric', 'amount': 146.0}],
    20: [{'name': 'Water', 'amount': 64.0}, {'name': 'Netflix', 'amount': 15.0}],
    28: [{'name': 'Insurance', 'amount': 120.0}],
  };

  @override
  Widget build(BuildContext context) {
    return QSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Due Dates', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
                icon: const Icon(Icons.chevron_left_rounded),
                label: const Text('Prev'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => setState(() => _month = DateTime(DateTime.now().year, DateTime.now().month)),
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text('${_month.year}-${_month.month.toString().padLeft(2,'0')}'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
                icon: const Icon(Icons.chevron_right_rounded),
                label: const Text('Next'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          QCard(
            padding: const EdgeInsets.all(12),
            child: _buildCalendar(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final firstDay = DateTime(_month.year, _month.month, 1);
    final firstWeekday = firstDay.weekday; // 1 (Mon) .. 7 (Sun)
    final daysInMonth = DateUtils.getDaysInMonth(_month.year, _month.month);

    final cells = <Widget>[];

    // Weekday header
    const headers = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    cells.addAll(headers.map((h) => Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(h, style: const TextStyle(fontWeight: FontWeight.w700, color: QPalette.slateMuted)),
      ),
    )));

    // Add blanks before the first day (convert Mon=1..Sun=7 to 0-indexed col)
    final blanks = (firstWeekday + 6) % 7;
    for (int i = 0; i < blanks; i++) {
      cells.add(const SizedBox());
    }

    // Days
    for (int d = 1; d <= daysInMonth; d++) {
      final dueList = _bills[d] ?? [];
      cells.add(_DayCell(
        day: d,
        bills: dueList,
        onTapBill: (bill) {
          Navigator.pushNamed(
            context,
            '/bills', // soft fallback; but we can route to detail:
          );
          // Or push to detail if you added /bill-detail route:
          // Navigator.pushNamed(context, '/bill-detail', arguments: bill);
        },
      ));
    }

    // Grid
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.25,
      children: cells,
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final List<Map<String, dynamic>> bills;
  final void Function(Map<String, dynamic> bill) onTapBill;

  const _DayCell({required this.day, required this.bills, required this.onTapBill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: QShadows.soft,
        border: Border.all(color: const Color(0xFFE9EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$day', style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          for (final bill in bills.take(3))
            InkWell(
              onTap: () => onTapBill(bill),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.receipt_long_rounded, size: 16, color: QPalette.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${bill['name']} • \$${(bill['amount'] as num).toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (bills.length > 3)
            const Text('+ more…', style: TextStyle(fontSize: 11, color: QPalette.slateMuted)),
        ],
      ),
    );
  }
}
