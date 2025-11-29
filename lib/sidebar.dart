import 'package:flutter/material.dart';
import 'theme.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;
  const AppSidebar({super.key, required this.selectedIndex, required this.onTap});

  static const _items = [
    ('Home', Icons.home_rounded),
    ('Signup', Icons.person_add_alt_1_rounded),
    ('Connect Bills', Icons.link_rounded),
    ('Payment Setup', Icons.credit_card_rounded),
    ('History', Icons.receipt_long_rounded),
    ('Progress', Icons.trending_up_rounded),
    ('Bills', Icons.receipt_rounded),
    ('Fees', Icons.pie_chart_rounded),
    ('Due Dates', Icons.event_rounded),
    ('Overview', Icons.dashboard_rounded),
    ('AI Helper', Icons.smart_toy_rounded),
    ('Escrow Boost', Icons.lock_rounded),
    ('FAQ', Icons.help_center_rounded),
    ('Privacy', Icons.privacy_tip_rounded),
    ('Terms', Icons.gavel_rounded),
    ('How It Works', Icons.auto_awesome_rounded),
    ('About', Icons.info_rounded),
    ('Contact', Icons.email_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white.withOpacity(.72);
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: bg,
        border: const Border(right: BorderSide(color: Color(0xFFE9EDF2))),
        boxShadow: QShadows.inset,
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Brand chip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [QPalette.mint, Colors.white],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8EF)),
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: QPalette.primary,
                      child: Icon(Icons.shield_moon_rounded, color: Colors.white, size: 18),
                    ),
                    SizedBox(width: 10),
                    Text('QuarterPay', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  final (label, icon) = _items[i];
                  final selected = i == selectedIndex;
                  return InkWell(
                    onTap: () => onTap(i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? QPalette.primary.withOpacity(.08) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(icon, color: selected ? QPalette.primary : QPalette.slateMuted),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              label,
                              style: TextStyle(
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                color: selected ? QPalette.primary : QPalette.slate,
                              ),
                            ),
                          ),
                          if (selected)
                            const Icon(Icons.chevron_right_rounded, color: QPalette.primary),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
