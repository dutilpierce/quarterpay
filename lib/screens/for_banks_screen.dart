import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/eoq_payment_card.dart'; // optional but harmless

class ForBanksScreen extends StatelessWidget {
  const ForBanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: "For Banks & Operations",
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroHeader(context),
            const SizedBox(height: 28),
            const SectionHeader("What QuarterPay Solves"),
            const SizedBox(height: 12),
            _painPointsGrid(),
            const SizedBox(height: 28),
            const SectionHeader("How the System Works"),
            const SizedBox(height: 12),
            _flowGraphic(context),
            const SizedBox(height: 28),
            const SectionHeader("Operational Advantages"),
            const SizedBox(height: 12),
            _advantagesList(),
            const SizedBox(height: 28),
            const SectionHeader("Why Banks Partner With Us"),
            const SizedBox(height: 12),
            _valueProps(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // HERO HEADER
  // -------------------------------------------------------------
  Widget _heroHeader(BuildContext context) {
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("A Smarter Way to Serve Underserved Borrowers",
              style: QTheme.h6),
          const SizedBox(height: 8),
          Text(
            "QuarterPay transforms recurring household bills into a single "
            "quarterly repayment—giving users stability while providing banks "
            "a safe, predictable, and fully transparent credit system.",
            style: QTheme.body,
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // PAIN POINTS GRID
  // -------------------------------------------------------------
  Widget _painPointsGrid() {
    final list = [
      _Info(
        icon: Icons.trending_down,
        title: "Delinquency Prevention",
        text:
            "QuarterPay makes monthly bill payments on behalf of users, sharply reducing late payments and overdraft-driven defaults.",
      ),
      _Info(
        icon: Icons.assured_workload_outlined,
        title: "Stable Repayment Cycles",
        text:
            "One quarterly repayment simplifies underwriting and creates predictable cash-flow expectations.",
      ),
      _Info(
        icon: Icons.analytics_outlined,
        title: "Granular Data",
        text:
            "Biller data, usage patterns, and monthly performance provide high-quality operational insight.",
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.25,
      children: list.map((i) => _InfoCard(info: i)).toList(),
    );
  }

  // -------------------------------------------------------------
  // FLOW GRAPHIC — VISUAL TIMELINE OF QUARTERPAY
  // -------------------------------------------------------------
  Widget _flowGraphic(BuildContext context) {
    final steps = [
      _Step(
        icon: Icons.link_rounded,
        title: "1. User connects bank + bills",
        text:
            "Plaid + biller connections allow monthly automation and underwriting.",
      ),
      _Step(
        icon: Icons.payments_rounded,
        title: "2. Bills paid monthly by QuarterPay",
        text:
            "We disburse funds on time, protecting credit and eliminating missed payments.",
      ),
      _Step(
        icon: Icons.savings_rounded,
        title: "3. Escrow & Round-ups (optional)",
        text:
            "Users save automatically to reduce their EOQ fee—improving repayment rates.",
      ),
      _Step(
        icon: Icons.event_available_rounded,
        title: "4. Quarterly repayment",
        text:
            "One predictable repayment to the bank + nominal fee. System resets for next quarter.",
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _FlowCard(step: steps[i]),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.arrow_downward,
                  color: QPalette.primary.withOpacity(.35)),
            ),
        ]
      ],
    );
  }

  // -------------------------------------------------------------
  // ADVANTAGES LIST
  // -------------------------------------------------------------
  Widget _advantagesList() {
    final items = [
      "Reduced delinquency and charge-off exposure",
      "Highly engaged user base with long-term retention",
      "Predictable quarterly repayment cycle",
      "High-quality underwriting signals via biller & usage data",
      "Escrow deposits increase repayment confidence",
      "Users improve financial stability—banks improve portfolio reliability",
    ];

    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(t, style: QTheme.body)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // -------------------------------------------------------------
  // WHY BANKS PARTNER WITH US
  // -------------------------------------------------------------
  Widget _valueProps() {
    final list = [
      _Info(
        icon: Icons.account_tree_rounded,
        title: "Scaling Built-In",
        text:
            "The model supports thousands of users with identical workflows—minimal operational lift.",
      ),
      _Info(
        icon: Icons.shield_outlined,
        title: "Risk-Optimized",
        text:
            "Monthly bill payments ensure essential responsibilities are handled on time.",
      ),
      _Info(
        icon: Icons.handshake_outlined,
        title: "Partnership-Ready",
        text:
            "All compliance, data sharing, communication, and reporting structures are turnkey.",
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.25,
      children: list.map((i) => _InfoCard(info: i)).toList(),
    );
  }
}

// ============================================================================
// SUPPORTING CLASSES
// ============================================================================

class _Info {
  final IconData icon;
  final String title;
  final String text;
  const _Info({required this.icon, required this.title, required this.text});
}

class _InfoCard extends StatelessWidget {
  final _Info info;
  const _InfoCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: QTheme.brandTint(context),
            child: Icon(info.icon, color: QPalette.primary),
          ),
          const SizedBox(height: 12),
          Text(info.title, style: QTheme.h6),
          const SizedBox(height: 6),
          Text(info.text, style: QTheme.bodyMuted),
        ],
      ),
    );
  }
}

class _Step {
  final IconData icon;
  final String title;
  final String text;
  const _Step({required this.icon, required this.title, required this.text});
}

class _FlowCard extends StatelessWidget {
  final _Step step;
  const _FlowCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return QCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: QTheme.brandTint(context),
            child: Icon(step.icon, color: QPalette.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: QTheme.h6),
                const SizedBox(height: 6),
                Text(step.text, style: QTheme.bodyMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
