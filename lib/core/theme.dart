import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Colours sampled from the Dribbble shot.
abstract final class G {
  static const bg = Color(0xFFF5F6F7);
  static const ink = Color(0xFF080A23);
  static const black = Color(0xFF0C0B0C);
  static const blue = Color(0xFF0283D3);
  static const gray = Color(0xFF4A4C4E);
  static const muted = Color(0xFF8A8C93);
  static const line = Color(0xFFE1E3E7);
  static const soft = Color(0xFFE8E8E8);
  static const star = Color(0xFFFFC83A);
  static const red = Color(0xFFFF2D2D);
  static const white = Colors.white;

  static const font = 'Outfit';

  /// Horizontal page padding used across the design (21 pt).
  static const pad = 21.0;
}

/// The design is drawn on an iPhone frame (54 pt status bar, 34 pt home
/// indicator). Using at least those insets keeps every screen spaced exactly
/// like the mock-up, while still respecting bigger system insets.
abstract final class Insets {
  static double top(BuildContext context) => math.max(MediaQuery.viewPaddingOf(context).top, 54);
  static double bottom(BuildContext context) => math.max(MediaQuery.viewPaddingOf(context).bottom, 34);
}

/// Outfit with the tight tracking measured from the shot (about -3.5 %).
TextStyle outfit(double size,
        {FontWeight weight = FontWeight.w400, Color color = G.ink, double? height, double tracking = -0.035}) =>
    TextStyle(
      fontFamily: G.font,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: tracking * size,
    );

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    fontFamily: G.font,
    scaffoldBackgroundColor: G.bg,
    colorScheme: ColorScheme.fromSeed(seedColor: G.blue, primary: G.blue, surface: G.bg),
    splashFactory: InkSparkle.splashFactory,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(bodyColor: G.ink, displayColor: G.ink, fontFamily: G.font),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: G.ink,
      contentTextStyle: outfit(15, color: G.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: G.white,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: G.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeForwardsPageTransitionsBuilder()},
    ),
  );
}
