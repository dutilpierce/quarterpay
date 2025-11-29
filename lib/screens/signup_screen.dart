import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create your account', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        const _Field('Email'),
        const SizedBox(height: 8),
        const _Field('Password', obscure: true),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/connect-bills'), child: const Text('Continue')),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String label; final bool obscure; const _Field(this.label, {this.obscure=false});
  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()), obscureText: obscure);
  }
}
