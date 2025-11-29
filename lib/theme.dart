// lib/theme.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ------- Palette (premium / fintech) -------
class QPalette {
  // Brand core
  static const Color primary = Color(0xFF0EA5A0); // teal sea
  static const Color primaryDark = Color(0xFF0B7F7B);
  static const Color accent = Color(0xFF2DD4BF); // aqua accent
  static const Color mint = Color(0xFFE8FFF7);   // used by sidebar/fills

  // Neutrals
  static const Color slate = Color(0xFF334155);        // slate-700
  static const Color slateMuted = Color(0xFF64748B);   // slate-500
  static const Color card = Colors.white;
  static const Color surface = Color(0xFFF7FAFB);
  static const Color border = Color(0xFFE5E7EB);       // <— added

  // Shadows
  static const Color shadowSoft = Color(0x1A000000);
  static const Color shadowStrong = Color(0x33000000);
}

/// ------- Shadows helpers (for consistent depth) -------
class QShadows {
  static const soft = <BoxShadow>[
    BoxShadow(color: QPalette.shadowSoft, blurRadius: 18, offset: Offset(0, 10)),
    BoxShadow(color: Colors.white, blurRadius: 2, spreadRadius: -2, offset: Offset(0, -1)),
  ];

  // Slight inset look (use for sidebar/background panels)
  static const inset = <BoxShadow>[
    BoxShadow(color: QPalette.shadowSoft, blurRadius: 12, offset: Offset(0, 4)),
  ];
}

/// ------- ThemeData (luxury fintech feel) -------
class QTheme {
  static ThemeData get theme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: QPalette.primary,
      primary: QPalette.primary,
      secondary: QPalette.accent,
      surface: QPalette.surface,
      background: Colors.transparent,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: QPalette.slate,
        displayColor: QPalette.slate,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: QPalette.slate,
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: QPalette.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          shadowColor: QPalette.shadowSoft,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: QPalette.primary,
          side: const BorderSide(color: QPalette.primary),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: QPalette.slateMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: QPalette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: QPalette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: QPalette.primary),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: QPalette.border,
        thickness: 1,
      ),
    );
  }

  /// Alias so code using `QTheme.data` compiles without changing main.dart
  static ThemeData get data => theme;
}

/// ------- Beach background with blur & gradient fallback -------
class BeachBackground extends StatelessWidget {
  final Widget child;
  const BeachBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Soft gradient fallback (if asset missing on web)
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF0FBFF), Color(0xFFE6F7F6)],
            ),
          ),
        ),
        // Optional beach image
        Image.asset(
          'assets/images/beach.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.white.withOpacity(0.35)),
        ),
        child,
      ],
    );
  }
}

/// ------- Premium card w/ soft shadow & 3D feel -------
class QCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const QCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? QPalette.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QPalette.border),
        boxShadow: QShadows.soft,
      ),
      child: child,
    );
  }
}

/// ------- Centered page surface (max width + padding) -------
class QSurface extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  const QSurface({
    super.key,
    required this.child,
    this.maxWidth = 1100,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return BeachBackground(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
