import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/providers.dart';
import '../shell/shell.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final name = ref.watch(nameProvider);
    final favs = ref.watch(favoritesProvider);
    final bookings = ref.watch(bookingsProvider);
    final countries = {for (final b in bookings) b.destination.country.en}.length;
    return ListView(
      padding: EdgeInsets.fromLTRB(G.pad, Insets.top(context) + 14, G.pad, navHeight(context) + 24),
      children: [
        Text(l.profileTitle, style: outfit(31, weight: FontWeight.w600, height: 1.26)),
        const SizedBox(height: 22),
        Reveal(
          index: 0,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: G.white, borderRadius: BorderRadius.circular(28)),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color(0xFF35A7F0), G.blue]),
                  ),
                  child: Text(name.characters.first.toUpperCase(),
                      style: outfit(28, weight: FontWeight.w600, color: G.white)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: outfit(22, weight: FontWeight.w600)),
                      Text(l.explorer, style: outfit(15, color: G.muted)),
                    ],
                  ),
                ),
                CircleBtn(
                  semantics: l.editName,
                  onTap: () => _editName(context, ref, name),
                  child: const Ico(HugeIcons.strokeRoundedPencilEdit02, size: 20),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Reveal(
          index: 1,
          child: Row(
            children: [
              _Stat(value: favs.length, label: l.favorites, color: G.red),
              const SizedBox(width: 12),
              _Stat(value: bookings.length, label: l.trips, color: G.blue),
              const SizedBox(width: 12),
              _Stat(value: countries, label: l.countries, color: const Color(0xFFF08A24)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Reveal(
          index: 2,
          child: Container(
            decoration: BoxDecoration(color: G.white, borderRadius: BorderRadius.circular(28)),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                _Row(
                  icon: HugeIcons.strokeRoundedLanguageSkill,
                  title: l.language,
                  trailing: const LanguageSwitch(),
                ),
                _Row(
                  icon: HugeIcons.strokeRoundedSlidersHorizontal,
                  title: l.replayIntro,
                  onTap: () => ref.read(onboardedProvider.notifier).reset(),
                ),
                _Row(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  title: l.about,
                  onTap: () => showAbout(context),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Center(child: Text(l.designBy, style: outfit(13, color: G.muted))),
      ],
    );
  }

  Future<void> _editName(BuildContext context, WidgetRef ref, String current) async {
    final l = context.l;
    final controller = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.editName, style: outfit(21, weight: FontWeight.w600)),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l.name),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: Text(l.save)),
        ],
      ),
    );
    controller.dispose();
    if (result != null) ref.read(nameProvider.notifier).set(result);
  }
}

Future<void> showAbout(BuildContext context) => showDialog<void>(
      context: context,
      builder: (context) {
        final l = context.l;
        return AlertDialog(
          title: Text(l.appName, style: outfit(24, weight: FontWeight.w600)),
          content: Text(l.aboutBody, style: outfit(15, color: G.gray, height: 1.45)),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l.done))],
        );
      },
    );

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = context.lang;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: G.bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final code in ['en', 'tr'])
            GestureDetector(
              onTap: () => ref.read(localeProvider.notifier).set(Locale(code)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: current == code ? G.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Text(code.toUpperCase(),
                    style: outfit(14, weight: FontWeight.w600, color: current == code ? G.white : G.gray)),
              ),
            ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: G.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value.toDouble()),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (context, v, _) => Text('${v.round()}', style: outfit(26, weight: FontWeight.w600, color: color)),
              ),
              Text(label, style: outfit(13, color: G.muted)),
            ],
          ),
        ),
      );
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.title, this.trailing, this.onTap});

  final List<List<dynamic>> icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: G.bg, shape: BoxShape.circle),
                child: Ico(icon, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(title, style: outfit(16, weight: FontWeight.w500))),
              trailing ?? const Ico(HugeIcons.strokeRoundedArrowRight01, size: 20, color: G.muted),
            ],
          ),
        ),
      );
}
