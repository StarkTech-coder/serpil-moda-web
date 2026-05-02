import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {'icon': Icons.calendar_month_outlined, 'title': 'Randevu'},
      {'icon': Icons.straighten_outlined, 'title': 'Ölçü Alımı'},
      {'icon': Icons.auto_fix_high_outlined, 'title': 'Prova'},
      {'icon': Icons.card_giftcard_outlined, 'title': 'Teslimat'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Tüm yapıyı ortalar
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            // Adım Kartı (İkon ve Yazı)
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

            // Eğer son adım değilse, bir sonraki adıma geçişi temsil eden oku ekle
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
