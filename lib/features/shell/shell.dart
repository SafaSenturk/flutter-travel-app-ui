import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/providers.dart';
import '../booking/bookings_screen.dart';
import '../discover/discover_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import 'app_drawer.dart';

/// Height of the tab bar above the bottom inset (74 pt in the design).
const navContentHeight = 74.0;

double navHeight(BuildContext context) => navContentHeight + Insets.bottom(context);

class Shell extends ConsumerWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(tabProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: tab,
                children: const [HomeScreen(), DiscoverScreen(), BookingsScreen(), ProfileScreen()],
              ),
            ),
            const Positioned(left: 0, right: 0, bottom: 0, child: NavBar()),
          ],
        ),
      ),
    );
  }
}

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final tab = ref.watch(tabProvider);
    final items = [
      (l.navHome, null),
      (l.navDiscover, HugeIcons.strokeRoundedMapsSearch),
      (l.navBooking, HugeIcons.strokeRoundedCalendar03),
      (l.navProfile, HugeIcons.strokeRoundedUser),
    ];
    return Container(
      height: navHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: G.pad),
      decoration: const BoxDecoration(
        color: G.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Color(0x140B1230), blurRadius: 30, offset: Offset(0, -4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, (label, icon)) in items.indexed)
            Expanded(
              child: _NavItem(
                label: label,
                icon: icon,
                active: tab == i,
                onTap: () {
                  if (tab != i) HapticFeedback.selectionClick();
                  ref.read(tabProvider.notifier).go(i);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.label, required this.icon, required this.active, required this.onTap});

  final String label;
  final List<List<dynamic>>? icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? G.blue : G.ink;
    return Semantics(
      selected: active,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 21),
            TweenAnimationBuilder<double>(
              key: ValueKey(active),
              tween: Tween(begin: active ? .6 : 1, end: 1),
              duration: const Duration(milliseconds: 450),
              curve: Curves.elasticOut,
              builder: (context, s, child) => Transform.scale(scale: s, child: child),
              child: icon == null
                  ? HomeGlyph(color: color, filled: active)
                  : Ico(icon!, color: color, size: 24, stroke: active ? 1.8 : 1.5),
            ),
            const SizedBox(height: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: outfit(14, color: color, height: 1.26, weight: active ? FontWeight.w500 : FontWeight.w400),
              child: Text(label, maxLines: 1, overflow: TextOverflow.fade, softWrap: false),
            ),
          ],
        ),
      ),
    );
  }
}
