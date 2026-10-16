import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../../state/providers.dart';
import '../search/search_screen.dart';
import '../shell/shell.dart';
import 'destination_card.dart';
import 'notifications_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final name = ref.watch(nameProvider);
    final region = ref.watch(regionProvider);
    final list = ref.watch(homeDestinationsProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 8, G.pad, 0),
            child: Row(
              children: [
                CircleBtn(
                  semantics: l.menu,
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Ico(HugeIcons.strokeRoundedMenu01, size: 19),
                ),
                const Spacer(),
                CircleBtn(
                  semantics: l.searchHint,
                  onTap: () => Navigator.of(context).push(SearchScreen.route()),
                  child: const Ico(HugeIcons.strokeRoundedSearch01, size: 23),
                ),
                const SizedBox(width: 13),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleBtn(
                      semantics: l.notifications,
                      onTap: () => showNotifications(context),
                      child: const Ico(HugeIcons.strokeRoundedNotification01, size: 22),
                    ),
                    const Positioned(top: -0.5, right: 1.5, child: _PulseDot()),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(G.pad, 23, G.pad, 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    l.greeting(name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: outfit(31, weight: FontWeight.w600, height: 1.26),
                  ),
                ),
                const SizedBox(width: 9),
                const _Wave(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 51 + 25.7,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(G.pad, 25.7, G.pad, 0),
              scrollDirection: Axis.horizontal,
              itemCount: Region.values.length,
              separatorBuilder: (_, _) => const SizedBox(width: 13),
              itemBuilder: (context, i) {
                final r = Region.values[i];
                return Reveal(
                  index: i,
                  offset: 12,
                  child: RegionChip(
                    region: r,
                    selected: region == r,
                    onTap: () => ref.read(regionProvider.notifier).toggle(r),
                  ),
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(G.pad, 26, G.pad, navHeight(context) + 24),
          sliver: SliverList.separated(
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 17),
            itemBuilder: (context, i) => Reveal(
              key: ValueKey('${region?.name}-${list[i].id}'),
              index: i,
              child: DestinationCard(destination: list[i]),
            ),
          ),
        ),
      ],
    );
  }
}

String regionName(BuildContext context, Region r) => switch (r) {
      Region.asia => context.l.regionAsia,
      Region.europe => context.l.regionEurope,
      Region.america => context.l.regionAmerica,
    };

class RegionChip extends StatelessWidget {
  const RegionChip({super.key, required this.region, required this.selected, required this.onTap});

  final Region region;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Pressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: 51,
          padding: const EdgeInsets.fromLTRB(2.5, 2.5, 18, 2.5),
          decoration: BoxDecoration(
            color: selected ? G.ink : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: selected ? G.ink : G.line),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(child: Image.asset(regionImages[region]!, width: 44, height: 44, fit: BoxFit.cover)),
              const SizedBox(width: 9),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 260),
                style: outfit(17, weight: FontWeight.w500, color: selected ? G.white : Colors.black),
                child: Text(regionName(context, region)),
              ),
            ],
          ),
        ),
      );
}

/// Waving hand that greets the user when the screen opens.
class _Wave extends StatelessWidget {
  const _Wave();

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1600),
        builder: (context, t, child) {
          // Three quick waves that settle back to the resting angle.
          final angle = t >= 1 ? 0.0 : 0.35 * (1 - t) * math.sin(t * 6 * math.pi);
          return Transform.rotate(angle: angle, alignment: const Alignment(.4, .8), child: child);
        },
        child: const Text('👋', style: TextStyle(fontSize: 27, height: 1.1)),
      );
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
    ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 8,
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + 1.4 * _c.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: G.red.withValues(alpha: .35 * (1 - _c.value)),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(decoration: const BoxDecoration(color: G.red, shape: BoxShape.circle)),
            ],
          ),
        ),
      );
}
