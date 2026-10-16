import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../l10n/app_localizations.dart';
import 'theme.dart';

extension L10nX on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
  String get lang => Localizations.localeOf(this).languageCode;
}

/// Hugeicons glyph with the design's stroke weight.
class Ico extends StatelessWidget {
  const Ico(this.icon, {super.key, this.size = 24, this.color = G.ink, this.stroke = 1.5});

  final List<List<dynamic>> icon;
  final double size;
  final Color color;
  final double stroke;

  @override
  Widget build(BuildContext context) => HugeIcon(icon: icon, size: size, color: color, strokeWidth: stroke);
}

/// Shrinks a little while pressed – used for every tappable card and button.
class Pressable extends StatefulWidget {
  const Pressable({super.key, required this.child, this.onTap, this.scale = .96});

  final Widget child;
  final VoidCallback? onTap;
  final double scale;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  void _set(bool v) {
    if (widget.onTap != null && _down != v) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) => Semantics(
        button: widget.onTap != null,
        container: widget.onTap != null,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _set(true),
          onTapUp: (_) => _set(false),
          onTapCancel: () => _set(false),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _down ? widget.scale : 1,
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOut,
            child: widget.child,
          ),
        ),
      );
}

/// 42 pt white round button from the home header.
class CircleBtn extends StatelessWidget {
  const CircleBtn({super.key, required this.child, required this.onTap, this.size = 42, this.semantics});

  final Widget child;
  final VoidCallback onTap;
  final double size;
  final String? semantics;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: semantics,
        child: Pressable(
          onTap: onTap,
          scale: .9,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: G.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x0F0B1230), blurRadius: 18, offset: Offset(0, 6))],
            ),
            child: child,
          ),
        ),
      );
}

/// Frosted glass shape used on top of photos.
class Glass extends StatelessWidget {
  const Glass({super.key, required this.child, this.radius = 100, this.opacity = .24, this.blur = 12});

  final Widget child;
  final double radius;
  final double opacity;
  final double blur;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: ColoredBox(color: Colors.white.withValues(alpha: opacity), child: child),
        ),
      );
}

/// The filled "smiling house" from the design's tab bar.
class HomeGlyph extends StatelessWidget {
  const HomeGlyph({super.key, required this.color, this.filled = true, this.size = 24});

  final Color color;
  final bool filled;
  final double size;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _HomePainter(color, filled));
}

class _HomePainter extends CustomPainter {
  _HomePainter(this.color, this.filled);

  final Color color;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    canvas.scale(s);
    // Rounded pentagon: roof apex at the top, straight walls, rounded base.
    final house = Path()
      ..moveTo(10.2, 2.9)
      ..quadraticBezierTo(12, 1.6, 13.8, 2.9)
      ..lineTo(20.2, 7.6)
      ..quadraticBezierTo(21.4, 8.5, 21.4, 10)
      ..lineTo(21.4, 18.4)
      ..quadraticBezierTo(21.4, 21.6, 18.2, 21.6)
      ..lineTo(5.8, 21.6)
      ..quadraticBezierTo(2.6, 21.6, 2.6, 18.4)
      ..lineTo(2.6, 10)
      ..quadraticBezierTo(2.6, 8.5, 3.8, 7.6)
      ..close();
    final smile = Path()
      ..moveTo(9, 16)
      ..quadraticBezierTo(12, 18.4, 15, 16);
    if (filled) {
      canvas.drawPath(house, Paint()..color = color);
      canvas.drawPath(
        smile,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round,
      );
    } else {
      final stroke = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(house, stroke);
      canvas.drawPath(smile, stroke);
    }
  }

  @override
  bool shouldRepaint(_HomePainter old) => old.color != color || old.filled != filled;
}

/// Fades and slides its child in, delayed by [index] – used for staggered lists.
class Reveal extends StatelessWidget {
  const Reveal({super.key, required this.index, required this.child, this.offset = 24});

  final int index;
  final Widget child;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final delay = 70 * index.clamp(0, 8);
    final total = 460 + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutCubic),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, offset * (1 - t)), child: child),
      ),
      child: child,
    );
  }
}

String money(int value) {
  final s = value.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return '\$$b';
}
