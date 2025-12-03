import 'package:flutter/material.dart';
import '../theme.dart';

class DueDatesScreen extends StatefulWidget {
  const DueDatesScreen({super.key});
  @override
  State<DueDatesScreen> createState() => _DueDatesScreenState();
}

class _DueDatesScreenState extends State<DueDatesScreen> {
  DateTime _cursor = DateTime(DateTime.now().year, DateTime.now().month);

  final Map<int, List<Map<String, dynamic>>> _bills = {
    5: [
      {'name': 'AT&T', 'amount': 89.0},
    ],
    12: [
      {'name': 'Water', 'amount': 44.0},
      {'name': 'Netflix', 'amount': 16.0},
    ],
    21: [
      {'name': 'Car Ins.', 'amount': 129.0},
    ],
  };

  void _prev() => setState(() => _cursor = DateTime(_cursor.year, _cursor.month - 1));
  void _next() => setState(() => _cursor = DateTime(_cursor.year, _cursor.month + 1));

  String _monthLabel(DateTime dt) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return '${months[dt.month - 1]} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final first = DateTime(_cursor.year, _cursor.month, 1);
    final firstWeekday = first.weekday % 7;
    final daysInMonth = DateTime(_cursor.year, _cursor.month + 1, 0).day;
    final totalCells = ((firstWeekday + daysInMonth) / 7).ceil() * 7;

    return QSurface(
      title: 'Due Dates',
      subtitle: 'Click any bill pill to open its details.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1060),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      QButton.icon(icon: Icons.chevron_left, label: 'Prev', onPressed: _prev),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Center(child: Text(_monthLabel(_cursor), style: QTheme.h6)),
                      ),
                      const SizedBox(width: 12),
                      QButton.icon(icon: Icons.chevron_right, label: 'Next', onPressed: _next),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: totalCells,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.08, // slightly taller cells to avoid overflow
                  ),
                  itemBuilder: (context, i) {
                    final dayNumber = i - firstWeekday + 1;
                    final inMonth = dayNumber >= 1 && dayNumber <= daysInMonth;
                    final List<Map<String, dynamic>> bills = inMonth
                        ? List<Map<String, dynamic>>.from(_bills[dayNumber] ?? const <Map<String, dynamic>>[])
                        : const <Map<String, dynamic>>[];
                    return _DayCell(day: inMonth ? dayNumber : null, bills: bills);
                  },
                ),
                const SizedBox(height: 24), // bottom spacer for safety
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int? day;
  final List<Map<String, dynamic>> bills;
  const _DayCell({required this.day, required this.bills});

  @override
  Widget build(BuildContext context) {
    return QCard(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (day != null) Text('$day', style: QTheme.bodyMuted),
          const SizedBox(height: 8),
          ...bills.map((b) {
            final label = '${b['name']} • \$${(b['amount'] as num).toStringAsFixed(0)}';
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).pushNamed('/bills', arguments: b),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: QTheme.brandTint(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(label, style: QTheme.small),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
