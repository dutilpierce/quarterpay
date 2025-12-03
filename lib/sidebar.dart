import 'package:flutter/material.dart';
import 'theme.dart';

/// Sidebar menu that maps each visible row to its original route index.
/// We intentionally OMIT the Escrow item (index 11) from the UI to "remove the button"
/// without changing any indices or routes in the rest of the app.
/// When a user taps, we pass the ORIGINAL route index back to [onTap].
class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define visible menu items. Each tuple = (icon, label, originalRouteIndex)
    // Original route indices (from your MaterialApp routes):
    // 0: '/', 1: '/signup', 2: '/connect-bills', 3: '/payment-setup',
    // 4: '/history', 5: '/progress', 6: '/bills', 7: '/fees',
    // 8: '/due-dates', 9: '/overview', 10: '/ai-helper',
    // 11: '/escrow' (INTENTIONALLY HIDDEN), 12: '/faq', 13: '/privacy',
    // 14: '/terms', 15: '/how-it-works', 16: '/about', 17: '/contact'
    final itemsPrimary = <_Entry>[
      _Entry(Icons.home_outlined,            'Home',              0),
      _Entry(Icons.person_add_alt_1_outlined,'Sign Up',           1),
      _Entry(Icons.link_outlined,            'Connect Bills',     2),
      _Entry(Icons.account_balance_outlined, 'Payment Setup',     3),
      _Entry(Icons.history_outlined,         'History',           4),
      _Entry(Icons.timeline_outlined,        'Progress',          5),
      _Entry(Icons.receipt_long_outlined,    'Bills',             6),
      _Entry(Icons.percent_outlined,         'Fees',              7),
      _Entry(Icons.calendar_month_outlined,  'Due Dates',         8),
      _Entry(Icons.dashboard_customize_outlined,'Overview',       9),
      _Entry(Icons.smart_toy_outlined,       'AI Helper',         10),
      // (Escrow index 11 is intentionally not listed)
    ];

    final itemsSecondary = <_Entry>[
      _Entry(Icons.live_help_outlined,       'FAQ',               12),
      _Entry(Icons.privacy_tip_outlined,     'Privacy',           13),
      _Entry(Icons.gavel_outlined,           'Terms',             14),
      _Entry(Icons.route_outlined,           'How It Works',      15),
      _Entry(Icons.info_outline,             'About',             16),
      _Entry(Icons.mail_outline,             'Contact',           17),
    ];

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        border: Border(
          right: BorderSide(color: QPalette.border, width: 1),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Brand header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: QTheme.brandTint(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.schedule_outlined, color: QPalette.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('QuarterPay',
                          style: QTheme.body.copyWith(fontWeight: FontWeight.w700)),
                        Text('One quarterly payment.',
                          style: QTheme.caption, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Primary list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                children: [
                  ...itemsPrimary.map((e) => _MenuTile(
                        entry: e,
                        selected: selectedIndex == e.routeIndex,
                        onTap: () => onTap(e.routeIndex),
                      )),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                    child: Text('Info', style: QTheme.caption),
                  ),
                  ...itemsSecondary.map((e) => _MenuTile(
                        entry: e,
                        selected: selectedIndex == e.routeIndex,
                        onTap: () => onTap(e.routeIndex),
                      )),
                ],
              ),
            ),

            // Footer
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('© ${DateTime.now().year} QuarterPay', style: QTheme.caption),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Entry {
  final IconData icon;
  final String label;
  final int routeIndex; // ORIGINAL route index used by ScreenShell._go
  const _Entry(this.icon, this.label, this.routeIndex);
}

class _MenuTile extends StatelessWidget {
  final _Entry entry;
  final bool selected;
  final VoidCallback onTap;

  const _MenuTile({
    super.key,
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? QTheme.brandTint(context) : Colors.transparent;
    final fg = selected ? QPalette.primary : QPalette.slate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(entry.icon, color: fg),
              const SizedBox(width: 10),
              Expanded(child: Text(entry.label, style: QTheme.body.copyWith(color: fg))),
              if (selected)
                const Icon(Icons.arrow_right, color: QPalette.primary),
            ],
          ),
        ),
      ),
    );
  }
}
