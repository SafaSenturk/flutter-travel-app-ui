import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../../state/providers.dart';
import '../home/destination_card.dart';
import 'booking_sheet.dart';
import 'message_sheet.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, required this.destination});

  final Destination destination;

  static Route<void> route(Destination d) => PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 520),
        reverseTransitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, _, _) => DetailScreen(destination: d),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: const Interval(0, .5)),
          child: child,
        ),
      );

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  final _extras = <Extra>{};
  bool _expanded = false;

  Destination get d => widget.destination;

  void _more(BuildContext buttonContext) {
    final l = context.l;
    final fav = ref.read(favoritesProvider).contains(d.id);
    final box = buttonContext.findRenderObject()! as RenderBox;
    final origin = box.localToGlobal(Offset.zero);
    showMenu<String>(
      context: context,
      color: G.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      position: RelativeRect.fromLTRB(origin.dx, origin.dy + box.size.height + 6, G.pad, 0),
      items: [
        PopupMenuItem(
          value: 'share',
          child: Row(children: [
            const Ico(HugeIcons.strokeRoundedShare08, size: 20),
            const SizedBox(width: 12),
            Text(l.share, style: outfit(16)),
          ]),
        ),
        PopupMenuItem(
          value: 'fav',
          child: Row(children: [
            Icon(fav ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 20, color: fav ? G.red : G.ink),
            const SizedBox(width: 12),
            Text(fav ? l.removeFavorite : l.addFavorite, style: outfit(16)),
          ]),
        ),
      ],
    ).then((value) {
      if (!mounted) return;
      if (value == 'fav') ref.read(favoritesProvider.notifier).toggle(d.id);
      if (value == 'share') {
        Clipboard.setData(ClipboardData(text: 'https://globego.app/d/${d.id}'));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l.linkCopied)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final lang = context.lang;
    final route = ModalRoute.of(context)!;
    final sheetIn = CurvedAnimation(parent: route.animation!, curve: Curves.easeOutCubic);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: G.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              bottom: 200,
              child: DestinationHero(destination: d, radius: 0, alignment: const Alignment(0, -.3)),
            ),
            Positioned(
              top: Insets.top(context) + 8,
              left: G.pad,
              child: _GlassButton(
                semantics: MaterialLocalizations.of(context).backButtonTooltip,
                onTap: () => Navigator.of(context).maybePop(),
                child: const Ico(HugeIcons.strokeRoundedArrowLeft01, size: 26, color: G.white),
              ),
            ),
            Positioned(
              top: Insets.top(context) + 8,
              right: G.pad,
              child: Builder(
                builder: (buttonContext) => _GlassButton(
                  semantics: MaterialLocalizations.of(context).moreButtonTooltip,
                  onTap: () => _more(buttonContext),
                  child: const Ico(HugeIcons.strokeRoundedMoreVertical, size: 24, color: G.white, stroke: 2.2),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: Tween(begin: const Offset(0, .35), end: Offset.zero).animate(sheetIn),
                child: Container(
                  padding: EdgeInsets.fromLTRB(G.pad, 20.6, G.pad, Insets.bottom(context) + 2),
                  decoration: const BoxDecoration(
                    color: G.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            child: Text(
                              d.name.of(lang),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: outfit(26, weight: FontWeight.w600, height: 1.26),
                            ),
                          ),
                          Text(money(d.price), style: outfit(26, weight: FontWeight.w600, height: 1.26)),
                          const SizedBox(width: 7),
                          Text(l.perNight, style: outfit(21.5, color: G.gray, height: 1.26)),
                        ],
                      ),
                      const SizedBox(height: 20.6),
                      Wrap(
                        spacing: 13,
                        runSpacing: 10,
                        children: [
                          for (final e in Extra.values)
                            ExtraChip(
                              extra: e,
                              selected: _extras.contains(e),
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _extras.contains(e) ? _extras.remove(e) : _extras.add(e));
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 24.4),
                      Text(l.scheduleOverview, style: outfit(19.5, weight: FontWeight.w600, height: 1.26)),
                      const SizedBox(height: 9.2),
                      GestureDetector(
                        onTap: () => setState(() => _expanded = !_expanded),
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.about.of(lang),
                                maxLines: _expanded ? null : 2,
                                overflow: TextOverflow.clip,
                                style: outfit(16, color: G.gray, height: 1.375, tracking: -0.04),
                              ),
                              if (_expanded)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(l.readLess,
                                      style: outfit(15, weight: FontWeight.w500, color: G.blue)),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        children: [
                          Expanded(
                            child: _PillButton(
                              label: l.message,
                              background: G.soft,
                              foreground: G.ink,
                              onTap: () => showMessageSheet(context, d),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: _PillButton(
                              label: l.bookNow,
                              background: G.blue,
                              foreground: G.white,
                              onTap: () => showBookingSheet(context, d, _extras),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.child, required this.onTap, required this.semantics});

  final Widget child;
  final VoidCallback onTap;
  final String semantics;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: semantics,
        child: Pressable(
          onTap: onTap,
          scale: .9,
          child: Glass(opacity: .2, child: SizedBox.square(dimension: 42, child: Center(child: child))),
        ),
      );
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.label, required this.background, required this.foreground, required this.onTap});

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Pressable(
        onTap: onTap,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(25)),
          child: Text(label, style: outfit(17, weight: FontWeight.w400, color: foreground)),
        ),
      );
}

List<List<dynamic>> extraIcon(Extra e) => switch (e) {
      Extra.ticket => HugeIcons.strokeRoundedTicket01,
      Extra.hotel => HugeIcons.strokeRoundedBuilding03,
      Extra.meal => HugeIcons.strokeRoundedCookie,
    };

String extraName(BuildContext context, Extra e) => switch (e) {
      Extra.ticket => context.l.extraTicket,
      Extra.hotel => context.l.extraHotel,
      Extra.meal => context.l.extraMeal,
    };

class ExtraChip extends StatelessWidget {
  const ExtraChip({super.key, required this.extra, required this.selected, required this.onTap});

  final Extra extra;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? G.blue : Colors.black;
    return Semantics(
      toggled: selected,
      button: true,
      child: Pressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          height: 36.7,
          padding: const EdgeInsets.fromLTRB(12, 0, 13, 0),
          decoration: BoxDecoration(
            color: selected ? G.blue.withValues(alpha: .08) : Colors.transparent,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: selected ? G.blue : G.line, width: selected ? 1.3 : 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ico(extraIcon(extra), size: 21, color: color),
              const SizedBox(width: 8),
              Text(extraName(context, extra), style: outfit(16, weight: FontWeight.w500, color: color)),
              AnimatedSize(
                duration: const Duration(milliseconds: 240),
                child: selected
                    ? const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.check_rounded, size: 17, color: G.blue),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
