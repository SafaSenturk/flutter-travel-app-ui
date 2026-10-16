import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../../state/providers.dart';
import 'detail_screen.dart';

Future<void> showBookingSheet(BuildContext context, Destination d, Set<Extra> extras) async {
  final booked = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => BookingSheet(destination: d, initialExtras: extras),
  );
  if (booked != true || !context.mounted) return;
  final viewTrips = await showDialog<bool>(context: context, builder: (_) => _BookedDialog(destination: d));
  if (viewTrips == true && context.mounted) {
    final container = ProviderScope.containerOf(context, listen: false);
    container.read(tabProvider.notifier).go(2);
    Navigator.of(context).popUntil((r) => r.isFirst);
  }
}

class BookingSheet extends ConsumerStatefulWidget {
  const BookingSheet({super.key, required this.destination, required this.initialExtras});

  final Destination destination;
  final Set<Extra> initialExtras;

  @override
  ConsumerState<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends ConsumerState<BookingSheet> {
  late final Set<Extra> _extras = {...widget.initialExtras};
  late final DateTime _today = DateUtils.dateOnly(DateTime.now());
  late DateTime _checkIn = _today.add(const Duration(days: 7));
  int _nights = 3;
  int _guests = 2;

  Destination get d => widget.destination;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final lang = context.lang;
    final total = bookingTotal(d, nights: _nights, guests: _guests, extras: _extras);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(G.pad, 0, G.pad, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(d.image, width: 56, height: 56, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.name.of(lang), style: outfit(21, weight: FontWeight.w600)),
                      Text('${d.country.of(lang)} · ${money(d.price)}${l.perNight}', style: outfit(14, color: G.gray)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(l.checkIn, style: outfit(16, weight: FontWeight.w600)),
            const SizedBox(height: 10),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final day = _today.add(Duration(days: i + 1));
                  final selected = DateUtils.isSameDay(day, _checkIn);
                  return Pressable(
                    onTap: () => setState(() => _checkIn = day),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 54,
                      decoration: BoxDecoration(
                        color: selected ? G.blue : G.bg,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat.E(lang).format(day),
                              style: outfit(13, color: selected ? G.white.withValues(alpha: .85) : G.muted)),
                          const SizedBox(height: 2),
                          Text('${day.day}',
                              style: outfit(20, weight: FontWeight.w600, color: selected ? G.white : G.ink)),
                          Text(DateFormat.MMM(lang).format(day),
                              style: outfit(11, color: selected ? G.white.withValues(alpha: .85) : G.muted)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            _Stepper(
              icon: HugeIcons.strokeRoundedMoon02,
              title: l.stay,
              value: l.nights(_nights),
              onMinus: _nights > 1 ? () => setState(() => _nights--) : null,
              onPlus: _nights < 14 ? () => setState(() => _nights++) : null,
            ),
            const SizedBox(height: 10),
            _Stepper(
              icon: HugeIcons.strokeRoundedUserGroup,
              title: l.travellers,
              value: l.guests(_guests),
              onMinus: _guests > 1 ? () => setState(() => _guests--) : null,
              onPlus: _guests < 8 ? () => setState(() => _guests++) : null,
            ),
            const SizedBox(height: 18),
            Text(l.extras, style: outfit(16, weight: FontWeight.w600)),
            const SizedBox(height: 6),
            for (final e in Extra.values)
              _ExtraRow(
                extra: e,
                selected: _extras.contains(e),
                price: extraPrice(e, nights: _nights, guests: _guests),
                onTap: () => setState(() => _extras.contains(e) ? _extras.remove(e) : _extras.add(e)),
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.total, style: outfit(14, color: G.gray)),
                      TweenAnimationBuilder<double>(
                        tween: Tween(end: total.toDouble()),
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        builder: (context, v, _) => Text(money(v.round()), style: outfit(28, weight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 196,
                  child: Pressable(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      ref.read(bookingsProvider.notifier).add(
                            destination: d,
                            checkIn: _checkIn,
                            nights: _nights,
                            guests: _guests,
                            extras: {..._extras},
                          );
                      Navigator.of(context).pop(true);
                    },
                    child: Container(
                      height: 54,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: G.blue, borderRadius: BorderRadius.circular(27)),
                      child: Text(l.confirmBooking, style: outfit(17, weight: FontWeight.w500, color: G.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.icon, required this.title, required this.value, this.onMinus, this.onPlus});

  final List<List<dynamic>> icon;
  final String title;
  final String value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
        decoration: BoxDecoration(color: G.bg, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Ico(icon, size: 22, color: G.gray),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: outfit(15, color: G.gray))),
            _RoundIcon(icon: Icons.remove_rounded, onTap: onMinus),
            SizedBox(
              width: 92,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, a) => ScaleTransition(scale: a, child: FadeTransition(opacity: a, child: child)),
                child: Text(value, key: ValueKey(value), textAlign: TextAlign.center, style: outfit(16, weight: FontWeight.w600)),
              ),
            ),
            _RoundIcon(icon: Icons.add_rounded, onTap: onPlus),
          ],
        ),
      );
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Pressable(
        onTap: onTap,
        scale: .88,
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(color: G.white, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: onTap == null ? G.line : G.ink),
        ),
      );
}

class _ExtraRow extends StatelessWidget {
  const _ExtraRow({required this.extra, required this.selected, required this.price, required this.onTap});

  final Extra extra;
  final bool selected;
  final int price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final (name, hint) = switch (extra) {
      Extra.ticket => (l.extraTicketLong, l.extraTicketHint),
      Extra.hotel => (l.extraHotelLong, l.extraHotelHint),
      Extra.meal => (l.extraMealLong, l.extraMealHint),
    };
    return Pressable(
      onTap: onTap,
      scale: .98,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected ? G.blue : G.bg,
                shape: BoxShape.circle,
              ),
              child: Center(child: Ico(extraIcon(extra), size: 20, color: selected ? G.white : G.ink)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: outfit(15, weight: FontWeight.w500)),
                  Text(hint, style: outfit(13, color: G.muted)),
                ],
              ),
            ),
            Text('+${money(price)}', style: outfit(15, weight: FontWeight.w600, color: selected ? G.blue : G.muted)),
            const SizedBox(width: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                selected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                key: ValueKey(selected),
                color: selected ? G.blue : G.line,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookedDialog extends StatelessWidget {
  const _BookedDialog({required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.elasticOut,
              builder: (context, s, child) => Transform.scale(scale: s, child: child),
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(color: G.blue.withValues(alpha: .12), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: G.blue, size: 48),
              ),
            ),
            const SizedBox(height: 18),
            Text(l.bookedTitle, style: outfit(24, weight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              l.bookedBody(destination.name.of(context.lang)),
              textAlign: TextAlign.center,
              style: outfit(15, color: G.gray, height: 1.4),
            ),
            const SizedBox(height: 22),
            Pressable(
              onTap: () => Navigator.of(context).pop(true),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: G.blue, borderRadius: BorderRadius.circular(25)),
                child: Text(l.viewTrips, style: outfit(16, weight: FontWeight.w500, color: G.white)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l.done, style: outfit(15, color: G.gray)),
            ),
          ],
        ),
      ),
    );
  }
}
