import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.initialPage = 0});

  final int initialPage;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> with SingleTickerProviderStateMixin {
  static const _images = ['assets/images/onboarding_1.jpg', 'assets/images/onboarding_2.jpg', 'assets/images/onboarding_3.jpg'];

  late int _page = widget.initialPage;
  late final AnimationController _story = AnimationController(vsync: this, duration: const Duration(milliseconds: 5200))
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed && _page < _images.length - 1) _go(_page + 1);
    })
    ..forward();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final img in _images) {
      precacheImage(AssetImage(img), context);
    }
  }

  @override
  void dispose() {
    _story.dispose();
    super.dispose();
  }

  void _go(int page) {
    if (page < 0 || page >= _images.length) return;
    setState(() => _page = page);
    _story.forward(from: 0);
  }

  void _next() => _page == _images.length - 1 ? _finish() : _go(_page + 1);

  void _finish() {
    HapticFeedback.mediumImpact();
    ref.read(onboardedProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final titles = [(l.onb1Title, l.onb1Sub), (l.onb2Title, l.onb2Sub), (l.onb3Title, l.onb3Sub)];
    final top = Insets.top(context);
    final bottom = Insets.bottom(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onHorizontalDragEnd: (d) {
            final v = d.primaryVelocity ?? 0;
            if (v < -200) _go(_page + 1);
            if (v > 200) _go(_page - 1);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo with a slow Ken Burns zoom, cross-faded between slides.
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                child: AnimatedBuilder(
                  key: ValueKey(_page),
                  animation: _story,
                  builder: (context, child) => Transform.scale(scale: 1.0 + .06 * _story.value, child: child),
                  child: Image.asset(_images[_page], fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, .45, 1],
                    colors: [Color(0x00000000), Color(0x00000000), Color(0x80000000)],
                  ),
                ),
              ),
              // Story bars.
              Positioned(
                top: top, // + 8 pt of tap padding inside each bar
                left: G.pad,
                right: G.pad,
                child: AnimatedBuilder(
                  animation: _story,
                  builder: (context, _) => Row(
                    children: [
                      for (var i = 0; i < _images.length; i++) ...[
                        if (i > 0) const SizedBox(width: 6.5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _go(i),
                            child: _Bar(value: i < _page ? 1 : (i == _page ? _story.value : 0)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Positioned(
                top: top + 35,
                left: G.pad,
                child: Text(l.appName, style: outfit(42, weight: FontWeight.w600, color: const Color(0xFF0A0A0A), height: 1.26, tracking: -.01)),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: bottom + 8 + 58 + 108,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  transitionBuilder: (child, a) => FadeTransition(
                    opacity: a,
                    child: SlideTransition(
                      position: Tween(begin: const Offset(0, .18), end: Offset.zero)
                          .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
                      child: child,
                    ),
                  ),
                  layoutBuilder: (current, previous) =>
                      Stack(alignment: Alignment.bottomLeft, children: [...previous, ?current]),
                  child: Column(
                    key: ValueKey(_page),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: Text(titles[_page].$1,
                            style: outfit(48, weight: FontWeight.w600, color: G.white, height: 1.146, tracking: 0)),
                      ),
                      const SizedBox(height: 16),
                      Text(titles[_page].$2, style: outfit(16.3, color: G.white, height: 1.26, tracking: 0)),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 19,
                bottom: bottom + 8,
                child: SlideToContinue(
                  label: l.continueLabel,
                  hint: l.slide,
                  onTap: _next,
                  onSlid: _finish,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            height: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: Colors.white.withValues(alpha: .4)),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value.clamp(0, 1),
                  child: const ColoredBox(color: G.white),
                ),
              ],
            ),
          ),
        ),
      );
}

/// The "Continue ··· Slide →" control: tap the knob to go to the next slide or
/// drag it to the end to start the app.
class SlideToContinue extends StatefulWidget {
  const SlideToContinue({super.key, required this.label, required this.hint, required this.onTap, required this.onSlid});

  final String label;
  final String hint;
  final VoidCallback onTap;
  final VoidCallback onSlid;

  @override
  State<SlideToContinue> createState() => _SlideToContinueState();
}

class _SlideToContinueState extends State<SlideToContinue> with TickerProviderStateMixin {
  static const _height = 58.0;
  static const _inset = 4.0;
  static const _knobWidth = 117.0;

  double _dx = 0;
  double _max = 1;
  late final AnimationController _back = AnimationController(vsync: this, duration: const Duration(milliseconds: 380))
    ..addListener(() => setState(() => _dx = _from * (1 - Curves.easeOutBack.transform(_back.value))));
  late final AnimationController _nudge =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  double _from = 0;

  @override
  void dispose() {
    _back.dispose();
    _nudge.dispose();
    super.dispose();
  }

  void _end() {
    if (_dx > _max * .72) {
      setState(() => _dx = _max);
      widget.onSlid();
      return;
    }
    _from = _dx;
    _back.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, box) {
          _max = box.maxWidth - _knobWidth - _inset * 2;
          final progress = (_dx / _max).clamp(0.0, 1.0);
          return Glass(
            radius: _height / 2,
            opacity: .16,
            blur: 14,
            child: Container(
              height: _height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_height / 2),
                border: Border.all(color: Colors.white.withValues(alpha: .28)),
                gradient: LinearGradient(colors: [Colors.white.withValues(alpha: .10), Colors.black.withValues(alpha: .10)]),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: 1 - progress,
                      child: Row(
                        children: [
                          Text(widget.hint, style: outfit(17.5, weight: FontWeight.w500, color: G.white)),
                          const SizedBox(width: 6),
                          AnimatedBuilder(
                            animation: _nudge,
                            builder: (context, child) {
                              final t = Curves.easeInOut.transform((_nudge.value * 2).clamp(0.0, 1.0));
                              return Transform.translate(offset: Offset(4 * (t < .5 ? t * 2 : 2 - t * 2), 0), child: child);
                            },
                            child: const Ico(HugeIcons.strokeRoundedArrowRight02, size: 24, color: G.white, stroke: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: _inset + _dx,
                    top: _inset,
                    bottom: _inset,
                    child: GestureDetector(
                      onTap: widget.onTap,
                      onHorizontalDragStart: (_) => _back.stop(),
                      onHorizontalDragUpdate: (d) => setState(() => _dx = (_dx + d.delta.dx).clamp(0, _max)),
                      onHorizontalDragEnd: (_) => _end(),
                      child: Container(
                        width: _knobWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: G.black, borderRadius: BorderRadius.circular(25)),
                        child: Text(widget.label, style: outfit(17.5, weight: FontWeight.w500, color: G.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
