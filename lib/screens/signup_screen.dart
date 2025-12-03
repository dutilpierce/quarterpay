import 'package:flutter/material.dart';
import '../theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctl = {
      'first': TextEditingController(),
      'last': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
      'addr1': TextEditingController(),
      'addr2': TextEditingController(),
      'city' : TextEditingController(),
      'state': TextEditingController(),
      'zip'  : TextEditingController(),
      'dob'  : TextEditingController(),
    };

    Widget field(String label, TextEditingController c, {TextInputType? type}) {
      return TextField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white.withOpacity(.68),
        ),
      );
    }

    return QSurface(
      title: 'Signup',
      subtitle: 'Tell us a bit about you to get started.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Wrap(
                spacing: 16, runSpacing: 16,
                children: [
                  SizedBox(width: 240, child: field('First name', ctl['first']!)),
                  SizedBox(width: 240, child: field('Last name',  ctl['last']!)),
                  SizedBox(width: 500, child: field('Email',      ctl['email']!, type: TextInputType.emailAddress)),
                  SizedBox(width: 260, child: field('Phone',      ctl['phone']!, type: TextInputType.phone)),
                  SizedBox(width: 500, child: field('Address line 1', ctl['addr1']!)),
                  SizedBox(width: 500, child: field('Address line 2 (optional)', ctl['addr2']!)),
                  SizedBox(width: 260, child: field('City',  ctl['city']!)),
                  SizedBox(width: 100, child: field('State', ctl['state']!)),
                  SizedBox(width: 120, child: field('ZIP',   ctl['zip']!, type: TextInputType.number)),
                  SizedBox(width: 200, child: field('DOB (YYYY-MM-DD)', ctl['dob']!, type: TextInputType.datetime)),
                ],
              ),
              const SizedBox(height: 16),
              QButton.primary(label: 'Create Account', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
