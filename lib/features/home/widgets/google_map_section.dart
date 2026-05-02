// lib/features/home/widgets/google_map_section.dart

import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:web/web.dart' as web;

import '../../../core/theme/app_theme.dart';

class GoogleMapSection extends StatelessWidget {
  const GoogleMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    const String viewID = 'google-maps-view';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewID,
      (int viewId) {
        final web.HTMLIFrameElement iframe = web.HTMLIFrameElement()
          ..width = '100%'
          ..height = '100%'
          // ✅ API KEY YOK → ÜCRETSİZ EMBED
          ..src =
              'https://www.google.com/maps?q=Serpil+Salas+Moda+ve+Dikim+Evi+Mudanya+Bursa&output=embed'
          ..style.border = 'none';

        return iframe;
      },
    );

    return Column(
      children: [
        const Text(
          "BİZE ULAŞIN",
          style: TextStyle(
            color: AppTheme.gold,
            fontSize: 13,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 10),

        const Text(
          "Atölyemizi Ziyaret Edin",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const SizedBox(height: 40),

        Container(
          height: 450,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.gold.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.gold.withValues(alpha: 0.1),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: const HtmlElementView(viewType: viewID),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Güzelyalı Yalı, Atatürk Cad. No:131, Mudanya/Bursa",
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),

        const SizedBox(height: 20),

        // 🔥 BONUS: YOL TARİFİ BUTONU
        ElevatedButton.icon(
          onPressed: () {
            web.window.open(
              'https://www.google.com/maps/dir/?api=1&destination=Serpil+Salas+Moda+ve+Dikim+Evi+Mudanya+Bursa',
              '_blank',
            );
          },
          icon: const Icon(Icons.directions),
          label: const Text("Yol Tarifi Al"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.gold,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }
}
