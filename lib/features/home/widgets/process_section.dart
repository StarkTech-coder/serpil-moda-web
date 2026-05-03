import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {'icon': Icons.calendar_month_outlined, 'title': 'Appointment'},
      {'icon': Icons.straighten_outlined, 'title': 'Measurement'},
      {'icon': Icons.auto_fix_high_outlined, 'title': 'Fitting'},
      {'icon': Icons.card_giftcard_outlined, 'title': 'Delivery'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers the entire structure
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            // Step Card (Icon and Text)
            Column(
              children: [
                Icon(steps[i]['icon'], color: AppTheme.gold, size: 40),
                const SizedBox(height: 15),
                Text(
                  steps[i]['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // If it is not the last step, add an arrow icon to represent transition
            if (i < steps.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Icon(
                  Icons.keyboard_double_arrow_right_rounded,
                  color: AppTheme.gold.withValues(alpha: 0.5),
                  size: 24,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
