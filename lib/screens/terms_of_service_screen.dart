import 'package:flutter/material.dart';
import '../theme.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Terms of Service',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        QCard(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Placeholder terms for compile-time. Replace with your final legal text.',
            ),
          ),
        ),
      ],
    );
  }
}
