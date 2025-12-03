import 'package:flutter/material.dart';

class RoundUpEscrowScreen extends StatefulWidget {
  const RoundUpEscrowScreen({super.key});
  @override
  State<RoundUpEscrowScreen> createState() => _RoundUpEscrowScreenState();
}

class _RoundUpEscrowScreenState extends State<RoundUpEscrowScreen> {
  @override
  void initState() {
    super.initState();
    // Immediately redirect to Progress
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pushReplacementNamed('/progress');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // nothing visible; instant redirect
  }
}
