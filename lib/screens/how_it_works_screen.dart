import 'package:flutter/material.dart';
import '../theme.dart';
import '../Content/escrow_content.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'How QuarterPay Works',
      subtitle: EscrowContent.hero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('What QuarterPay does for you'),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: EscrowContent.whatWeDo.map((m) =>
              SizedBox(
                width: 360,
                child: QCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m['title']!, style: QTheme.h6),
                      const SizedBox(height: 6),
                      Text(m['text']!, style: QTheme.body),
                    ],
                  ),
                ),
              )
            ).toList(),
          ),

          const SizedBox(height: 24),
          const SectionHeader('The Flow'),

          // Step cards with subtle arrows
          for (int i = 0; i < EscrowContent.flow.length; i++) ...[
            QCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: QTheme.brandTint(context),
                    child: Text('${i+1}', style: QTheme.h6),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(EscrowContent.flow[i]['title']!, style: QTheme.h6),
                        const SizedBox(height: 6),
                        Text(EscrowContent.flow[i]['text']!, style: QTheme.body),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i < EscrowContent.flow.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Icon(Icons.arrow_downward, color: QPalette.slateMuted),
              ),
          ],

          const SizedBox(height: 24),
          const SectionHeader('Escrow Boost Rewards (Tiers)'),
          Wrap(
            spacing: 16, runSpacing: 16,
            children: EscrowContent.rewardsTiers.map((t) =>
              SizedBox(
                width: 280,
                child: QCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['title']!, style: QTheme.h6),
                      const SizedBox(height: 4),
                      Text(t['text']!, style: QTheme.body),
                    ],
                  ),
                ),
              )
            ).toList(),
          ),

          const SizedBox(height: 24),
          const SectionHeader('Notifications & Automations'),
          QCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: EscrowContent.notifications
                  .map((n) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.notifications_none, size: 18, color: QPalette.slateMuted),
                            const SizedBox(width: 8),
                            Expanded(child: Text(n, style: QTheme.body)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
