import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Visit;

class VisitsCard extends StatelessWidget {
  const VisitsCard({
    required this.visit,
    super.key,
  });

  final Visit? visit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 6,
              children: [
                Text(
                  visit?.location ?? '',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    visit?.status ?? '',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  color: WidgetStatePropertyAll(
                    (visit?.status ?? '').toColor(),
                  ),
                ),
              ],
            ),
            Text(
              visit?.notes ?? '',
              maxLines: 4,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'activities ',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        text: '${visit?.activitiesDone?.length ?? 0}',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMEd().format(
                    DateTime.parse(
                      visit?.visitDate ?? DateTime.now().toIso8601String(),
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

extension StringColorExtension on String {
  Color toColor({int alpha = 160}) {
    final hash = hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = hash & 0x0000FF;
    return Color.fromARGB(alpha.clamp(0, 255), r, g, b);
  }
}
