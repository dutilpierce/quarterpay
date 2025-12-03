import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// -------- Brand palette --------
class QPalette {
  static const primary   = Color(0xFF20B2AA); // teal-mint
  static const slate     = Color(0xFF1F2937); // text
  static const slateMuted= Color(0xFF6B7280);
  static const cardFill  = Color(0xFFFFFFFF);
  static const border    = Color(0xFFE5E7EB);
  static const success   = Color(0xFF10B981);
  static const warning   = Color(0xFFF59E0B);
  static const info      = Color(0xFF3B82F6);
}

/// -------- Shadows --------
class QShadows {
  static final soft  = [
    BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 18, offset: const Offset(0, 10))
  ];
  static final inset = [
    BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 20, offset: const Offset(0, 4))
  ];
}

/// -------- Typographic scale --------
class QTheme {
  static ThemeData get data => ThemeData(
  scaffoldBackgroundColor: Colors.transparent,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: QPalette.primary),
  textTheme: GoogleFonts.interTextTheme(),
  // ✅ NEW API: CardThemeData (not CardTheme)
  cardTheme: const CardThemeData(
    elevation: 0,
    margin: EdgeInsets.zero,
  ),
);

  static TextStyle get h4        => GoogleFonts.inter(fontSize: 28, height: 1.15, fontWeight: FontWeight.w800, color: QPalette.slate);
  static TextStyle get h5        => GoogleFonts.inter(fontSize: 22, height: 1.20, fontWeight: FontWeight.w800, color: QPalette.slate);
  static TextStyle get h6        => GoogleFonts.inter(fontSize: 18, height: 1.20, fontWeight: FontWeight.w700, color: QPalette.slate);
  static TextStyle get body      => GoogleFonts.inter(fontSize: 14, height: 1.45, color: QPalette.slate);
  static TextStyle get bodyMuted => GoogleFonts.inter(fontSize: 14, height: 1.45, color: QPalette.slateMuted);
  static TextStyle get small     => GoogleFonts.inter(fontSize: 12, height: 1.35, color: QPalette.slateMuted);
  static TextStyle get caption   => GoogleFonts.inter(fontSize: 11, height: 1.25, color: QPalette.slateMuted);

  static Color brandTint(BuildContext _) => QPalette.primary.withOpacity(.12);
}

/// -------- Background: blurred beach --------
class BeachBackground extends StatelessWidget {
  final Widget child;
  const BeachBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'assets/beach.png', // make sure pubspec includes this (see end)
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Container(color: Colors.white.withOpacity(0.35)),
        ),
      ),
      child,
    ]);
  }
}

/// -------- Reusable Card --------
class QCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Color? overlayColor;

  const QCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    final fill = (overlayColor ?? QPalette.cardFill).withOpacity(.68);
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.65)),
        boxShadow: QShadows.soft,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

/// -------- Section Shell with centered title --------
class QSurface extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const QSurface({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: QTheme.h4, textAlign: TextAlign.center),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(subtitle!, style: QTheme.bodyMuted, textAlign: TextAlign.center),
          ],
          const SizedBox(height: 18),
          child,
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

/// -------- Section header (inline) --------
class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(text, style: QTheme.h6));
}

/// -------- Buttons (primary + icon) --------
class QButton {
  static Widget primary({required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: QPalette.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
    );
  }

  static Widget icon({required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: QPalette.primary.withOpacity(.14),
        foregroundColor: QPalette.slate,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: QPalette.primary),
      label: Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
    );
  }
}
