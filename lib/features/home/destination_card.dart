import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../../state/providers.dart';
import '../detail/detail_screen.dart';

/// Rounded photo that morphs into the full-bleed header of the detail screen.
class DestinationHero extends StatelessWidget {
  const DestinationHero({super.key, required this.destination, required this.radius, this.alignment = Alignment.center});

  final Destination destination;
  final double radius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'photo-${destination.id}',
        flightShuttleBuilder: (context, animation, direction, from, to) => AnimatedBuilder(
          animation: animation,
          builder: (context, _) => ClipRRect(
            borderRadius: BorderRadius.circular(30 * (1 - animation.value)),
            child: Image.asset(destination.image, fit: BoxFit.cover),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset(destination.image, fit: BoxFit.cover, alignment: alignment),
        ),
      );
}

class DestinationCard extends ConsumerWidget {
  const DestinationCard({super.key, required this.destination, this.height = 296});

  final Destination destination;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = context.lang;
    final d = destination;
    return Pressable(
      scale: .97,
      onTap: () => Navigator.of(context).push(DetailScreen.route(d)),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DestinationHero(destination: d, radius: 30),
            const IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, .55, 1],
                    colors: [Color(0x00000000), Color(0x00000000), Color(0x8C000000)],
                  ),
                ),
              ),
            ),
            Positioned(left: 17, top: 19, child: RatingPill(rating: d.rating)),
            Positioned(top: 17, right: 16, child: FavoriteButton(id: d.id)),
            Positioned(
              left: 18,
              right: 80,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Ico(HugeIcons.strokeRoundedLocation01, size: 18, color: G.white),
                      const SizedBox(width: 4),
                      Text(d.country.of(lang), style: outfit(17, weight: FontWeight.w500, color: G.white, height: 1.26)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    d.name.of(lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: outfit(25, weight: FontWeight.w600, color: G.white, height: 1.26),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: G.white, shape: BoxShape.circle),
                child: const Ico(HugeIcons.strokeRoundedArrowUpRight01, size: 26, color: G.ink, stroke: 1.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingPill extends StatelessWidget {
  const RatingPill({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) => Glass(
        child: SizedBox(
          height: 38,
          child: Padding(
            padding: const EdgeInsets.only(left: 6.3, right: 10.3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, color: G.star, size: 20.5),
                const SizedBox(width: 7),
                Text(rating.toStringAsFixed(1), style: outfit(17, weight: FontWeight.w500, color: G.white)),
              ],
            ),
          ),
        ),
      );
}

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.id, this.size = 42});

  final String id;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fav = ref.watch(favoritesProvider.select((s) => s.contains(id)));
    final l = context.l;
    return Semantics(
      button: true,
      toggled: fav,
      label: fav ? l.removeFavorite : l.addFavorite,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          ref.read(favoritesProvider.notifier).toggle(id);
        },
        child: Glass(
          opacity: fav ? .92 : .24,
          child: SizedBox.square(
            dimension: size,
            child: Center(
              child: TweenAnimationBuilder<double>(
                key: ValueKey(fav),
                tween: Tween(begin: fav ? .4 : .8, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, s, child) => Transform.scale(scale: s, child: child),
                child: Icon(Icons.favorite_rounded, size: 22, color: fav ? G.red : G.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
