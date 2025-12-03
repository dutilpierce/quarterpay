import 'package:flutter/material.dart';

/// Shared bullets, labels, and copy that reflect the Escrow-First + Dynamic Fee model.
/// Based on the QuarterPay pilot spec (escrow-first, 5% floor, tiered rewards, events, ledgers, admin flags).

class EscrowContent {
  // Headline explainer (user-facing)
  static const String hero = 'We secure your bills with escrow first. Credit steps in only when needed.';

  // Short pillars for “What QuarterPay does for you”
  static const List<Map<String, String>> whatWeDo = [
    {
      'title': 'Escrow-First Coverage',
      'text': 'Your deposits pre-secure upcoming bills. At due date, escrow pays first; credit covers the rest.'
    },
    {
      'title': 'Dynamic Fees with a Floor',
      'text': 'You only pay the base fee on credit-funded amounts—never below the 5% floor on your quarter total.'
    },
    {
      'title': 'Round-Ups & Boost Rewards',
      'text': 'Deposits can earn tiered rewards (1–3%, up to a quarterly cap) that help with bills or EOQ payment.'
    },
    {
      'title': 'Clear Previews & Alerts',
      'text': 'See secured bills, projected credit use, and fee preview. Get D-10/D-5/D-1 EOQ summaries automatically.'
    },
  ];

  // How it Works – steps (user-facing)
  static const List<Map<String, String>> flow = [
    {
      'title': '1) Add funds to Escrow',
      'text': 'Deposit anytime or turn on round-ups. As you deposit, we reserve upcoming bills against your escrow balance.'
    },
    {
      'title': '2) Bills get “Secured”',
      'text': 'When a bill is fully covered by escrow, its status turns Secured. Partial coverage reduces credit usage later.'
    },
    {
      'title': '3) Due Date Execution',
      'text': 'On the due date, escrow pays the reserved portion. Only the uncovered remainder uses your quarterly credit line.'
    },
    {
      'title': '4) EOQ Settlement',
      'text': 'At quarter end, you repay the credit used + fee. Fee = max(Base% × CreditUsed, 5% Floor × TotalScheduled).'
    },
  ];

  // Rewards tiers (user-facing)
  static const List<Map<String, String>> rewardsTiers = [
    {'title': 'Tier 1', 'text': '< \$100 deposited → 1% reward'},
    {'title': 'Tier 2', 'text': '\$100–\$499 → 2% reward'},
    {'title': 'Tier 3', 'text': '≥ \$500 → 3% reward'},
    {'title': 'Cap',   'text': 'Rewards capped at \$50 per quarter'},
  ];

  // Notifications (user-facing)
  static const List<String> notifications = [
    'Deposit success + reward earned (if eligible)',
    'Bill fully secured (escrow covers 100%)',
    'Bill partially secured (credit will cover remainder)',
    'Credit fallback (ACH revoked or escrow unavailable)',
    'EOQ previews at D-10, D-5, D-1 with fee breakdown',
  ];

  // Bank/Ops – data/ops overview (partner-facing)
  static const List<Map<String, String>> opsOverview = [
    {'title': 'Escrow-First Engine', 'text': 'Reserve upcoming bills as escrow arrives. Re-reserve on every deposit.'},
    {'title': 'Dynamic Fee with Floor', 'text': 'Final fee is the greater of usage fee vs 5% floor on scheduled total.'},
    {'title': 'Tiered Rewards', 'text': '1–3% rewards on deposits (cooldowns; no internal transfer gaming). Applied to next bills or EOQ.'},
    {'title': 'EOQ Controls', 'text': 'Toggle “apply escrow to EOQ” in settings. Clear fee breakdown and audit log.'},
  ];

  // Ledgers / model (partner-facing)
  static const List<String> ledgers = [
    'escrow_ledger',
    'bill_reservations',
    'credit_usage_ledger',
    'rewards_ledger',
    'quarter_rollup',
  ];

  // Admin flags (partner-facing)
  static const List<String> adminFlags = [
    'FEE_BASE_PCT (e.g., 7%)',
    'FEE_FLOOR_PCT (5% minimum effective)',
    'Escrow reward tiers + caps',
    'Reservation window (days lookahead)',
    'Cooldown periods',
    'Feature flags: rewards, floor, apply-escrow-to-EOQ',
  ];

  // Edge cases (partner-facing)
  static const List<String> edgeCases = [
    'Credit limit exhausted → escrow-only mode',
    'Refunds → escrow',
    'ACH revoked → freeze credit usage',
    'Reward cooldown enforcement',
  ];
}
