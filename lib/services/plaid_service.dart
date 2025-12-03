import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class PlaidService {
  /// Start a simple Link flow (v5.x) – web mock for dev.
  static Future<void> openLink() async {
    try {
      await PlaidLink.open(); // package handles web mock when no config is passed
    } catch (_) {
      // No-op: On web dev, Plaid can be a no-UI mock; don't crash the app.
    }
  }

  /// Example handler helpers (optional)
  static void onSuccess(String publicToken) {
    debugPrint('Plaid success -> $publicToken');
  }

  static void onExit() {
    debugPrint('Plaid closed.');
  }
}
