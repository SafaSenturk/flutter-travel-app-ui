import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/providers.dart';
import '../profile/profile_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    void goTab(int i) {
      Navigator.pop(context);
      ref.read(tabProvider.notifier).go(i);
    }

    return Drawer(
      backgroundColor: G.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 8, G.pad, Insets.bottom(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.appName, style: outfit(34, weight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(l.onb3Sub, style: outfit(15, color: G.muted)),
            const SizedBox(height: 28),
            _Item(icon: HugeIcons.strokeRoundedMapsSearch, label: l.navDiscover, onTap: () => goTab(1)),
            _Item(icon: HugeIcons.strokeRoundedCalendar03, label: l.bookingsTitle, onTap: () => goTab(2)),
            _Item(icon: HugeIcons.strokeRoundedUser, label: l.navProfile, onTap: () => goTab(3)),
            _Item(
              icon: HugeIcons.strokeRoundedSlidersHorizontal,
              label: l.replayIntro,
              onTap: () {
                Navigator.pop(context);
                ref.read(onboardedProvider.notifier).reset();
              },
            ),
            _Item(
              icon: HugeIcons.strokeRoundedInformationCircle,
              label: l.about,
              onTap: () {
                Navigator.pop(context);
                showAbout(context);
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(child: Text(l.language, style: outfit(16, weight: FontWeight.w500))),
                const LanguageSwitch(),
              ],
            ),
            const SizedBox(height: 16),
            Text(l.designBy, style: outfit(13, color: G.muted)),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.icon, required this.label, required this.onTap});

  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Pressable(
        onTap: onTap,
        scale: .98,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Ico(icon, size: 22),
              const SizedBox(width: 14),
              Text(label, style: outfit(17)),
            ],
          ),
        ),
      );
}
