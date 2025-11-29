import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Theme + chrome
import 'theme.dart';
import 'sidebar.dart';
import 'widgets/ai_chat_widget.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/bill_connect_screen.dart';
import 'screens/payment_setup_screen.dart';
import 'screens/payment_history_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/bills_screen.dart';
import 'screens/fees_screen.dart';
import 'screens/due_dates_screen.dart';
import 'screens/overview_screen.dart';
import 'screens/ai_helper_screen.dart';
import 'screens/roundup_escrow_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_of_service_screen.dart'; // <- make sure this file exists
import 'screens/how_it_works_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/contact_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env'); // reads OPENAI_API_KEY
  runApp(const QuarterPayApp());
}

class QuarterPayApp extends StatelessWidget {
  const QuarterPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuarterPay',
      debugShowCheckedModeBanner: false,
      theme: QTheme.data, // <- use .data (not .theme)
      initialRoute: '/',
      routes: {
        '/': (context) => const ScreenShell(index: 0, child: HomeScreen()),
        '/signup': (context) => const ScreenShell(index: 1, child: SignupScreen()),
        '/connect-bills': (context) => const ScreenShell(index: 2, child: BillConnectScreen()),
        '/payment-setup': (context) => const ScreenShell(index: 3, child: PaymentSetupScreen()),
        '/history': (context) => const ScreenShell(index: 4, child: PaymentHistoryScreen()),
        '/progress': (context) => const ScreenShell(index: 5, child: ProgressScreen()),
        '/bills': (context) => const ScreenShell(index: 6, child: BillsScreen()),
        '/fees': (context) => const ScreenShell(index: 7, child: FeesScreen()),
        '/due-dates': (context) => const ScreenShell(index: 8, child: DueDatesScreen()),
        '/overview': (context) => const ScreenShell(index: 9, child: OverviewScreen()),
        '/ai-helper': (context) => const ScreenShell(index: 10, child: AIHelperScreen()),
        '/escrow': (context) => const ScreenShell(index: 11, child: RoundUpEscrowScreen()),
        '/faq': (context) => const ScreenShell(index: 12, child: FAQScreen()),
        '/privacy': (context) => const ScreenShell(index: 13, child: PrivacyPolicyScreen()),
        '/terms': (context) => const ScreenShell(index: 14, child: TermsOfServiceScreen()),
        '/how-it-works': (context) => const ScreenShell(index: 15, child: HowItWorksScreen()),
        '/about': (context) => const ScreenShell(index: 16, child: AboutUsScreen()),
        '/contact': (context) => const ScreenShell(index: 17, child: ContactScreen()),
      },
    );
  }
}

/// Shared shell: beach background, left sidebar, floating AI chat button
class ScreenShell extends StatefulWidget {
  final Widget child;
  final int index;
  const ScreenShell({super.key, required this.child, required this.index});

  @override
  State<ScreenShell> createState() => _ScreenShellState();
}

class _ScreenShellState extends State<ScreenShell> {
  bool _chatOpen = false;

  void _go(int i) {
    const routes = [
      '/', '/signup', '/connect-bills', '/payment-setup', '/history', '/progress',
      '/bills', '/fees', '/due-dates', '/overview', '/ai-helper', '/escrow',
      '/faq', '/privacy', '/terms', '/how-it-works', '/about', '/contact'
    ];
    if (i >= 0 && i < routes.length) {
      Navigator.of(context).pushReplacementNamed(routes[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = Row(
      children: [
        // ← The corrected sidebar reference
        AppSidebar(selectedIndex: widget.index, onTap: _go),
        const VerticalDivider(width: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: widget.child,
          ),
        ),
      ],
    );

    return BeachBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => _chatOpen = true),
          child: const Icon(Icons.chat_bubble_outline),
        ),
        bottomSheet: _chatOpen
            ? _AISheet(onClose: () => setState(() => _chatOpen = false))
            : null,
      ),
    );
  }
}

class _AISheet extends StatelessWidget {
  final VoidCallback onClose;
  const _AISheet({required this.onClose});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey('ai-sheet'),
      direction: DismissDirection.down,
      onDismissed: (_) => onClose(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: const Material(
          elevation: 12,
          child: AIChatWidget(),
        ),
      ),
    );
  }
}
