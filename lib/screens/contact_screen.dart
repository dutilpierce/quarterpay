import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      Text('Contact'),
      SizedBox(height: 8),
      Text('Email: admin@quarterpaysolutions.com')
    ]);
  }
}
