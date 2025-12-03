import 'package:flutter/material.dart';

class QPHowItWorksStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> bullets;
  QPHowItWorksStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.bullets = const [],
  });
}

class QPInfoCard {
  final String title;
  final List<String> bullets;
  final IconData icon;
  QPInfoCard({required this.title, required this.bullets, required this.icon});
}

/// USER-FACING FLOW (edit text freely)
final List<QPHowItWorksStep> howItWorksSteps = [
  QPHowItWorksStep(
    title: 'Connect Your Bank (Plaid)',
    subtitle: 'Secure link. We analyze cash flow, not FICO.',
    icon: Icons.link_rounded,
    bullets: [
      'OAuth where available • no hard credit pull',
      'Read balances/transactions/identity for cash-flow view',
    ],
  ),
  QPHowItWorksStep(
    title: 'Add Your Bills',
    subtitle: 'Upload PDF/photo, forward email, or enter manually.',
    icon: Icons.receipt_long_rounded,
    bullets: [
      'AI extracts amount, cadence, due date, biller',
      'Detect recurring bills and predict changes',
    ],
  ),
  QPHowItWorksStep(
    title: 'We Build Your Quarterly Plan',
    subtitle: 'See monthly vs quarterly cost and repayment date.',
    icon: Icons.calendar_month_rounded,
    bullets: [
      'Totals with clear monthly vs quarterly comparison',
      'Recommended plan + risk signals and due dates',
    ],
  ),
  QPHowItWorksStep(
    title: 'Bank Underwriting',
    subtitle: 'Coverage limit based on cash-flow stability.',
    icon: Icons.verified_user_rounded,
    bullets: [
      'Average balance, overdraft/NSF, inflow/outflow trends',
      'Bill-to-income ratio → proposed limit',
    ],
  ),
  QPHowItWorksStep(
    title: 'We Pay Monthly Bills',
    subtitle: 'You see every payment and receipt.',
    icon: Icons.payments_rounded,
    bullets: [
      'Disbursements from approved limit to billers monthly',
      'Full visibility in your dashboard',
    ],
  ),
  QPHowItWorksStep(
    title: 'You Repay Once Per Quarter',
    subtitle: 'Single ACH debit. Flat fee. No interest.',
    icon: Icons.schedule_rounded,
    bullets: [
      'Clear amount and date • early payoff optional',
    ],
  ),
  QPHowItWorksStep(
    title: 'Budgeting & Alerts',
    subtitle: 'Stay ahead with proactive signals.',
    icon: Icons.insights_rounded,
    bullets: [
      'Safe-to-spend, projections, upcoming-bill reminders',
      'Low-balance alerts, deltas, increases',
    ],
  ),
  QPHowItWorksStep(
    title: 'If You’re Short, We Help',
    subtitle: 'Protects users and the bank.',
    icon: Icons.volunteer_activism_rounded,
    bullets: [
      'Partial-pay, reschedule, brief extensions, hardship flow',
      'Fast re-link if account changes',
    ],
  ),
  QPHowItWorksStep(
    title: 'Security & Transparency',
    subtitle: 'Bank-level security. Clear numbers.',
    icon: Icons.lock_rounded,
    bullets: [
      'FDIC-insured bank, Plaid-secured, 2FA, audit logs',
    ],
  ),
];

/// BANK/OPS RESPONSIBILITIES SUMMARY
final List<QPInfoCard> servicingSpec = [
  QPInfoCard(
    title: 'Onboarding & Identity',
    icon: Icons.badge_rounded,
    bullets: [
      'PII/KYC (bank or vendor), Plaid link, phone/email verification',
    ],
  ),
  QPInfoCard(
    title: 'Plaid Data & Risk',
    icon: Icons.analytics_rounded,
    bullets: [
      'Balances, transactions, identity (+ income if available)',
      'Recurring analysis, overdraft/NSF, bill-to-income, risk score',
    ],
  ),
  QPInfoCard(
    title: 'Bill Management',
    icon: Icons.description_rounded,
    bullets: [
      'OCR/AI on uploads, store biller/amount/due date',
      'Increase detection, exceptions, summary UI',
    ],
  ),
  QPInfoCard(
    title: 'Repayment Servicing',
    icon: Icons.account_balance_rounded,
    bullets: [
      'Quarterly ACH, retries, waterfall, payoff quotes',
    ],
  ),
  QPInfoCard(
    title: 'Notifications & Reminders',
    icon: Icons.notifications_active_rounded,
    bullets: [
      '10/5/1-day reminders, processed/failed/retry, low-balance alerts',
      'Push • SMS • Email',
    ],
  ),
  QPInfoCard(
    title: 'Budgeting & AI',
    icon: Icons.smart_toy_rounded,
    bullets: [
      'Projections, shortfall warnings, early-repay suggestions',
    ],
  ),
  QPInfoCard(
    title: 'Fraud & Security',
    icon: Icons.security_rounded,
    bullets: [
      'Device fingerprint, MFA, IP reputation, manipulation detection',
    ],
  ),
  QPInfoCard(
    title: 'Compliance & Reporting',
    icon: Icons.rule_folder_rounded,
    bullets: [
      'Accurate marketing language, audit logs, portfolio KPIs',
    ],
  ),
];
