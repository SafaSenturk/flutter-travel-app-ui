import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/destinations.dart';
import '../detail/detail_screen.dart';

Future<void> showNotifications(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final l = context.l;
        final items = [
          (HugeIcons.strokeRoundedDiscount, l.notif1Title, l.notif1Body, G.blue, 'lake_como'),
          (HugeIcons.strokeRoundedAirplane01, l.notif2Title, l.notif2Body, const Color(0xFFF08A24), 'cappadocia'),
          (HugeIcons.strokeRoundedFavourite, l.notif3Title, l.notif3Body, G.red, null),
        ];
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(G.pad, 0, G.pad, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.notifications, style: outfit(22, weight: FontWeight.w600)),
                const SizedBox(height: 12),
                for (final (i, (icon, title, body, color, target)) in items.indexed)
                  Reveal(
                    index: i,
                    offset: 14,
                    child: Pressable(
                      onTap: target == null
                          ? null
                          : () {
                              Navigator.of(context)
                                ..pop()
                                ..push(DetailScreen.route(destinationById(target)));
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: color.withValues(alpha: .12), shape: BoxShape.circle),
                              child: Ico(icon, color: color, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title, style: outfit(16, weight: FontWeight.w600)),
                                  const SizedBox(height: 3),
                                  Text(body, style: outfit(14, color: G.gray, height: 1.35)),
                                ],
                              ),
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
      },
    );
