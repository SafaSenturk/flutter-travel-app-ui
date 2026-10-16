import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../../state/providers.dart';
import '../detail/detail_screen.dart';
import '../home/destination_card.dart';
import '../home/home_screen.dart';
import '../shell/shell.dart';

/// Filter for the Discover grid: a region, every destination or favourites.
sealed class DiscoverFilter {
  const DiscoverFilter();
}

class AllFilter extends DiscoverFilter {
  const AllFilter();
}

class RegionFilter extends DiscoverFilter {
  const RegionFilter(this.region);

  final Region region;

  @override
  bool operator ==(Object other) => other is RegionFilter && other.region == region;

  @override
  int get hashCode => region.hashCode;
}

class FavoritesFilter extends DiscoverFilter {
  const FavoritesFilter();
}

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  DiscoverFilter _filter = const AllFilter();

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final favs = ref.watch(favoritesProvider);
    final list = switch (_filter) {
      AllFilter() => destinations,
      RegionFilter(:final region) => destinations.where((d) => d.region == region).toList(),
      FavoritesFilter() => destinations.where((d) => favs.contains(d.id)).toList(),
    };
    final filters = <(DiscoverFilter, String)>[
      (const AllFilter(), l.all),
      for (final r in Region.values) (RegionFilter(r), regionName(context, r)),
      (const FavoritesFilter(), l.favorites),
    ];
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 14, G.pad, 0),
            child: Text(l.discoverTitle, style: outfit(31, weight: FontWeight.w600, height: 1.26)),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40 + 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(G.pad, 20, G.pad, 16),
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final (f, label) = filters[i];
                // Const filters are canonicalised, RegionFilter compares by value.
                final selected = f == _filter;
                return Pressable(
                  onTap: () => setState(() => _filter = f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? G.ink : G.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? G.ink : G.line),
                    ),
                    child: Row(
                      children: [
                        if (f is FavoritesFilter) ...[
                          Icon(Icons.favorite_rounded, size: 16, color: selected ? G.red : G.red.withValues(alpha: .8)),
                          const SizedBox(width: 6),
                        ],
                        Text(label,
                            style: outfit(15, weight: FontWeight.w500, color: selected ? G.white : G.ink)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (list.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 40, navHeight(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border_rounded, size: 54, color: G.line),
                  const SizedBox(height: 12),
                  Text(l.noFavorites, textAlign: TextAlign.center, style: outfit(16, color: G.gray)),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(G.pad, 0, G.pad, navHeight(context) + 24),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 13,
                childAspectRatio: .7,
              ),
              itemCount: list.length,
              itemBuilder: (context, i) => Reveal(
                key: ValueKey('${_filter.runtimeType}-${_filter.hashCode}-${list[i].id}'),
                index: i,
                child: _Tile(destination: list[i]),
              ),
            ),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    final d = destination;
    return Pressable(
      onTap: () => Navigator.of(context).push(DetailScreen.route(d)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(d.image, fit: BoxFit.cover, cacheWidth: 500),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [.45, 1],
                  colors: [Color(0x00000000), Color(0xA6000000)],
                ),
              ),
            ),
            Positioned(top: 10, right: 10, child: FavoriteButton(id: d.id, size: 36)),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.name.of(lang),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: outfit(18, weight: FontWeight.w600, color: G.white)),
                  Row(
                    children: [
                      const Ico(HugeIcons.strokeRoundedLocation01, size: 14, color: G.white),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(d.country.of(lang),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: outfit(13, color: G.white.withValues(alpha: .9))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(money(d.price), style: outfit(16, weight: FontWeight.w600, color: G.white)),
                      Text(context.l.perNight, style: outfit(12, color: G.white.withValues(alpha: .85))),
                      const Spacer(),
                      const Icon(Icons.star_rounded, size: 15, color: G.star),
                      const SizedBox(width: 2),
                      Text(d.rating.toStringAsFixed(1), style: outfit(13, weight: FontWeight.w500, color: G.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
