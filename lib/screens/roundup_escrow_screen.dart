import 'package:flutter/material.dart';
import '../theme.dart';

class RoundUpEscrowScreen extends StatefulWidget {
  const RoundUpEscrowScreen({super.key});

  @override
  State<RoundUpEscrowScreen> createState() => _RoundUpEscrowScreenState();
}

class _RoundUpEscrowScreenState extends State<RoundUpEscrowScreen> {
  bool showViralCopy = false; // toggle between versions

  @override
  Widget build(BuildContext context) {
    return QSurface(
      title: 'Round-Ups & Escrow Boost',
      subtitle: 'Lock small amounts automatically to lower your quarterly fee.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Switch.adaptive(
                value: showViralCopy,
                onChanged: (v) => setState(() => showViralCopy = v),
              ),
              const SizedBox(width: 8),
              Text(showViralCopy ? 'Viral version' : 'Premium version', style: QTheme.small),
            ],
          ),
          const SizedBox(height: 8),
          if (showViralCopy) _viral(context) else _premium(context),
        ],
      ),
    );
  }

  Widget _premium(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Instant Boost', style: QTheme.h6),
              const SizedBox(height: 6),
              Text('Lock an amount now to immediately reduce your fee on this quarter.',
                  style: QTheme.bodyMuted),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {/* TODO: wire */},
                icon: const Icon(Icons.bolt_outlined),
                label: const Text('Add Instant Boost'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        QCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Round-Ups', style: QTheme.h6),
              const SizedBox(height: 6),
              Text('Round purchases to the nearest dollar and lock the spare change into escrow.',
                  style: QTheme.bodyMuted),
              const SizedBox(height: 8),
              Row(children: [
                Switch.adaptive(value: true, onChanged: (v) {}),
                const SizedBox(width: 8),
                Text('Enable round-ups', style: QTheme.body),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _viral(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Instant Boost', style: QTheme.h6),
              const SizedBox(height: 6),
              Text('Tap to boost now and flex your progress.', style: QTheme.bodyMuted),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {/* TODO: wire */},
                icon: const Icon(Icons.bolt_outlined),
                label: const Text('Boost me now'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        QCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Round-Ups', style: QTheme.h6),
              const SizedBox(height: 6),
              Text('Turn on spare-change round-ups to push your fee down.', style: QTheme.bodyMuted),
              const SizedBox(height: 8),
              Row(children: [
                Switch.adaptive(value: true, onChanged: (v) {}),
                const SizedBox(width: 8),
                Text('Enable round-ups', style: QTheme.body),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
