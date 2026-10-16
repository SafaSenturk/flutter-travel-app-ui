import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/providers.dart';
import '../detail/detail_screen.dart';
import '../shell/shell.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final bookings = ref.watch(bookingsProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 14, G.pad, 20),
            child: Text(l.bookingsTitle, style: outfit(31, weight: FontWeight.w600, height: 1.26)),
          ),
        ),
        if (bookings.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, navHeight(context) + 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: G.blue.withValues(alpha: .1), shape: BoxShape.circle),
                    child: const Ico(HugeIcons.strokeRoundedAirplane01, size: 44, color: G.blue),
                  ),
                  const SizedBox(height: 18),
                  Text(l.bookingsEmpty, style: outfit(21, weight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(l.bookingsEmptyBody, textAlign: TextAlign.center, style: outfit(15, color: G.gray, height: 1.4)),
                  const SizedBox(height: 22),
                  Pressable(
                    onTap: () => ref.read(tabProvider.notifier).go(1),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: G.blue, borderRadius: BorderRadius.circular(25)),
                      child: Text(l.explore, style: outfit(16, weight: FontWeight.w500, color: G.white)),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(G.pad, 0, G.pad, navHeight(context) + 24),
            sliver: SliverList.separated(
              itemCount: bookings.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, i) => Reveal(
                key: ValueKey(bookings[i].id),
                index: i,
                child: _TripCard(booking: bookings[i]),
              ),
            ),
          ),
      ],
    );
  }
}

class _TripCard extends ConsumerWidget {
  const _TripCard({required this.booking});

  final Booking booking;

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l = context.l;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.cancelTrip, style: outfit(21, weight: FontWeight.w600)),
        content: Text(l.cancelTripQuestion(booking.destination.name.of(context.lang)), style: outfit(15, color: G.gray)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.keepTrip)),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.cancelTrip, style: const TextStyle(color: G.red)),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      ref.read(bookingsProvider.notifier).cancel(booking.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.tripCancelled)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final lang = context.lang;
    final d = booking.destination;
    final dates = DateFormat('d MMM', lang);
    final days = booking.checkIn.difference(DateUtils.dateOnly(DateTime.now())).inDays;
    return Pressable(
      scale: .98,
      onTap: () => Navigator.of(context).push(DetailScreen.route(d)),
      child: Container(
        decoration: BoxDecoration(
          color: G.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [BoxShadow(color: Color(0x0D0B1230), blurRadius: 20, offset: Offset(0, 8))],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
                    child: Image.asset(d.image, fit: BoxFit.cover, cacheWidth: 800),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Glass(
                      opacity: .3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text(
                          days <= 0 ? l.today : l.daysToGo(days),
                          style: outfit(13, weight: FontWeight.w500, color: G.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      tooltip: l.cancelTrip,
                      onPressed: () => _cancel(context, ref),
                      icon: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: .35), shape: BoxShape.circle),
                        child: const Icon(Icons.close_rounded, color: G.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(d.name.of(lang), style: outfit(20, weight: FontWeight.w600))),
                      Text(money(booking.total), style: outfit(20, weight: FontWeight.w600, color: G.blue)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 6,
                    children: [
                      _Meta(
                        icon: HugeIcons.strokeRoundedCalendar03,
                        text: '${dates.format(booking.checkIn)} – ${dates.format(booking.checkOut)}',
                      ),
                      _Meta(icon: HugeIcons.strokeRoundedMoon02, text: l.nights(booking.nights)),
                      _Meta(icon: HugeIcons.strokeRoundedUserGroup, text: l.guests(booking.guests)),
                      for (final e in booking.extras) _Meta(icon: extraIcon(e), text: extraName(context, e)),
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

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});

  final List<List<dynamic>> icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ico(icon, size: 17, color: G.gray),
          const SizedBox(width: 5),
          Text(text, style: outfit(14, color: G.gray)),
        ],
      );
}
