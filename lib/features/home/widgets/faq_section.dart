// widgets/faq_section.dart
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart'; // Required for AppTheme constants

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Text("FREQUENTLY ASKED QUESTIONS",
              style: TextStyle(color: AppTheme.gold, letterSpacing: 3)),
          const SizedBox(height: 20),
          _buildFAQTile("How long does custom tailoring take?",
              "Depending on the complexity of the design, it takes between 2-4 weeks."),
          _buildFAQTile("Do you offer alterations?",
              "Yes, all kinds of evening dress and wedding dress alterations are performed by expert hands."),
        ],
      ),
    );
  }

  Widget _buildFAQTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content, style: const TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}
