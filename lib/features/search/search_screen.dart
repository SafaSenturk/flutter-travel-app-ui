import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../detail/detail_screen.dart';

/// Matches a destination by name or country in either language.
List<Destination> searchDestinations(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return destinations;
  bool hit(Tr t) => t.en.toLowerCase().contains(q) || t.tr.toLowerCase().contains(q);
  return destinations.where((d) => hit(d.name) || hit(d.country)).toList();
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static Route<void> route() => PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 320),
        pageBuilder: (_, _, _) => const SearchScreen(),
        transitionsBuilder: (_, a, _, child) => FadeTransition(
          opacity: a,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, .04), end: Offset.zero).animate(a),
            child: child,
          ),
        ),
      );

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final lang = context.lang;
    final results = searchDestinations(_query);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 8, G.pad, 12),
            child: Row(
              children: [
                CircleBtn(
                  semantics: MaterialLocalizations.of(context).backButtonTooltip,
                  onTap: () => Navigator.of(context).pop(),
                  child: const Ico(HugeIcons.strokeRoundedArrowLeft01, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: G.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [BoxShadow(color: Color(0x0F0B1230), blurRadius: 18, offset: Offset(0, 6))],
                    ),
                    child: TextField(
                      autofocus: true,
                      style: outfit(16),
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: l.searchHint,
                        hintStyle: outfit(16, color: G.muted),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14, right: 8),
                          child: Ico(HugeIcons.strokeRoundedSearch01, size: 21, color: G.muted),
                        ),
                        prefixIconConstraints: const BoxConstraints(minWidth: 0),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(l.noResults(_query.trim()),
                          textAlign: TextAlign.center, style: outfit(16, color: G.gray)),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(G.pad, 4, G.pad, 24),
                    itemCount: results.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final d = results[i];
                      return Reveal(
                        key: ValueKey('$_query-${d.id}'),
                        index: i,
                        offset: 12,
                        child: Pressable(
                          onTap: () => Navigator.of(context).push(DetailScreen.route(d)),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: G.white, borderRadius: BorderRadius.circular(22)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(d.image, width: 68, height: 68, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(d.name.of(lang), style: outfit(17, weight: FontWeight.w600)),
                                      const SizedBox(height: 2),
                                      Row(children: [
                                        const Ico(HugeIcons.strokeRoundedLocation01, size: 15, color: G.muted),
                                        const SizedBox(width: 3),
                                        Text(d.country.of(lang), style: outfit(14, color: G.gray)),
                                        const SizedBox(width: 10),
                                        const Icon(Icons.star_rounded, size: 16, color: G.star),
                                        const SizedBox(width: 2),
                                        Text(d.rating.toStringAsFixed(1), style: outfit(14, color: G.gray)),
                                      ]),
                                    ],
                                  ),
                                ),
                                Text(money(d.price), style: outfit(17, weight: FontWeight.w600)),
                                Text(l.perNight, style: outfit(13, color: G.muted)),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
