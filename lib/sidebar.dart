import 'package:flutter/material.dart';
import 'theme.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onTap;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<_NavItem> items = [
      _NavItem(icon: Icons.home_outlined,        label: 'Home',          index: 0),
      _NavItem(icon: Icons.person_add_outlined,  label: 'Signup',        index: 1),
      _NavItem(icon: Icons.link_outlined,        label: 'Connect Bills', index: 2),
      _NavItem(icon: Icons.account_balance_outlined, label: 'Payment Setup', index: 3),
      _NavItem(icon: Icons.receipt_long_outlined,label: 'History',       index: 4),
      _NavItem(icon: Icons.trending_up_outlined, label: 'Progress',      index: 5),
      _NavItem(icon: Icons.view_list_outlined,   label: 'Bills',         index: 6),
      _NavItem(icon: Icons.percent_outlined,     label: 'Fees',          index: 7),
      _NavItem(icon: Icons.event_note_outlined,  label: 'Due Dates',     index: 8),
      _NavItem(icon: Icons.dashboard_customize_outlined, label: 'Overview', index: 9),
      _NavItem(icon: Icons.smart_toy_outlined,   label: 'AI Helper',     index: 10),
      _NavItem(icon: Icons.savings_outlined,     label: 'Escrow Boost',  index: 11),
      _NavItem(icon: Icons.help_outline,         label: 'FAQ',           index: 12),
      _NavItem(icon: Icons.privacy_tip_outlined, label: 'Privacy',       index: 13),
      _NavItem(icon: Icons.gavel_outlined,       label: 'Terms',         index: 14),
      _NavItem(icon: Icons.map_outlined,         label: 'How It Works',  index: 15),
      _NavItem(icon: Icons.info_outline,         label: 'About',         index: 16),
      _NavItem(icon: Icons.contact_support_outlined, label: 'Contact',   index: 17),
    ];

    final List<_Extra> extra = [
      _Extra(icon: Icons.apartment_outlined, label: 'For Banks & Ops', routeName: '/for-banks'),
    ];

    return Container(
      width: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.white.withOpacity(.72), Colors.white.withOpacity(.58)],
        ),
        border: const Border(right: BorderSide(color: QPalette.border)),
        boxShadow: const [
          BoxShadow(blurRadius: 24, spreadRadius: -8, offset: Offset(0, 10), color: Color(0x1A000000)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const _Brand(),
            const SizedBox(height: 8),
            const Divider(height: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  ...items.map((it) => _NavTile(
                        icon: it.icon,
                        label: it.label,
                        active: it.index == selectedIndex,
                        onTap: () => onTap(it.index!),
                      )),
                  const SizedBox(height: 6),
                  const Divider(height: 1),
                  const SizedBox(height: 6),
                  ...extra.map((e) => _NavTile(
                        icon: e.icon,
                        label: e.label,
                        active: false,
                        onTap: () => Navigator.of(context).pushNamed(e.routeName),
                      )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
              child: Opacity(
                opacity: .7,
                child: Text('© ${DateTime.now().year} QuarterPay', style: QTheme.caption),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            height: 42, width: 42,
            decoration: BoxDecoration(
              color: Colors.white, shape: BoxShape.circle,
              border: Border.all(color: QPalette.border),
              boxShadow: const [
                BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 8)),
                BoxShadow(color: Color(0x0F000000), blurRadius: 4, offset: Offset(0, 1)),
              ],
            ),
            child: const Center(child: Icon(Icons.spa_outlined, color: QPalette.primary, size: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('QuarterPay', style: QTheme.body.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('One quarterly payment.', style: QTheme.caption, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = active ? QPalette.primary.withOpacity(.12) : Colors.transparent;
    final fg = active ? QPalette.primary : QPalette.slate;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: QTheme.small.copyWith(
                      color: fg, fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (active)
                  Container(
                    height: 8, width: 8,
                    decoration: const BoxDecoration(color: QPalette.primary, shape: BoxShape.circle),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final int? index;
  _NavItem({required this.icon, required this.label, this.index});
}

class _Extra {
  final IconData icon;
  final String label;
  final String routeName;
  _Extra({required this.icon, required this.label, required this.routeName});
}
