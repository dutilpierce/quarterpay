import 'package:flutter/foundation.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

/// Plaid v5 flow:
/// 1) PlaidLink.create(configuration: LinkTokenConfiguration(...))
/// 2) Attach listeners (onSuccess / onExit / onEvent)
/// 3) PlaidLink.open()
class PlaidService {
  static Future<void> openLink({
    required String linkToken,
    required void Function(String publicToken) onSuccess,
  }) async {
    // Create the Link session with your link_token
    await PlaidLink.create(
      configuration: LinkTokenConfiguration(token: linkToken),
    );

    // Success
    PlaidLink.onSuccess.listen((e) {
      if (kDebugMode) debugPrint('Plaid success → ${e.publicToken}');
      onSuccess(e.publicToken);
    });

    // Exit (v5: safest to rely on displayMessage or fallback to a generic string)
    PlaidLink.onExit.listen((e) {
      final msg = e.error?.displayMessage ?? 'closed';
      if (kDebugMode) debugPrint('Plaid exit → $msg');
    });

    // Events
    PlaidLink.onEvent.listen((e) {
      if (kDebugMode) debugPrint('Plaid event → ${e.name}');
    });

    // Open the Link modal
    await PlaidLink.open();
  }
}
